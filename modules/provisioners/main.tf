resource "null_resource" "provisioner" {

  connection {
    type        = "ssh"
    host        = var.instance_ip
    user        = "ec2-user"
    private_key = file(join(".", [var.ssh_key_name,"pem"]))
    port        = 22
  }

  // copy scripts to the server
  provisioner "file" {
    source      = "scripts4ec2/status_check.sh"
    destination = "/home/ec2-user/status_check.sh"
  }

  provisioner "file" {
    source      = "scripts4ec2/word_finder.py"
    destination = "/home/ec2-user/word_finder.py"
  }

  provisioner "remote-exec" {
    inline = [
      "while [ ! -f /tmp/signal ]; do sleep 2; done",
      "chmod +x /home/ec2-user/status_check.sh",
      "nohup /home/ec2-user/status_check.sh &",
      "python word_finder.py > result.txt",
      "sleep 2"
    ]
  }

  // get the word which occurs most on the page and print it in console
  provisioner "local-exec" {
    command = <<EOF
      scp -i ${var.ssh_key_name} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ec2-user@${var.instance_ip}:/home/ec2-user/result.txt result.txt; 
      cat result.txt
    EOF
  }

  // bonus point :  recreate and mount the log to container
  provisioner "remote-exec" {
    inline = [
      "docker stop `docker ps -a | sed '1d' | awk '{print $1}'`",
      "docker rm `docker ps -a | sed '1d' | awk '{print $1}'`",
      "docker run -d -p 80:80 --name web-nginx -v /home/ec2-user/resource.log:/usr/share/nginx/html/resource.txt:ro nginx",
      "sleep 2"
    ]
  }

}