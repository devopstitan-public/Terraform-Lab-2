# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instnace Type"
  type = string
  default = "t2.micro"
  
}


# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
  type = string
  default = "devops-titan-aws-key"
}

# Define AWS IAM user names

variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["john_doe", "ratan_tata", "mark_jack"]
}
