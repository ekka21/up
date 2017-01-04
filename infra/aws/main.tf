provider "aws" {
    region = "${var.region}"
}

resource "aws_key_pair" "deployer" {
    key_name = "terraform"
    public_key = "${file(var.ssh_key)}"
}

resource "aws_instance" "app" {
    ami = "${lookup(var.ami, var.region)}"
    instance_type = "${var.instance_type}"
    key_name = "${aws_key_pair.deployer.key_name}"
    tags {
        Name = "${var.cloudflare_domain}"
        sshUser = "ec2-user"
    }
}

provider "cloudflare" {
    email = "${var.cloudflare_email}"
    token = "${var.cloudflare_token}"
}

resource "cloudflare_record" "non_www" {
    domain = "${var.cloudflare_domain}"
    name = "${var.cloudflare_domain}"
    value = "${aws_instance.app.public_dns}"
    type = "CNAME"
    proxied = "true"
}

resource "cloudflare_record" "www" {
    domain = "${var.cloudflare_domain}"
    name = "www"
    value = "${var.cloudflare_domain}"
    type = "CNAME"
    proxied = "true"
}
