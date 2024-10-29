

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

variable "sourceShardsFilePath" {
  type        = string
  description = "Source shard details file path in Cloud Storage that contains connection profile of source shards"

}

variable "sessionFilePath" {
  type        = string
  description = "Session file path in Cloud Storage that contains mapping information from HarbourBridge"

}

variable "sourceType" {
  type        = string
  description = "This is the type of source database. Currently only mysql is supported. Defaults to: mysql."
  default     = null
}

variable "sourceDbTimezoneOffset" {
  type        = string
  description = "This is the timezone offset from UTC for the source database. Example value: +10:00. Defaults to: +00:00."
  default     = null
}

variable "timerIntervalInMilliSec" {
  type        = number
  description = "Controls the time between successive polls to buffer and processing of the resultant records. Defaults to: 1."
  default     = null
}

variable "startTimestamp" {
  type        = string
  description = "Start time of file for all shards. If not provided, the value is taken from spanner_to_gcs_metadata. If provided, this takes precedence. To be given when running in regular run mode."
  default     = null
}

variable "windowDuration" {
  type        = string
  description = "The window duration/size in which data is written to Cloud Storage. Allowed formats are: Ns (for seconds, example: 5s), Nm (for minutes, example: 12m), Nh (for hours, example: 2h). If not provided, the value is taken from spanner_to_gcs_metadata. If provided, this takes precedence. To be given when running in regular run mode. (Example: 5m)"
  default     = null
}

variable "GCSInputDirectoryPath" {
  type        = string
  description = "Path from where to read the change stream files."

}

variable "spannerProjectId" {
  type        = string
  description = "This is the name of the Cloud Spanner project."

}

variable "metadataInstance" {
  type        = string
  description = "This is the instance to store the shard progress of the files processed."

}

variable "metadataDatabase" {
  type        = string
  description = "This is the database to store  the shard progress of the files processed.."

}

variable "runMode" {
  type        = string
  description = "Regular writes to source db, reprocess does processing the specific shards marked as REPROCESS, resumeFailed does reprocess of all shards in error state, resumeSuccess continues processing shards in successful state, resumeAll continues processing all shards irrespective of state. Defaults to: regular."
  default     = null
}

variable "metadataTableSuffix" {
  type        = string
  description = "Suffix appended to the spanner_to_gcs_metadata and shard_file_create_progress metadata tables.Useful when doing multiple runs.Only alpha numeric and underscores are allowed. Defaults to empty."
  default     = null
}

variable "runIdentifier" {
  type        = string
  description = "The identifier to distinguish between different runs of reverse replication flows."

}

variable "transformationJarPath" {
  type        = string
  description = "Custom jar location in Cloud Storage that contains the custom transformation logic for processing records in reverse replication. Defaults to empty."
  default     = null
}

variable "transformationClassName" {
  type        = string
  description = "Fully qualified class name having the custom transformation logic.  It is a mandatory field in case transformationJarPath is specified. Defaults to empty."
  default     = null
}

variable "transformationCustomParameters" {
  type        = string
  description = "String containing any custom parameters to be passed to the custom transformation class. Defaults to empty."
  default     = null
}

variable "writeFilteredEventsToGcs" {
  type        = bool
  description = "This is a flag which if set to true will write filtered events from custom transformation to GCS. Defaults to: false."
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
  container_spec_gcs_path = "gs://dataflow-templates-${var.region}/latest/flex/GCS_to_Sourcedb"
  parameters = {
    sourceShardsFilePath           = var.sourceShardsFilePath
    sessionFilePath                = var.sessionFilePath
    sourceType                     = var.sourceType
    sourceDbTimezoneOffset         = var.sourceDbTimezoneOffset
    timerIntervalInMilliSec        = tostring(var.timerIntervalInMilliSec)
    startTimestamp                 = var.startTimestamp
    windowDuration                 = var.windowDuration
    GCSInputDirectoryPath          = var.GCSInputDirectoryPath
    spannerProjectId               = var.spannerProjectId
    metadataInstance               = var.metadataInstance
    metadataDatabase               = var.metadataDatabase
    runMode                        = var.runMode
    metadataTableSuffix            = var.metadataTableSuffix
    runIdentifier                  = var.runIdentifier
    transformationJarPath          = var.transformationJarPath
    transformationClassName        = var.transformationClassName
    transformationCustomParameters = var.transformationCustomParameters
    writeFilteredEventsToGcs       = tostring(var.writeFilteredEventsToGcs)
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

