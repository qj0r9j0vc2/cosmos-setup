output "ec2_connect" {
  value = "EC2-1: ssh ubuntu@${aws_instance.example-ec2-1.public_ip}\nEC2-1: ssh ubuntu@${aws_instance.example-ec2-2.public_ip}"
}
