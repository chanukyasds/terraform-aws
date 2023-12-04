
resource "aws_vpc" "private_vpc_1" {

  cidr_block = "10.0.0.0/16"  # Specify the CIDR block for your VPC

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "private_vpc_1"
  }
}



resource "aws_subnet" "subnet_eu" {
  count = length(data.aws_availability_zones.available_zones.names)

  vpc_id                  = aws_vpc.private_vpc_1.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone        = data.aws_availability_zones.available_zones.names[count.index]

  tags = {
    Name = "subnet_eu_${count.index + 1}"
  }
}

resource "aws_security_group" "security_group_1" {
  vpc_id = aws_vpc.private_vpc_1.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 7000
    to_port     = 7000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

