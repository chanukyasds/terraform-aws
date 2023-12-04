

resource "aws_db_instance" "postgres_rds" {
  identifier            = "postgresql-14"
  allocated_storage     = 10
  storage_type          = "gp2"
  engine                = "postgres"
  engine_version        = "14"
  instance_class        = "db.t3.micro"
  username              = var.username
  password              = "admin123" 
  publicly_accessible   = false
  skip_final_snapshot   = true
  vpc_security_group_ids = [aws_security_group.security_group_1.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_db_subnet_group.name
}

resource "aws_db_subnet_group" "rds_db_subnet_group" {
  name       = "rds_db_subnet_group"
  subnet_ids = [aws_subnet.subnet_eu[0].id, aws_subnet.subnet_eu[1].id ,aws_subnet.subnet_eu[2].id]
}






