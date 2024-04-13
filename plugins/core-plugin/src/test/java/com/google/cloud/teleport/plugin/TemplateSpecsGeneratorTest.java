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
package com.google.cloud.teleport.plugin;

import static com.google.cloud.teleport.metadata.util.EnumBasedExperimentValueProvider.STREAMING_MODE_ENUM_BASED_EXPERIMENT_VALUE_PROVIDER;
import static com.google.common.base.Preconditions.checkArgument;
import static com.google.common.truth.Truth.assertThat;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import com.google.cloud.teleport.metadata.Template;
import com.google.cloud.teleport.metadata.TemplateCategory;
import com.google.cloud.teleport.plugin.model.ImageSpec;
import com.google.cloud.teleport.plugin.model.ImageSpecMetadata;
import com.google.cloud.teleport.plugin.model.TemplateDefinitions;
import com.google.cloud.teleport.plugin.sample.AtoBOk;
import com.google.common.io.Files;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

/** Tests for class {@link TemplateSpecsGenerator}. */
@RunWith(JUnit4.class)
public class TemplateSpecsGeneratorTest {

  private static final Gson GSON = new GsonBuilder().create();

  private final TemplateDefinitions definitions =
      new TemplateDefinitions(AtoBOk.class, AtoBOk.class.getAnnotation(Template.class));
  private final ImageSpec imageSpec = definitions.buildSpecModel(false);
  private final File outputFolder = Files.createTempDir().getAbsoluteFile();
  private final TemplateSpecsGenerator generator = new TemplateSpecsGenerator();
  private static final boolean SUPPORTS_AT_LEAST_ONCE_DEFAULT = false;
  private static final boolean SUPPORTS_EXACTLY_ONCE_DEFAULT = true;
  private static final String DEFAULT_STREAMING_MODE = Template.StreamingMode.UNSPECIFIED.name();
  private static final String ADDITIONAL_EXPERIMENTS = "additionalExperiments";
  private static final String EXPERIMENT_AT_LEAST_ONCE =
      STREAMING_MODE_ENUM_BASED_EXPERIMENT_VALUE_PROVIDER.convert(
          Template.StreamingMode.AT_LEAST_ONCE);
  private static final String EXPERIMENT_EXACTLY_ONCE =
      STREAMING_MODE_ENUM_BASED_EXPERIMENT_VALUE_PROVIDER.convert(
          Template.StreamingMode.EXACTLY_ONCE);

  @Test
  public void saveImageSpec() throws IOException {
    File saveImageSpec = generator.saveImageSpec(definitions, imageSpec, outputFolder);
    assertNotNull(saveImageSpec);
    assertTrue(saveImageSpec.exists());

    try (FileInputStream fis = new FileInputStream(saveImageSpec)) {
      String json = new String(fis.readAllBytes(), StandardCharsets.UTF_8);
      ImageSpec read = GSON.fromJson(json, ImageSpec.class);
      assertEquals(imageSpec.getMetadata().getName(), read.getMetadata().getName());
      assertEquals(imageSpec.getMetadata().getParameter("hiddenParam").get().hiddenUi(), true);
    }
  }

  @Test
  public void saveMetadata() throws IOException {
    ImageSpecMetadata metadata = imageSpec.getMetadata();
    File saveMetadata = generator.saveMetadata(definitions, metadata, outputFolder);
    assertNotNull(saveMetadata);
    assertTrue(saveMetadata.exists());

    try (FileInputStream fis = new FileInputStream(saveMetadata)) {
      ImageSpecMetadata read =
          GSON.fromJson(
              new String(fis.readAllBytes(), StandardCharsets.UTF_8), ImageSpecMetadata.class);
      assertEquals(metadata.getName(), read.getName());
    }
  }

  @Test
  public void saveCommandSpec() throws IOException {
    File spec = generator.saveCommandSpec(definitions, outputFolder);
    assertNotNull(spec);
    assertTrue(spec.exists());

    try (FileInputStream fis = new FileInputStream(spec)) {
      String specString = new String(fis.readAllBytes(), StandardCharsets.UTF_8);
      assertTrue(specString.contains(definitions.getTemplateClass().getName()));
    }
  }

  @Test
  public void getTemplateNameDash() {
    assertEquals("cloud-pubsub-to-text", generator.getTemplateNameDash("Cloud PubSub to Text"));
    assertEquals("cloud-pubsub-to-text", generator.getTemplateNameDash("Cloud_PubSub_to_Text"));
  }

  @Test
  public void givenStreamingModeDefaults_templateInherits() throws IOException {
    TemplateDefinitions definitions = templateDefinitionsOf(LegacyALONullEONullSMNull.class);
    ImageSpec spec = buildAndSave(definitions);
    ImageSpecMetadata metadata = buildAndSave(definitions, spec);
    assertThat(metadata.isSupportsAtLeastOnce()).isEqualTo(SUPPORTS_AT_LEAST_ONCE_DEFAULT);
    assertThat(metadata.isSupportsExactlyOnce()).isEqualTo(SUPPORTS_EXACTLY_ONCE_DEFAULT);
    assertThat(metadata.getDefaultStreamingMode()).isEqualTo(DEFAULT_STREAMING_MODE);

    definitions = templateDefinitionsOf(FlexALONullEONullSMNull.class);
    spec = buildAndSave(definitions);
    metadata = buildAndSave(definitions, spec);
    assertThat(metadata.isSupportsAtLeastOnce()).isEqualTo(SUPPORTS_AT_LEAST_ONCE_DEFAULT);
    assertThat(metadata.isSupportsExactlyOnce()).isEqualTo(SUPPORTS_EXACTLY_ONCE_DEFAULT);
    assertThat(metadata.getDefaultStreamingMode()).isEqualTo(DEFAULT_STREAMING_MODE);
  }

  @Test
  public void givenStreamingModeNotUnspecified_experimentsApplied() throws IOException {
    TemplateDefinitions definitions = templateDefinitionsOf(LegacyALOTrueEONullSMALO.class);
    ImageSpec spec = buildAndSave(definitions);
    Map<String, Object> environment = spec.getDefaultEnvironment();
    assertThat(environment).isNotNull();
    assertThat(environment.containsKey(ADDITIONAL_EXPERIMENTS)).isTrue();

    @SuppressWarnings("unchecked")
    List<String> experiments = (List<String>) environment.get(ADDITIONAL_EXPERIMENTS);
    assertThat(experiments).isNotNull();
    assertThat(experiments).contains(EXPERIMENT_AT_LEAST_ONCE);
  }

  private static TemplateDefinitions templateDefinitionsOf(Class<?> clazz) {
    checkArgument(clazz.isAnnotationPresent(Template.class));
    return new TemplateDefinitions(clazz, clazz.getAnnotation(Template.class));
  }

  private ImageSpec buildAndSave(TemplateDefinitions definitions) throws IOException {
    File file =
        generator.saveImageSpec(definitions, definitions.buildSpecModel(false), outputFolder);
    assertNotNull(file);
    assertTrue(file.exists());
    try (FileReader reader = new FileReader(file)) {
      return GSON.fromJson(reader, ImageSpec.class);
    }
  }

  private ImageSpecMetadata buildAndSave(TemplateDefinitions definitions, ImageSpec spec)
      throws IOException {
    File file = generator.saveMetadata(definitions, spec.getMetadata(), outputFolder);
    assertNotNull(file);
    assertTrue(file.exists());
    try (FileReader reader = new FileReader(file)) {
      return GSON.fromJson(reader, ImageSpecMetadata.class);
    }
  }

  @Template(
      name = "LegacyALONullEONullSMNull",
      displayName = "",
      description = "",
      category = TemplateCategory.LEGACY)
  static class LegacyALONullEONullSMNull {}

  @Template(
      supportsAtLeastOnce = false,
      name = "LegacyALOFalseEONullSMNull",
      displayName = "",
      description = "",
      category = TemplateCategory.LEGACY)
  static class LegacyALOFalseEONullSMNull {}

  @Template(
      supportsAtLeastOnce = true,
      name = "LegacyALOTrueEONullSMNull",
      displayName = "",
      description = "",
      category = TemplateCategory.LEGACY)
  static class LegacyALOTrueEONullSMNull {}

  @Template(
      supportsExactlyOnce = false,
      name = "LegacyALONullEOFalseSMNull",
      displayName = "",
      description = "",
      category = TemplateCategory.LEGACY)
  static class LegacyALONullEOFalseSMNull {}

  @Template(
      supportsExactlyOnce = true,
      name = "LegacyALONullEOTrueSMNull",
      displayName = "",
      description = "",
      category = TemplateCategory.LEGACY)
  static class LegacyALONullEOTrueSMNull {}

  @Template(
      defaultStreamingMode = Template.StreamingMode.UNSPECIFIED,
      name = "LegacyALONullEONullSMFalse",
      displayName = "",
      description = "",
      category = TemplateCategory.LEGACY)
  static class LegacyALONullEONullSMFalse {}

  @Template(
      defaultStreamingMode = Template.StreamingMode.AT_LEAST_ONCE,
      name = "LegacyALONullEONullSMALO",
      displayName = "",
      description = "",
      category = TemplateCategory.LEGACY)
  static class LegacyALONullEONullSMALO {}

  @Template(
      defaultStreamingMode = Template.StreamingMode.EXACTLY_ONCE,
      name = "LegacyALONullEONullSMEO",
      displayName = "",
      description = "",
      category = TemplateCategory.LEGACY)
  static class LegacyALONullEONullSMEO {}

  @Template(
      supportsAtLeastOnce = true,
      defaultStreamingMode = Template.StreamingMode.AT_LEAST_ONCE,
      name = "LegacyALOTrueEONullSMALO",
      displayName = "",
      description = "",
      category = TemplateCategory.LEGACY)
  static class LegacyALOTrueEONullSMALO {}

  @Template(
      name = "FlexALONullEONullSMNull",
      displayName = "",
      description = "",
      category = TemplateCategory.STREAMING)
  static class FlexALONullEONullSMNull {}

  @Template(
      name = "FlexALOFalseEONullSMNull",
      displayName = "",
      description = "",
      category = TemplateCategory.STREAMING)
  static class FlexALOFalseEONullSMNull {}

  @Template(
      name = "FlexALOTrueEONullSMNull",
      displayName = "",
      description = "",
      category = TemplateCategory.STREAMING)
  static class FlexALOTrueEONullSMNull {}

  @Template(
      name = "FlexALONullEOFalseSMNull",
      displayName = "",
      description = "",
      category = TemplateCategory.STREAMING)
  static class FlexALONullEOFalseSMNull {}

  @Template(
      name = "FlexALONullEOTrueSMNull",
      displayName = "",
      description = "",
      category = TemplateCategory.STREAMING)
  static class FlexALONullEOTrueSMNull {}

  @Template(
      name = "FlexALONullEONullSMFalse",
      displayName = "",
      description = "",
      category = TemplateCategory.STREAMING)
  static class FlexALONullEONullSMFalse {}

  @Template(
      name = "FlexALONullEONullSMALO",
      displayName = "",
      description = "",
      category = TemplateCategory.STREAMING)
  static class FlexALONullEONullSMALO {}

  @Template(
      name = "FlexALONullEONullSM_EO",
      displayName = "",
      description = "",
      category = TemplateCategory.STREAMING)
  static class FlexALONullEONullSMEO {}
}
