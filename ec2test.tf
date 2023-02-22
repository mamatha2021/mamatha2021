provider "aws" {
  region              = "ap-southeast-1"
  allowed_account_ids = ["332514269665"]
  access_key          = "AKIAU223FDHQ72FWNVFP"
  secret_key          = "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"
  default_tags {
    tags = {
      Name = "default tags"
    }
  }
}


resource "aws_instance" "web" {
  ami           = "ami-0688ba7eeeeefe3cd"
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}
