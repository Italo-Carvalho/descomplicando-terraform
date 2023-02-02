variable "image_id" {
  default     = "ami-04bad3c587fe60d89"
  type        = string
  description = "The id of the machine image (AMI) to use for the server"
  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "environment" {
  type = string
  default = "staging"
  description = "The environment of instance"
}

variable "plus" {
  default = 2
  type = number
}

# variable "production" {
#   default = true
#   type = bool
# }

variable "sg"{
  type = list(number)
  default = [10,20,30]
  description = "The list of sg for this instance"
}

variable "instance_types" {
  type = list
  default = ["t2.micro", "t3.medium"]
  description = "The list of instance types"
}

variable "blocks" {
  type = list(object({
    device_name = string
    volume_size = number
    volume_type = string
    }))
  description = "List of EBS blocks"
}
