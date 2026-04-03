resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}