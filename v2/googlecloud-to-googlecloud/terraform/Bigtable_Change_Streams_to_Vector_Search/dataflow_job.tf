

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

variable "bigtableMetadataTableTableId" {
  type        = string
  description = "Table ID used for creating the metadata table."
  default     = null
}

variable "embeddingColumn" {
  type        = string
  description = "The fully qualified column name where the embeddings are stored. In the format cf:col."

}

variable "crowdingTagColumn" {
  type        = string
  description = "The fully qualified column name where the crowding tag is stored. In the format cf:col."
  default     = null
}

variable "embeddingByteSize" {
  type        = number
  description = "The byte size of each entry in the embeddings array. Use 4 for Float, and 8 for Double. Defaults to: 4."
  default     = 4
}

variable "allowRestrictsMappings" {
  type        = string
  description = "The comma separated fully qualified column names of the columns that should be used as the `allow` restricts, with their alias. In the format cf:col->alias."
  default     = null
}

variable "denyRestrictsMappings" {
  type        = string
  description = "The comma separated fully qualified column names of the columns that should be used as the `deny` restricts, with their alias. In the format cf:col->alias."
  default     = null
}

variable "intNumericRestrictsMappings" {
  type        = string
  description = "The comma separated fully qualified column names of the columns that should be used as integer `numeric_restricts`, with their alias. In the format cf:col->alias."
  default     = null
}

variable "floatNumericRestrictsMappings" {
  type        = string
  description = "The comma separated fully qualified column names of the columns that should be used as float (4 bytes) `numeric_restricts`, with their alias. In the format cf:col->alias."
  default     = null
}

variable "doubleNumericRestrictsMappings" {
  type        = string
  description = "The comma separated fully qualified column names of the columns that should be used as double (8 bytes) `numeric_restricts`, with their alias. In the format cf:col->alias."
  default     = null
}

variable "upsertMaxBatchSize" {
  type        = number
  description = "The maximum number of upserts to buffer before upserting the batch to the Vector Search Index. Batches will be sent when there are either upsertBatchSize records ready, or any record has been waiting upsertBatchDelay time has passed. (Example: 10). Defaults to: 10."
  default     = null
}

variable "upsertMaxBufferDuration" {
  type        = string
  description = "The maximum delay before a batch of upserts is sent to Vector Search.Batches will be sent when there are either upsertBatchSize records ready, or any record has been waiting upsertBatchDelay time has passed. Allowed formats are: Ns (for seconds, example: 5s), Nm (for minutes, example: 12m), Nh (for hours, example: 2h). (Example: 10s). Defaults to: 10s."
  default     = null
}

variable "deleteMaxBatchSize" {
  type        = number
  description = "The maximum number of deletes to buffer before deleting the batch from the Vector Search Index. Batches will be sent when there are either deleteBatchSize records ready, or any record has been waiting deleteBatchDelay time has passed. (Example: 10). Defaults to: 10."
  default     = null
}

variable "deleteMaxBufferDuration" {
  type        = string
  description = "The maximum delay before a batch of deletes is sent to Vector Search.Batches will be sent when there are either deleteBatchSize records ready, or any record has been waiting deleteBatchDelay time has passed. Allowed formats are: Ns (for seconds, example: 5s), Nm (for minutes, example: 12m), Nh (for hours, example: 2h). (Example: 10s). Defaults to: 10s."
  default     = null
}

variable "vectorSearchIndex" {
  type        = string
  description = "The Vector Search Index where changes will be streamed, in the format 'projects/{projectID}/locations/{region}/indexes/{indexID}' (no leading or trailing spaces) (Example: projects/123/locations/us-east1/indexes/456)"

}

variable "dlqDirectory" {
  type        = string
  description = "The path to store any unprocessed records with the reason they failed to be processed. Default is a directory under the Dataflow job's temp location. The default value is enough under most conditions."
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
  container_spec_gcs_path = "gs://dataflow-templates-${var.region}/latest/flex/Bigtable_Change_Streams_to_Vector_Search"
  parameters = {
    bigtableMetadataTableTableId             = var.bigtableMetadataTableTableId
    embeddingColumn                          = var.embeddingColumn
    crowdingTagColumn                        = var.crowdingTagColumn
    embeddingByteSize                        = tostring(var.embeddingByteSize)
    allowRestrictsMappings                   = var.allowRestrictsMappings
    denyRestrictsMappings                    = var.denyRestrictsMappings
    intNumericRestrictsMappings              = var.intNumericRestrictsMappings
    floatNumericRestrictsMappings            = var.floatNumericRestrictsMappings
    doubleNumericRestrictsMappings           = var.doubleNumericRestrictsMappings
    upsertMaxBatchSize                       = tostring(var.upsertMaxBatchSize)
    upsertMaxBufferDuration                  = var.upsertMaxBufferDuration
    deleteMaxBatchSize                       = tostring(var.deleteMaxBatchSize)
    deleteMaxBufferDuration                  = var.deleteMaxBufferDuration
    vectorSearchIndex                        = var.vectorSearchIndex
    dlqDirectory                             = var.dlqDirectory
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

