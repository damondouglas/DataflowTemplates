

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

variable "datastoreReadGqlQuery" {
  type        = string
  description = "A GQL (https://cloud.google.com/datastore/docs/reference/gql_reference) query that specifies which entities to grab. For example, `SELECT * FROM MyKind`."

}

variable "datastoreReadProjectId" {
  type        = string
  description = "The ID of the Google Cloud project that contains the Datastore instance that you want to read data from."

}

variable "datastoreReadNamespace" {
  type        = string
  description = "The namespace of the requested entities. To use the default namespace, leave this parameter blank."
  default     = null
}

variable "javascriptTextTransformGcsPath" {
  type        = string
  description = "The Cloud Storage URI of the .js file that defines the JavaScript user-defined function (UDF) to use. For example, `gs://my-bucket/my-udfs/my_file.js`."
  default     = null
}

variable "javascriptTextTransformFunctionName" {
  type        = string
  description = "The name of the JavaScript user-defined function (UDF) to use. For example, if your JavaScript function code is `myTransform(inJson) { /*...do stuff...*/ }`, then the function name is `myTransform`. For sample JavaScript UDFs, see UDF Examples (https://github.com/GoogleCloudPlatform/DataflowTemplates#udf-examples)."
  default     = null
}

variable "textWritePrefix" {
  type        = string
  description = "The Cloud Storage path prefix that specifies where the data is written. (Example: gs://mybucket/somefolder/)"

}


provider "google" {
  project = var.project
}

variable "additional_experiments" {
  type        = set(string)
  description = "List of experiments that should be used by the job. An example value is  'enable_stackdriver_agent_metrics'."
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

variable "machine_type" {
  type        = string
  description = "The machine type to use for the job."
  default     = null
}

variable "max_workers" {
  type        = number
  description = "The number of workers permitted to work on the job. More workers may improve processing speed at additional cost."
  default     = null
}

variable "name" {
  type        = string
  description = "A unique name for the resource, required by Dataflow."
}

variable "network" {
  type        = string
  description = "The network to which VMs will be assigned. If it is not provided, 'default' will be used."
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

variable "subnetwork" {
  type        = string
  description = "The subnetwork to which VMs will be assigned. Should be of the form 'regions/REGION/subnetworks/SUBNETWORK'."
  default     = null
}

variable "temp_gcs_location" {
  type        = string
  description = "A writeable location on Google Cloud Storage for the Dataflow job to dump its temporary data."
}

variable "zone" {
  type        = string
  description = "The zone in which the created job should run. If it is not provided, the provider zone is used."
  default     = null
}

resource "google_project_service" "required" {
  service            = "dataflow.googleapis.com"
  disable_on_destroy = false
}

resource "google_dataflow_job" "generated" {
  depends_on        = [google_project_service.required]
  provider          = google
  template_gcs_path = "gs://dataflow-templates-${var.region}/latest/Datastore_to_GCS_Text"
  parameters = {
    datastoreReadGqlQuery               = var.datastoreReadGqlQuery
    datastoreReadProjectId              = var.datastoreReadProjectId
    datastoreReadNamespace              = var.datastoreReadNamespace
    javascriptTextTransformGcsPath      = var.javascriptTextTransformGcsPath
    javascriptTextTransformFunctionName = var.javascriptTextTransformFunctionName
    textWritePrefix                     = var.textWritePrefix
  }

  additional_experiments       = var.additional_experiments
  enable_streaming_engine      = var.enable_streaming_engine
  ip_configuration             = var.ip_configuration
  kms_key_name                 = var.kms_key_name
  labels                       = var.labels
  machine_type                 = var.machine_type
  max_workers                  = var.max_workers
  name                         = var.name
  network                      = var.network
  service_account_email        = var.service_account_email
  skip_wait_on_job_termination = var.skip_wait_on_job_termination
  subnetwork                   = var.subnetwork
  temp_gcs_location            = var.temp_gcs_location
  zone                         = var.zone
  region                       = var.region
}

output "dataflow_job_url" {
  value = "https://console.cloud.google.com/dataflow/jobs/${var.region}/${google_dataflow_job.generated.job_id}"
}

