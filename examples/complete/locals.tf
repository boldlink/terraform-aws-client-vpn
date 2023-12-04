locals {
  filename = "function.tmp/lambda.zip"
  subnet_ids = [
    for s in data.aws_subnet.private : s.id
  ]
  vpc_id   = data.aws_vpc.supporting.id
  vpc_cidr = data.aws_vpc.supporting.cidr_block
}
