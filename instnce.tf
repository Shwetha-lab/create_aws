resource "aws_instance" "ec2_exmple" {
  ami           = "ami-0be2609ba883822ec"
 key_name = "mykey"
  instance_type = "t2.micro"
  security_groups = ["allow_tls"]


  tags = {
    Name = "ec2_exmple"
  }
}

  