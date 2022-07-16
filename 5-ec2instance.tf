
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id ]
  tags = {
    "Name" = "jenkin_server"
  }
  connection {
   type     = "ssh"
   user     = "ec2-user"
   private_key = file("./devops-titan-aws-key.pem")
   host     = self.public_ip
    }


##  Installing Jenkins

  provisioner "remote-exec" {
    inline = [

##  Installing Jenkins

      "sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum install jenkins -y",
      "sudo yum install -y java-1.8.0-openjdk",
      "sudo systemctl start jenkins;sudo systemctl enable jenkins",
##  Installing Mavan
      "sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz",
      "sudo tar -xvf apache-maven-3.8.6-bin.tar.gz --directory /opt",
      "sudo echo '''export MAVEN_HOME=/apache-maven-3.8.6''' >> /tmp/mvn_profile",
      "sudo echo '''export M2=/opt//apache-maven-3.8.6/bin''' >> /tmp/mvn_profile",
      "sudo echo '''export PATH=$PATH/bin:/opt/apache-maven-3.8.6/bin''' >> /tmp/mvn_profile",
#      "source /tmp/mvn_profile",
##  Installing Git
      "sudo yum install git -y",
## Installing Docker
      "sudo yum install docker -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
##   Provide permission to Jenkins user to access docker
      "sudo groupadd docker",
      "sudo usermod -aG docker jenkins",
      "sudo usermod -aG sudo jenkins",
      "sudo chmod 777 /var/run/docker.sock",
##   Add Jenkins user into sudoers
      "echo '''jenkins ALL=(ALL) NOPASSWD: ALL''' >> /etc/sudoers",
      "sudo chmod 777 /var/run/docker.sock",
    ]
  }
}
