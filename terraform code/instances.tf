resource "aws_instance" "my_bg_blue" {
  ami                    = "ami-0e449927258d45bc4"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.my_bg_subnet.id
  key_name               = "rohit"
  vpc_security_group_ids = [aws_security_group.my_bg_web_sg.id]
  user_data              = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              mkdir -p /var/www/html
              echo "<h1>BLUE ENVIRONMENT</h1>" > /var/www/html/index.html
              chown apache:apache /var/www/html/index.html
              chmod 644 /var/www/html/index.html
              systemctl enable httpd
              systemctl start httpd
              EOF
  tags = {
    Name = "blue_instance_r"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "my_bg_green" {
  ami                    = "ami-0e449927258d45bc4"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.my_bg_subnet.id
  key_name               = "rohit"
  vpc_security_group_ids = [aws_security_group.my_bg_web_sg.id]
  user_data              = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              mkdir -p /var/www/html
              echo "<h1>GREEN ENVIRONMENT</h1>" > /var/www/html/index.html
              chown apache:apache /var/www/html/index.html
              chmod 644 /var/www/html/index.html
              systemctl enable httpd
              systemctl start httpd
              EOF
  tags = {
    Name = "green_instance_r"
  }

  lifecycle {
    create_before_destroy = true
  }
}
