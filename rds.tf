

resource "aws_db_subnet_group" "dbsubnet" {
  name       = "main"
  subnet_ids = ["${aws_subnet.private_subnet1.id}", "${aws_subnet.private_subnet.id}"]

}

resource "aws_db_instance" "db" {
  identifier             = "db"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  engine                 = "mysql"
  Name                   = "database"
  password               = "12345"
  username               = "pratikesh"
  engine_version         = "5.6.40"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.dbsubnet.name
  vpc_security_group_ids = [aws_security_group.db.id] 
  lifecycle {
    ignore_changes = ["engine", "auto_minor_version_upgrade", "vpc_security_group_ids"]
  }

  depends_on = [aws_security_group.db]
}