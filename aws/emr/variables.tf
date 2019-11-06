
variable "availability_zones" {
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "letters" {
  default = ["A", "B", "C"]
}

variable "vpc_id" {
}

variable "master_sg_name" {
  default = "emr_master_sg"
}

variable "bid_price_task" {
  default = "0.30"
}

variable "instance_type_master" {
  default = "m5.2xlarge"
}

variable "instance_type_core" {
  default = "m4.large"
}

variable "instance_type_task" {
  default = "m5.xlarge"
}

variable "slave_sg_name" {
  default = "emr_slave_sg"
}

variable "key_name" {
  default = "prokey"
}

variable "tagsCluster" {
  type = map(string)
}

variable "configurations" {
}

variable "read_capacity" {
  default = "50"
}

variable "root_volume_size" {
  default = "10"
}

variable "write_capacity" {
  default = "10"
}

variable "tagsDynamo" {
  type = map(string)
}

variable "function_name" {
  default = "EMRAlertManager"
}

variable "emr2am_deployment_package" {
  description = "The path to the function's deployment package within the local filesystem."
  type        = string
}

variable "emr2am_handler" {
  type    = string
  default = "main"
}

variable "emr2am_security_group_ids" {
  type    = list(string)
  
}

variable "release_label" {
  default = "emr-5.13.0"
}

variable "emr_cluster_name" {
  default = "EMR"
}

variable "additional_master_security_groups" {
  description = "Set additional master sg"
}

variable "additional_slave_security_groups" {
  description = "Set additional slave sg"
}

variable "service_role" {
  description = "Set service role"
}

variable "autoscaling_role" {
  default = "eb-EMR-AutoScaling"
}

variable "cloudwatch_alert_event_rule" {
  default = "emr-cluster-alert"
}

variable "log_uri" {
  description = "Set log uri"
}

variable "subnet_ids" {
  description = "List ids"
  type = list(string)
}

variable "certificate_arn" {
}

variable "alb_security_group" {
  type = list(string)
}

variable "emrDNS" {
}

variable "livyDNS" {
}

variable "hadoopDNS" {
}

variable "zone_id" {
  
}
variable "workspace_iam_role_routing" {
  
}

variable "workspace_iam_role_emr" {
  
}

