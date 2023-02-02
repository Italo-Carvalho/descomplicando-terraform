variable "blocks" {
  type = list(object({
    device_name = string
    volume_size = number
    volume_type = string
    }))
  description = "List of EBS blocks"
}
