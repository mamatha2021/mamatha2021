provider "aws" {
  region              = "ap-southeast-1"
  allowed_account_ids = ["489213317621"]
  access_key          = "AKIAXDZ3C2H23FIDCCSR"
  secret_key          = "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"
  default_tags {
    tags = {
      Name = "default tags"
    }
  }
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}
