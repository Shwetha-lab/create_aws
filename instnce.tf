resource "aws_instance" "ec2_exmple" {
  ami           = "ami-0be2609ba883822ec"
  instance_type = "t2.micro"
  security_groups = ["allow_ec"]
  depends_on = [aws_internet_gateway.internet_gw]

  tags = {
    Name = "HelloWorld"
  }
}
resource "aws_security_group" "allow_ec" {
  name        = "allow_ec"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.custm-vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.custm-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ec"
  }
}

resource "aws_vpc" "custm-vpc" {
  cidr_block       = "10.0.0.0/18"
  instance_tenancy = "default"

  tags = {
    Name = "custm-vpc"
  
  }
}


resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.custm-vpc.id

  tags = {
    Name = "Main_ig"
  }
}


resource "aws_subnet" "public_sub" {
  vpc_id     = aws_vpc.custm-vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "Public_Subnet"
  }
}


resource "aws_subnet" "private_sub" {
  vpc_id     = aws_vpc.custm-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Private_Subnet"
  }
}