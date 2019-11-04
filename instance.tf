provider "aws" {
    region = "eu-central-1"
    shared_credentials_file = "/root/.aws/credentials"
    profile = "pbarczi"
}

resource "aws_instance" "pbarczi_test" {
    ami 	  	   	= "ami-00aa4671cbf840d82"
    instance_type 	   	= "t2.micro"
    vpc_security_group_ids 	= ["sg-087d4e91439330bdd"]
    subnet_id 		   	= "subnet-0deb4575878cf84e1"
    associate_public_ip_address = "true"
    tags                    	= { Name = "pbarczi_test" }
    key_name               	= "pbarczi-pubkey"
    user_data = <<-EOF
		#!/bin/bash
		yum -y update
		yum -y install httpd
		systemctl enable httpd --now
		echo "It works!" > /var/www/html/index.html
    		EOF
}
