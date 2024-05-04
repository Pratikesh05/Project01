
#public_instance

resource "aws_instance" "jump_server" {
  ami                         = "ami-0b419c3a4b01d1859"
  instance_type               = "t2.micro"
  monitoring                  = true
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  tags {
    Name = "jump_server"
  }
}

#private_instance 


resource "aws_instance" "ackend_instance" {
   ami                         = "ami-0b419c3a4b01d1859"
  instance_type               = "t2.micro"
  monitoring                  = true
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  subnet_id                   = aws_subnet.private_subnet.id
  private_ip                  = "10.0.0.0"
  associate_public_ip_address = false
  tags {
    Name = "backend_instance"
}
 
  }


  resource "aws_instance" "ackend_instance" {
   ami                         = "ami-0b419c3a4b01d1859"
  instance_type               = "t2.micro"
  monitoring                  = true
  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]
  subnet_id                   = aws_subnet.private_subnet.id
  private_ip                  = "10.0.0.0"
  associate_public_ip_address = false
  tags {
    Name = "backend_instance"
}
 
  }