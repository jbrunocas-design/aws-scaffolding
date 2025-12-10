provider "aws" {
  region = "${{ values.Region }}"
}

# EC2 Instance
resource "aws_instance" "ec2" {
  count         = "${{ values.ResourceType }}" == "EC2" ? 1 : 0
  ami           = "ami-0156001f0548e90b1" # Cambia el AMI según la región si lo necesitas
  instance_type = "t3.micro"
  tags = {
    Name = "${{ values.InstanceName }}"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "s3" {
  count  = "${{ values.ResourceType }}" == "S3" ? 1 : 0
  bucket = "${{ values.BucketName }}"
}

# RDS Instance
resource "aws_db_instance" "rds" {
  count                     = "${{ values.ResourceType }}" == "RDS" ? 1 : 0
  identifier                = "${{ values.DBInstanceIdentifier }}"
  engine                    = "${{ values.DBEngine }}"
  instance_class            = "db.t3.micro"
  allocated_storage         = 20
  username                  = "admin"
  password                  = "SuperSecret123!" # Usa secrets en producción
  skip_final_snapshot       = true
  publicly_accessible       = true
}
