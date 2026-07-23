# Launch the jenkins_server in public subnet

resource "aws_instance" "jenkins_server" {
  ami                         = "ami-01a00762f46d584a1"
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  key_name                    = "devops-key"
  associate_public_ip_address = true

  tags = {
    Name = "Jenkins-Server"
  }
}


# Launch the nginx_server in public subnet

resource "aws_instance" "nginx_server" {
  ami                         = "ami-01a00762f46d584a1"
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  key_name                    = "devops-key"
  associate_public_ip_address = true

  tags = {
    Name = "Nginx-Server"
  }
}
 


 # Launch the application_server in public subnet
 
resource "aws_instance" "application_server" {
  ami                    = "ami-01a00762f46d584a1"
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = "devops-key"

  tags = {
    Name = "Application-Server"
  }
}
