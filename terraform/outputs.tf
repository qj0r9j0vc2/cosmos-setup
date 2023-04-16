output "ec2_connect" {
  value = "EC2-1: ssh ubuntu@${aws_instance.example-ec2-1.public_ip}"
}
