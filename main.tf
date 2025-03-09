# # provider "aws"  {
# #     region = "us-east-1"
  
# # }

# resource "aws_instance" "Day2_EC23"  {
#     ami = var.ami
#     instance_type = var.instance_type
#     tags = {
#       Name = "Hello_EC2"
#     }
  
# } 

# output "public_ip" {
#     description = "Public ip of EC2 instance "
#     value = aws_instance.Day2_EC23.public_ip
# }