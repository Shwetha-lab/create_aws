resource "aws_instance" "ec2_exmple" {
  ami = "ami-0be2609ba883822ec"
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  key_name = "mykey"
  
  tags = {
    Name = "ec2_exmple"
  }

  connection {
    type            = "ssh"
    host            = self.public_ip
    private_key     = "${file("user/ramja/terraform/mykey.pem")}"
    user            = "ec2-user"
  }
  provisioner "file" {
    source      = "/user/ramja/terraform"
    destination = "/home/ec2-user"
    }
      
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
  }
}

