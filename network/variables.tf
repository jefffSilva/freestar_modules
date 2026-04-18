variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "region" {
  description = "Region for regional resources (subnet, VPC connector)."
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource names."
  type        = string
  default     = "freestar"
}

variable "subnet_cidr" {
  description = "Primary subnet CIDR (must be within the VPC allocation and not overlap the connector)."
  type        = string
  default     = "10.10.0.0/24"
}

variable "connector_cidr" {
  description = "Dedicated /28 (or larger) for the Serverless VPC Access connector; must not overlap subnet CIDR."
  type        = string
  default     = "10.10.1.0/28"
}

variable "enable_vpc_connector" {
  description = "Create a Serverless VPC Access connector for Cloud Run / other serverless workloads."
  type        = bool
  default     = true
}

variable "routing_mode" {
  description = "VPC dynamic routing mode (REGIONAL or GLOBAL)."
  type        = string
  default     = "REGIONAL"
}
