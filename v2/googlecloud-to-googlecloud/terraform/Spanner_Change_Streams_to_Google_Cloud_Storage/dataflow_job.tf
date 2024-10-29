

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

variable "spannerProjectId" {
  type        = string
  description = "The ID of the Google Cloud project that contains the Spanner database to read change streams from. This project is also where the change streams connector metadata table is created. The default for this parameter is the project where the Dataflow pipeline is running."
  default     = null
}

variable "spannerInstanceId" {
  type        = string
  description = "The Spanner instance ID to read change streams data from."

}

variable "spannerDatabase" {
  type        = string
  description = "The Spanner database to read change streams data from."

}

variable "spannerDatabaseRole" {
  type        = string
  description = "The Spanner database role to use when running the template. This parameter is required only when the IAM principal who is running the template is a fine-grained access control user. The database role must have the `SELECT` privilege on the change stream and the `EXECUTE` privilege on the change stream's read function. For more information, see Fine-grained access control for change streams (https://cloud.google.com/spanner/docs/fgac-change-streams)."
  default     = null
}

variable "spannerMetadataInstanceId" {
  type        = string
  description = "The Spanner instance ID to use for the change streams connector metadata table."

}

variable "spannerMetadataDatabase" {
  type        = string
  description = "The Spanner database to use for the change streams connector metadata table."

}

variable "spannerMetadataTableName" {
  type        = string
  description = "The Spanner change streams connector metadata table name to use. If not provided, a Spanner change streams metadata table is automatically created during pipeline execution. You must provide a value for this parameter when updating an existing pipeline. Otherwise, don't use this parameter."
  default     = null
}

variable "spannerChangeStreamName" {
  type        = string
  description = "The name of the Spanner change stream to read from."

}

variable "startTimestamp" {
  type        = string
  description = "The starting DateTime, inclusive, to use for reading change streams, in the format Ex-2021-10-12T07:20:50.52Z. Defaults to the timestamp when the pipeline starts, that is, the current time."
  default     = null
}

variable "endTimestamp" {
  type        = string
  description = "The ending DateTime, inclusive, to use for reading change streams. For example, Ex-2021-10-12T07:20:50.52Z. Defaults to an infinite time in the future."
  default     = null
}

variable "spannerHost" {
  type        = string
  description = "The Cloud Spanner endpoint to call in the template. Only used for testing. (Example: https://spanner.googleapis.com). Defaults to: https://spanner.googleapis.com."
  default     = null
}

variable "outputFileFormat" {
  type        = string
  description = "The format of the output Cloud Storage file. Allowed formats are TEXT and AVRO. Defaults to AVRO."
  default     = null
}

variable "windowDuration" {
  type        = string
  description = "The window duration is the interval in which data is written to the output directory. Configure the duration based on the pipeline's throughput. For example, a higher throughput might require smaller window sizes so that the data fits into memory. Defaults to 5m (five minutes), with a minimum of 1s (one second). Allowed formats are: [int]s (for seconds, example: 5s), [int]m (for minutes, example: 12m), [int]h (for hours, example: 2h). (Example: 5m)"
  default     = null
}

variable "rpcPriority" {
  type        = string
  description = "The request priority for Spanner calls. The value must be HIGH, MEDIUM, or LOW. Defaults to HIGH."
  default     = null
}

variable "gcsOutputDirectory" {
  type        = string
  description = "The path and filename prefix for writing output files. Must end with a slash. DateTime formatting is used to parse directory path for date & time formatters. (Example: gs://your-bucket/your-path)"

}

variable "outputFilenamePrefix" {
  type        = string
  description = "The prefix to place on each windowed file. (Example: output-). Defaults to: output."
  default     = null
}

variable "numShards" {
  type        = number
  description = "The maximum number of output shards produced when writing. A higher number of shards means higher throughput for writing to Cloud Storage, but potentially higher data aggregation cost across shards when processing output Cloud Storage files. Defaults to: 20."
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
  container_spec_gcs_path = "gs://dataflow-templates-${var.region}/latest/flex/Spanner_Change_Streams_to_Google_Cloud_Storage"
  parameters = {
    spannerProjectId          = var.spannerProjectId
    spannerInstanceId         = var.spannerInstanceId
    spannerDatabase           = var.spannerDatabase
    spannerDatabaseRole       = var.spannerDatabaseRole
    spannerMetadataInstanceId = var.spannerMetadataInstanceId
    spannerMetadataDatabase   = var.spannerMetadataDatabase
    spannerMetadataTableName  = var.spannerMetadataTableName
    spannerChangeStreamName   = var.spannerChangeStreamName
    startTimestamp            = var.startTimestamp
    endTimestamp              = var.endTimestamp
    spannerHost               = var.spannerHost
    outputFileFormat          = var.outputFileFormat
    windowDuration            = var.windowDuration
    rpcPriority               = var.rpcPriority
    gcsOutputDirectory        = var.gcsOutputDirectory
    outputFilenamePrefix      = var.outputFilenamePrefix
    numShards                 = tostring(var.numShards)
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

