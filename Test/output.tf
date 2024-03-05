output "public-ip-addess" {
  value = aws_instance.example.public_ip #To print the public ip of machine
}

output "s3_bucket" {
  value = aws_s3_bucket_object.file.source
}