locals {
  subnet_ids = [
    for s in data.aws_subnet.private : s.id
  ]
  vpc_id = data.aws_vpc.supporting.id
}
