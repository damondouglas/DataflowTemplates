/*
 * Copyright (C) 2024 Google LLC
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

import com.google.auto.value.AutoValue;
import com.google.cloud.teleport.metadata.Template;
import com.google.common.collect.ImmutableMap;
import com.google.common.collect.ImmutableSet;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

@AutoValue
abstract class Experiments {

  private static final String STREAMING_MODE_EXACTLY_ONCE_VALUE = "streaming_mode_exactly_once";

  private static final String STREAMING_MODE_AT_LEAST_ONCE_VALUE = "streaming_mode_at_least_once";

  static final Experiment STREAM_MODE_EXACTLY_ONCE =
      Experiment.builder()
          .setValue(STREAMING_MODE_EXACTLY_ONCE_VALUE)
          .setReplaces(ImmutableSet.of(STREAMING_MODE_AT_LEAST_ONCE_VALUE))
          .build();

  static final Experiment STREAM_MODE_AT_LEAST_ONCE =
      Experiment.builder()
          .setValue(STREAMING_MODE_AT_LEAST_ONCE_VALUE)
          .setReplaces(ImmutableSet.of(STREAMING_MODE_EXACTLY_ONCE_VALUE))
          .build();

  static final Map<String, Experiment> STREAMING_MODE_EXPERIMENT_MAP =
      ImmutableMap.of(
          Template.StreamingMode.EXACTLY_ONCE.name(), STREAM_MODE_EXACTLY_ONCE,
          Template.StreamingMode.AT_LEAST_ONCE.name(), STREAM_MODE_AT_LEAST_ONCE);

  private static final String ADDITIONAL_EXPERIMENTS = "additionalExperiments";

  static Builder builder() {
    return new AutoValue_Experiments.Builder();
  }

  void apply(ImageSpec spec) {
    if (getExperiments().isEmpty()) {
      return;
    }
    if (spec.getDefaultEnvironment() == null) {
      spec.setDefaultEnvironment(new HashMap<>());
    }

    HashSet<String> experiments = getOrCreateExperiments(spec);

    updateEnvironment(spec, experiments);
  }

  private void updateEnvironment(ImageSpec spec, Set<String> experiments) {
    Map<String, Object> environment = checkStateNotNull(spec.getDefaultEnvironment());
    merge(experiments, getExperiments());
    environment.put(ADDITIONAL_EXPERIMENTS, experiments);
    spec.setDefaultEnvironment(environment);
  }

  @SuppressWarnings({"unchecked"})
  private HashSet<String> getOrCreateExperiments(ImageSpec spec) {
    Map<String, Object> environment = checkStateNotNull(spec.getDefaultEnvironment());

    if (!environment.containsKey(ADDITIONAL_EXPERIMENTS)) {
      environment.put(ADDITIONAL_EXPERIMENTS, new HashSet<>());
    }
    Object hashSetObj = environment.get(ADDITIONAL_EXPERIMENTS);
    checkState(hashSetObj instanceof HashSet);

    return (HashSet<String>) hashSetObj;
  }

  abstract Set<Experiment> getExperiments();

  @AutoValue.Builder
  abstract static class Builder {
    abstract Builder setExperiments(Set<Experiment> experiments);

    abstract Optional<Set<Experiment>> getExperiments();

    abstract Experiments autoBuild();

    final Experiments build() {
      if (getExperiments().isEmpty()) {
        setExperiments(Collections.emptySet());
      }
      return autoBuild();
    }
  }

  @AutoValue
  abstract static class Experiment {

    static Builder builder() {
      return new AutoValue_Experiments_Experiment.Builder();
    }

    abstract String getValue();

    abstract Set<String> getReplaces();

    @AutoValue.Builder
    abstract static class Builder {

      abstract Builder setValue(String value);

      abstract Builder setReplaces(Set<String> replaces);

      abstract Optional<Set<String>> getReplaces();

      abstract Experiment autoBuild();

      final Experiment build() {
        if (getReplaces().isEmpty()) {
          setReplaces(Collections.emptySet());
        }
        return autoBuild();
      }
    }
  }

  private static void merge(Set<String> experimentsStr, Set<Experiment> experimentsObj) {
    for (Experiment experiment : experimentsObj) {
      experimentsStr.removeAll(experiment.getReplaces());
      experimentsStr.add(experiment.getValue());
    }
  }
}
