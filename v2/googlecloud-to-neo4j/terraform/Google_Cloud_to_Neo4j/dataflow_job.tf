

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

variable "jobSpecUri" {
  type        = string
  description = "The path to the job specification file, which contains the configuration for source and target metadata."

}

variable "neo4jConnectionUri" {
  type        = string
  description = "The path to the Neo4j connection metadata JSON file."
  default     = null
}

variable "neo4jConnectionSecretId" {
  type        = string
  description = "The secret ID for the Neo4j connection metadata. This is an alternative to the GCS path option."
  default     = null
}

variable "optionsJson" {
  type        = string
  description = "Options JSON. Use runtime tokens. (Example: {token1:value1,token2:value2}). Defaults to empty."
  default     = null
}

variable "readQuery" {
  type        = string
  description = "Override SQL query. Defaults to empty."
  default     = null
}

variable "inputFilePattern" {
  type        = string
  description = "Override text file pattern (Example: gs://your-bucket/path/*.json). Defaults to empty."
  default     = null
}

variable "disabledAlgorithms" {
  type        = string
  description = "Comma separated algorithms to disable. If this value is set to none, no algorithm is disabled. Use this parameter with caution, because the algorithms disabled by default might have vulnerabilities or performance issues. (Example: SSLv3, RC4)"
  default     = null
}

variable "extraFilesToStage" {
  type        = string
  description = "Comma separated Cloud Storage paths or Secret Manager secrets for files to stage in the worker. These files are saved in the /extra_files directory in each worker. (Example: gs://<BUCKET>/file.txt,projects/<PROJECT_ID>/secrets/<SECRET_ID>/versions/<VERSION_ID>)"
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
  container_spec_gcs_path = "gs://dataflow-templates-${var.region}/latest/flex/Google_Cloud_to_Neo4j"
  parameters = {
    jobSpecUri              = var.jobSpecUri
    neo4jConnectionUri      = var.neo4jConnectionUri
    neo4jConnectionSecretId = var.neo4jConnectionSecretId
    optionsJson             = var.optionsJson
    readQuery               = var.readQuery
    inputFilePattern        = var.inputFilePattern
    disabledAlgorithms      = var.disabledAlgorithms
    extraFilesToStage       = var.extraFilesToStage
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

