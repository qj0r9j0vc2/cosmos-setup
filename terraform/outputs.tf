output "ec2_connect_1" {
  value = "EC2-1: \nscp ../scripts/cosmos-setup.sh ubuntu@${aws_instance.example-ec2-1.public_ip}:~/\nssh ubuntu@${aws_instance.example-ec2-1.public_ip}\n"
}
output "ec2_connect_2" {
  value = "EC2-1: \nscp ../scripts/cosmos-setup.sh ubuntu@${aws_instance.example-ec2-2.public_ip}:~/\nssh ubuntu@${aws_instance.example-ec2-2.public_ip}\n"
}
