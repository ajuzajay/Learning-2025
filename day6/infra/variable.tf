variable "prefix" {
  description = "The prefix for the resources"

}

variable "environment" {
  description = "The environment for the resources"
  default     = "dev"
}

variable "region" {
  description = "The region for the resources"
  default     = "us-west-1"
}

variable "zone1" {
  description = "The zone for the resources"
  default     = "us-west-1a"

}

variable "zone2" {
  description = "The zone for the resources"
  default     = "us-west-1b"

}

variable "app_name" {
    description = "name of the application"
    default = "2-tier-app"
  
}


