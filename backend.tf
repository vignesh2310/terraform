terraform {
    backend "s3" {
        bucket = "tf-buck"
        key = "terraform/backend"
        region = "us-east-2"
    }
}