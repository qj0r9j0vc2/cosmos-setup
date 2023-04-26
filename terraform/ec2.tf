resource "aws_key_pair" "example-key" {
  key_name   = "example-key-pair"
  public_key = file("~/.ssh/id_rsa.pub") # replace with the path to your public key file
}

resource "aws_instance" "example-ec2-1" {
  ami = "ami-0c6e5afdd23291f73" # Canonical, Ubuntu, 20.04 LTS, amd64 focal image build on 2023-03-28
  instance_type = "t3.small"
  subnet_id = aws_subnet.example-subnet-publicA.id
  security_groups = [
    aws_security_group.example-sg-ssh.id,
    aws_default_security_group.default.id,
    aws_security_group.exampmle-sg-simapp.id
  ]
  key_name = "example-key-pair"
  associate_public_ip_address = true

  tags = {
    Name = "example-ec2-1"
  }
  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

    connection {
      host        = aws_instance.example-ec2-1.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }
  }
}

resource "aws_instance" "example-ec2-2" {
  ami = "ami-0c6e5afdd23291f73" # Canonical, Ubuntu, 20.04 LTS, amd64 focal image build on 2023-03-28
  instance_type = "t3.small"
  subnet_id = aws_subnet.example-subnet-publicA.id
  security_groups = [
    aws_security_group.example-sg-ssh.id,
    aws_default_security_group.default.id,
    aws_security_group.exampmle-sg-simapp.id
  ]
  key_name = "example-key-pair"
  associate_public_ip_address = true

  tags = {
    Name = "example-ec2-2"
  }
  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

    connection {
      host        = aws_instance.example-ec2-1.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }
  }
}
