
source "amazon-ebs" "autogenerated_1" {
  ami_description = "Docker AMI"
  ami_name        = "<my-ami>"
  instance_type   = "t2.micro"
  region          = "us-east-2"
  source_ami      = "ami-0fb653ca2d3203ac1"
  ssh_username    = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.autogenerated_1"]

  provisioner "file" {
    destination = "/tmp/setup.sh"
    source      = "setup.sh"
  }

  provisioner "shell" {
    scripts = ["setup.sh"]
  }

}
