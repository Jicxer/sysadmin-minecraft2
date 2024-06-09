variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}


variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "profile" {
  description = "AWS Learner Lab Profile"
  default     = "learner_lab"
}

variable "key_name" {
  description = "Key pair name"
  default     = "my-key-pair"
}

variable "existing_security_group_id" {
  description = "ID of the pre-existing security group"
  default     = "sg-00e46086372a8a183"
}