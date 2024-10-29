

# Autogenerated file. DO NOT EDIT.
#
# Copyright (C) 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
#


variable "on_delete" {
  type        = string
  description = "One of \"drain\" or \"cancel\". Specifies behavior of deletion during terraform destroy."
}

variable "project" {
  type        = string
  description = "The Google Cloud Project ID within which this module provisions resources."
}

variable "region" {
  type        = string
  description = "The region in which the created job should run."
}

variable "outputFileFormat" {
  type        = string
  description = "The format of the output Cloud Storage file. Allowed formats are TEXT, AVRO. Defaults to AVRO."
  default     = null
}

variable "windowDuration" {
  type        = string
  description = "The window duration/size in which data will be written to Cloud Storage. Allowed formats are: Ns (for seconds, example: 5s), Nm (for minutes, example: 12m), Nh (for hours, example: 2h). (Example: 1h). Defaults to: 1h."
  default     = null
}

variable "bigtableMetadataTableTableId" {
  type        = string
  description = "Table ID used for creating the metadata table."
  default     = null
}

variable "schemaOutputFormat" {
  type        = string
  description = "Schema chosen for outputting data to GCS. CHANGELOG_ENTRY support TEXT and AVRO output formats, BIGTABLE_ROW only supports AVRO output. Defaults to: CHANGELOG_ENTRY."
  default     = null
}

variable "gcsOutputDirectory" {
  type        = string
  description = "The path and filename prefix for writing output files. Must end with a slash. DateTime formatting is used to parse directory path for date & time formatters. (Example: gs://your-bucket/your-path)"

}

variable "outputFilenamePrefix" {
  type        = string
  description = <<EOT
The prefix to place on each windowed file. Defaults to "changelog-" (Example: changelog-)
EOT
  default     = null
}

variable "outputBatchSize" {
  type        = number
  description = "Batching mutations reduces overhead and cost. Depending on the size of values written to Cloud Bigtable the batch size might need to be adjusted lower to avoid memory pressures on the worker fleet. Defaults to 10000"
  default     = null
}

variable "outputShardsCount" {
  type        = number
  description = "The maximum number of output shards produced when writing to Cloud Storage. A higher number of shards means higher throughput for writing to Cloud Storage, but potentially higher data aggregation cost across shards when processing output Cloud Storage files. Defaults to: 20."
  default     = null
}

variable "useBase64Rowkeys" {
  type        = bool
  description = "Only supported for the TEXT output file format. When set to true, rowkeys will be written as Base64-encoded strings. Otherwise bigtableChangeStreamCharset charset will be used to decode binary values into String rowkeysDefaults to false."
  default     = null
}

variable "useBase64ColumnQualifiers" {
  type        = bool
  description = "Only supported for the TEXT output file format. When set to true, column qualifiers will be written as Base64-encoded strings. Otherwise bigtableChangeStreamCharset charset will be used to decode binary values into String column qualifiersDefaults to false."
  default     = null
}

variable "useBase64Values" {
  type        = bool
  description = "Only supported for the TEXT output file format. When set to true, values will be written as Base64-encoded strings. Otherwise bigtableChangeStreamCharset charset will be used to decode binary values into String valuesDefaults to false."
  default     = null
}

variable "bigtableChangeStreamMetadataInstanceId" {
  type        = string
  description = "The Bigtable change streams metadata instance ID. Defaults to empty."
  default     = null
}

variable "bigtableChangeStreamMetadataTableTableId" {
  type        = string
  description = "The ID of the Bigtable change streams connector metadata table. If not provided, a Bigtable change streams connector metadata table is automatically created during pipeline execution. Defaults to empty."
  default     = null
}

variable "bigtableChangeStreamAppProfile" {
  type        = string
  description = "The Bigtable application profile ID. The application profile must use single-cluster routing and allow single-row transactions."

}

variable "bigtableChangeStreamCharset" {
  type        = string
  description = "The Bigtable change streams charset name. Defaults to: UTF-8."
  default     = null
}

variable "bigtableChangeStreamStartTimestamp" {
  type        = string
  description = "The starting timestamp (https://tools.ietf.org/html/rfc3339), inclusive, to use for reading change streams. For example, `2022-05-05T07:59:59Z`. Defaults to the timestamp of the pipeline start time."
  default     = null
}

variable "bigtableChangeStreamIgnoreColumnFamilies" {
  type        = string
  description = "A comma-separated list of column family name changes to ignore. Defaults to empty."
  default     = null
}

variable "bigtableChangeStreamIgnoreColumns" {
  type        = string
  description = "A comma-separated list of column name changes to ignore. Defaults to empty."
  default     = null
}

variable "bigtableChangeStreamName" {
  type        = string
  description = "A unique name for the client pipeline. Lets you resume processing from the point at which a previously running pipeline stopped. Defaults to an automatically generated name. See the Dataflow job logs for the value used."
  default     = null
}

variable "bigtableChangeStreamResume" {
  type        = bool
  description = "When set to `true`, a new pipeline resumes processing from the point at which a previously running pipeline with the same `bigtableChangeStreamName` value stopped. If the pipeline with the given `bigtableChangeStreamName` value has never run, a new pipeline doesn't start. When set to `false`, a new pipeline starts. If a pipeline with the same `bigtableChangeStreamName` value has already run for the given source, a new pipeline doesn't start. Defaults to `false`."
  default     = null
}

variable "bigtableReadInstanceId" {
  type        = string
  description = "The source Bigtable instance ID."

}

variable "bigtableReadTableId" {
  type        = string
  description = "The source Bigtable table ID."

}

variable "bigtableReadProjectId" {
  type        = string
  description = "The Bigtable project ID. The default is the project for the Dataflow job."
  default     = null
}


provider "google" {
  project = var.project
}

provider "google-beta" {
  project = var.project
}

variable "additional_experiments" {
  type        = set(string)
  description = "List of experiments that should be used by the job. An example value is  'enable_stackdriver_agent_metrics'."
  default     = null
}

variable "autoscaling_algorithm" {
  type        = string
  description = "The algorithm to use for autoscaling"
  default     = null
}

variable "enable_streaming_engine" {
  type        = bool
  description = "Indicates if the job should use the streaming engine feature."
  default     = null
}

variable "ip_configuration" {
  type        = string
  description = "The configuration for VM IPs. Options are 'WORKER_IP_PUBLIC' or 'WORKER_IP_PRIVATE'."
  default     = null
}

variable "kms_key_name" {
  type        = string
  description = "The name for the Cloud KMS key for the job. Key format is: projects/PROJECT_ID/locations/LOCATION/keyRings/KEY_RING/cryptoKeys/KEY"
  default     = null
}

variable "labels" {
  type        = map(string)
  description = "User labels to be specified for the job. Keys and values should follow the restrictions specified in the labeling restrictions page. NOTE: This field is non-authoritative, and will only manage the labels present in your configuration.				Please refer to the field 'effective_labels' for all of the labels present on the resource."
  default     = null
}

variable "launcher_machine_type" {
  type        = string
  description = "The machine type to use for launching the job. The default is n1-standard-1."
  default     = null
}

variable "machine_type" {
  type        = string
  description = "The machine type to use for the job."
  default     = null
}

variable "max_workers" {
  type        = number
  description = "The maximum number of Google Compute Engine instances to be made available to your pipeline during execution, from 1 to 1000."
  default     = null
}

variable "name" {
  type = string
}

variable "network" {
  type        = string
  description = "The network to which VMs will be assigned. If it is not provided, 'default' will be used."
  default     = null
}

variable "num_workers" {
  type        = number
  description = "The initial number of Google Compute Engine instances for the job."
  default     = null
}

variable "sdk_container_image" {
  type        = string
  description = "Docker registry location of container image to use for the 'worker harness. Default is the container for the version of the SDK. Note this field is only valid for portable pipelines."
  default     = null
}

variable "service_account_email" {
  type        = string
  description = "The Service Account email used to create the job."
  default     = null
}

variable "skip_wait_on_job_termination" {
  type        = bool
  description = "If true, treat DRAINING and CANCELLING as terminal job states and do not wait for further changes before removing from terraform state and moving on. WARNING: this will lead to job name conflicts if you do not ensure that the job names are different, e.g. by embedding a release ID or by using a random_id."
  default     = null
}

variable "staging_location" {
  type        = string
  description = "The Cloud Storage path to use for staging files. Must be a valid Cloud Storage URL, beginning with gs://."
  default     = null
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork to which VMs will be assigned. Should be of the form 'regions/REGION/subnetworks/SUBNETWORK'."
  default     = null
}

variable "temp_location" {
  type        = string
  description = "The Cloud Storage path to use for temporary files. Must be a valid Cloud Storage URL, beginning with gs://."
  default     = null
}

resource "google_project_service" "required" {
  service            = "dataflow.googleapis.com"
  disable_on_destroy = false
}

resource "google_dataflow_flex_template_job" "generated" {
  depends_on              = [google_project_service.required]
  provider                = google-beta
  container_spec_gcs_path = "gs://dataflow-templates-${var.region}/latest/flex/Bigtable_Change_Streams_to_Google_Cloud_Storage"
  parameters = {
    outputFileFormat                         = var.outputFileFormat
    windowDuration                           = var.windowDuration
    bigtableMetadataTableTableId             = var.bigtableMetadataTableTableId
    schemaOutputFormat                       = var.schemaOutputFormat
    gcsOutputDirectory                       = var.gcsOutputDirectory
    outputFilenamePrefix                     = var.outputFilenamePrefix
    outputBatchSize                          = tostring(var.outputBatchSize)
    outputShardsCount                        = tostring(var.outputShardsCount)
    useBase64Rowkeys                         = tostring(var.useBase64Rowkeys)
    useBase64ColumnQualifiers                = tostring(var.useBase64ColumnQualifiers)
    useBase64Values                          = tostring(var.useBase64Values)
    bigtableChangeStreamMetadataInstanceId   = var.bigtableChangeStreamMetadataInstanceId
    bigtableChangeStreamMetadataTableTableId = var.bigtableChangeStreamMetadataTableTableId
    bigtableChangeStreamAppProfile           = var.bigtableChangeStreamAppProfile
    bigtableChangeStreamCharset              = var.bigtableChangeStreamCharset
    bigtableChangeStreamStartTimestamp       = var.bigtableChangeStreamStartTimestamp
    bigtableChangeStreamIgnoreColumnFamilies = var.bigtableChangeStreamIgnoreColumnFamilies
    bigtableChangeStreamIgnoreColumns        = var.bigtableChangeStreamIgnoreColumns
    bigtableChangeStreamName                 = var.bigtableChangeStreamName
    bigtableChangeStreamResume               = tostring(var.bigtableChangeStreamResume)
    bigtableReadInstanceId                   = var.bigtableReadInstanceId
    bigtableReadTableId                      = var.bigtableReadTableId
    bigtableReadProjectId                    = var.bigtableReadProjectId
  }

  additional_experiments       = var.additional_experiments
  autoscaling_algorithm        = var.autoscaling_algorithm
  enable_streaming_engine      = var.enable_streaming_engine
  ip_configuration             = var.ip_configuration
  kms_key_name                 = var.kms_key_name
  labels                       = var.labels
  launcher_machine_type        = var.launcher_machine_type
  machine_type                 = var.machine_type
  max_workers                  = var.max_workers
  name                         = var.name
  network                      = var.network
  num_workers                  = var.num_workers
  sdk_container_image          = var.sdk_container_image
  service_account_email        = var.service_account_email
  skip_wait_on_job_termination = var.skip_wait_on_job_termination
  staging_location             = var.staging_location
  subnetwork                   = var.subnetwork
  temp_location                = var.temp_location
  region                       = var.region
}

output "dataflow_job_url" {
  value = "https://console.cloud.google.com/dataflow/jobs/${var.region}/${google_dataflow_flex_template_job.generated.job_id}"
}

