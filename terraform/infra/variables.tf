variable "gce_ssh_user" {
  default = "root"
}
variable "gce_ssh_pub_key_file" {
  default = "~/.ssh/id_rsa.pub"

variable "gce_zone" {
  type = "string"
}
