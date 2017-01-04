output "ip" {
    value = "${aws_instance.app.public_ip}"
}

output "ssh_keyname" {
    value = "${aws_key_pair.deployer.key_name}"
}
