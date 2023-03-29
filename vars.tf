variable REGION {
    default = "us-east-2"
}

variable ZONE {
    default = "us-east-2c"
}

variable USER {
    default = "ec2-user"
}

variable AMI {
    type = map
    default = {
        us-east-1 = "ami-00c39f71452c08778"
        us-east-2 = "ami-02f97949d306b597a"
    }
}