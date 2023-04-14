resource "null_resource" "run_ansible" {
  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

    connection {
      host        = aws_instance.example-ec2.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${aws_instance.example-ec2.public_ip},' --private-key ~/.ssh/id_rsa -e 'pub_key=~/.ssh/id_rsa.pub' ../ansible/execute-script.yml"
  }
}
