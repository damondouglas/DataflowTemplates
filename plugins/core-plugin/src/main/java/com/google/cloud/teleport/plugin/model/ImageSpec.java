/*
 * Copyright (C) 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package com.google.cloud.teleport.plugin.model;

import static com.google.common.base.Preconditions.checkState;
import static org.apache.beam.sdk.util.Preconditions.checkStateNotNull;

import com.google.cloud.teleport.metadata.Template;
import com.google.common.collect.ImmutableSet;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/** Image Spec Model. The main payload to communicate parameters to the Dataflow UI. */
public class ImageSpec {

  private String image;
  private ImageSpecMetadata metadata;
  private SdkInfo sdkInfo;
  private Map<String, Object> defaultEnvironment;

  public String getImage() {
    return image;
  }

  public void setImage(String image) {
    this.image = image;
  }

  public ImageSpecMetadata getMetadata() {
    return metadata;
  }

  public void setMetadata(ImageSpecMetadata metadata) {
    this.metadata = metadata;
  }

  public SdkInfo getSdkInfo() {
    return sdkInfo;
  }

  public void setSdkInfo(SdkInfo sdkInfo) {
    this.sdkInfo = sdkInfo;
  }

  public Map<String, Object> getDefaultEnvironment() {
    return defaultEnvironment;
  }

  public void setDefaultEnvironment(Map<String, Object> defaultEnvironment) {
    this.defaultEnvironment = defaultEnvironment;
  }

  public void setAdditionalUserLabel(String label, String value) {
    if (defaultEnvironment == null) {
      defaultEnvironment = new HashMap<>();
    }

    @SuppressWarnings("unchecked")
    Map<String, String> labels =
        (Map<String, String>)
            defaultEnvironment.computeIfAbsent(
                "additionalUserLabels", k -> new HashMap<String, String>());

    labels.put(label, value);
  }

  public void validate() {
    // TODO: what else can be validated here?
    ImageSpecMetadata metadata = getMetadata();
    if (metadata == null) {
      throw new IllegalArgumentException("Image metadata is not specified.");
    }

    if (metadata.getName() == null || metadata.getName().isEmpty()) {
      throw new IllegalArgumentException("Template name can not be empty.");
    }
    if (metadata.getDescription() == null || metadata.getDescription().isEmpty()) {
      throw new IllegalArgumentException("Template description can not be empty.");
    }

    for (ImageSpecParameter parameter : metadata.getParameters()) {
      parameter.validate();
    }
  }

  public ImageSpec withMappedExperiments() {
    mapStreamingModeExperiments();
    return this;
  }

  private void mapStreamingModeExperiments() {
    if (metadata.getDefaultStreamingMode().equals(Template.StreamingMode.UNSPECIFIED.name())) {
      return;
    }
    String streamingMode = metadata.getDefaultStreamingMode();
    ;
    Set<Experiments.Experiment> allowed = allowedStreamingModeExperiments();
    checkState(
        allowed.stream().noneMatch(exp -> exp.getValue().equals(streamingMode)),
        String.format(
            "defaultStreamingMode: %s mismatch with supported availability: %s",
            streamingMode,
            allowed.stream()
                .map(Experiments.Experiment::getValue)
                .collect(Collectors.joining(", "))));

    Experiments.Experiment streamingModeExperiment =
        checkStateNotNull(Experiments.STREAMING_MODE_EXPERIMENT_MAP.get(streamingMode));
    Experiments.builder()
        .setExperiments(ImmutableSet.of(streamingModeExperiment))
        .build()
        .apply(this);
  }

  private Set<Experiments.Experiment> allowedStreamingModeExperiments() {
    Set<Experiments.Experiment> result = new HashSet<>();
    if (getMetadata().isSupportsAtLeastOnce()) {
      result.add(Experiments.STREAM_MODE_AT_LEAST_ONCE);
    }
    if (getMetadata().isSupportsExactlyOnce()) {
      result.add(Experiments.STREAM_MODE_EXACTLY_ONCE);
    }
    return result;
  }
}
