variable "ssh_key" {}
variable "instance_type" {}
variable "region" {}

variable "ami" {
    #Amazon AMI
    default = {
      us-east-1 = "ami-b73b63a0"
      us-east-2 = "ami-58277d3d"
      us-west-1 = "ami-23e8a343"
      us-west-2 = "ami-5ec1673e"
    }

}

variable "cloudflare_email" {}
variable "cloudflare_token" {}
variable "cloudflare_domain" {}
