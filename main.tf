resource "aws_key_pair" "terraform_key" {
  key_name   = "infra-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCbY0WemfJEDrOawDVtf8HYzf4UoQXGIM1EMT3w/sjhz1cbYD0DioETIUd98/7DTISn69I6tuhOwVfXqx2tjbNhYmcGXKKu0hltMdti063bfKMocBNTtPpyKT9+DpGSO7cUQUVkfH8xh1wNdg3XlzcH54nPr/1sy69yzddhMif2BR3uBmAa1uPm4lAJnG8mcC8itdOixY6fg8JD6+d19O8lAZFk5YhbZYokkDZ2O+eGh3qwvSB/tCbWgQvAW4Py2CACkXwEKULITffDMvk0tPf51HmNXz0ifqgzhhgWoa/DTyZ/RR67P/Z4UPyyv35Wv8RB88b3aOe78P7ByY4L1TurQn0hBVIS/IhFG8Vp7BqoWxGIlRf+H3cECtDvTNnc5DNREM9ZnKYCsuDTTq8dEADkfHT43MCrqDugWfqG6BaxQZna5XG5Vqg3VlEqOqepFCvOjwSXwIm2+gkOCMM36AcnDY1amMOlkWqa3fOdnbbqZHH7JZaz4t2518LNsudSzo8= ubuntu@ip-172-31-5-69"
}

resource "aws_instance" "infra-instance" {
    ami = var.AMI[var.REGION]
    instance_type = "t2.micro"
    availability_zone = var.ZONE
    key_name = aws_key_pair.terraform_key.key_name
    vpc_security_group_ids = ["sg-0139f375f3c9f9419"]
    tags = {
        name = "infra-devops-project"
    }

    provisioner "file" {
        source = "web.sh"
        destination = "/tmp/web.sh"
    }

    provisioner "remoteInfra-instance" {
        inline = [
            "chmod +x /tmp/web.sh",
            "sudo /tmp/web.sh"
        ]
    }


    connection {
        user = var.USER
        private_key = file("tf_key")
        host = self.public_ip
    }

}