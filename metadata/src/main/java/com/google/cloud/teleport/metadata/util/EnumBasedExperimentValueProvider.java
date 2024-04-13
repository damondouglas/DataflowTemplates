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
package com.google.cloud.teleport.metadata.util;

import static com.google.common.base.Preconditions.checkArgument;

import com.google.cloud.teleport.metadata.Template;
import com.google.common.base.CaseFormat;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class EnumBasedExperimentValueProvider<T extends Enum<T>> {

  public static final EnumBasedExperimentValueProvider<Template.StreamingMode>
      STREAMING_MODE_ENUM_BASED_EXPERIMENT_VALUE_PROVIDER =
          of(Template.StreamingMode.class, Template.StreamingMode.UNSPECIFIED);

  public static <T extends Enum<T>> EnumBasedExperimentValueProvider<T> of(
      Class<T> clazz, T... ignored) {
    return new EnumBasedExperimentValueProvider<>(clazz, ignored);
  }

  private final Class<T> clazz;
  private final String prefix;
  private final Set<T> invalid = new HashSet<>();

  @SafeVarargs
  private EnumBasedExperimentValueProvider(Class<T> clazz, T... ignored) {
    this.clazz = clazz;
    this.prefix = CaseFormat.LOWER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, clazz.getSimpleName());
    invalid.addAll(Arrays.asList(ignored));
  }

  public String getPrefix() {
    return this.prefix;
  }

  public String convert(T value) {
    checkArgument(
        !invalid.contains(value),
        String.format(
            "%s is not a valid value for use with %s",
            value, EnumBasedExperimentValueProvider.class));
    String suffix = CaseFormat.UPPER_UNDERSCORE.to(CaseFormat.LOWER_UNDERSCORE, value.name());
    return prefix + "_" + suffix;
  }
}
