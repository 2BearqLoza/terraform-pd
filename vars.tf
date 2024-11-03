variable "environments" {
  type    = list(string)
  default = ["Testing", "Production"]
}

variable "profile" {
  type    = string
  default = "profile"
}