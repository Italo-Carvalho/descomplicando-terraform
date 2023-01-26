variable "image_id" {
  default     = "ami-04bad3c587fe60d89"
  type        = string
  description = "The id of the machine image (AMI) to use for the server"
  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "servers" {

}
