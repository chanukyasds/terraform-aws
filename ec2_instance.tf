

data "template_file" "user_data_script" {
  template = file("./script.sh.tpl")

  vars = {
    ssh_key = var.my_ssh_keys[0]
    rds_endpoint = aws_db_instance.postgres_rds.endpoint
    username = var.username
    rds_port = aws_db_instance.postgres_rds.port
  }
}

resource "aws_instance" "ubuntu_machine" {
  ami           = "ami-06dd92ecc74fdfb36"  # Replace with your desired AMI ID
  instance_type = "t3.micro"               # Replace with your desired instance type
  subnet_id = aws_subnet.subnet_eu[0].id  # Replace with your subnet ID
  vpc_security_group_ids = [aws_security_group.security_group_1.id]
  user_data = data.template_file.user_data_script.rendered
  tags = {
    Name = "ubuntu_machine"
  }
}


resource "aws_eip" "ec2-elastic-ip-1" {
  instance = "${aws_instance.ubuntu_machine.id}"
}

resource "aws_internet_gateway" "ec2-env-gw" {
  vpc_id = "${aws_vpc.private_vpc_1.id}"

}

resource "aws_route_table" "route-table-1" {
  vpc_id = "${aws_vpc.private_vpc_1.id}"
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ec2-env-gw.id}"
  }

}
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.subnet_eu[0].id}"
  route_table_id = "${aws_route_table.route-table-1.id}"
}