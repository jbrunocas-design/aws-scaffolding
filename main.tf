variable "resource_type" {
  description = "Type of AWS resource to create"
  type        = string
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = ""
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = ""
}

variable "db_instance_identifier" {
  description = "RDS instance identifier"
  type        = string
  default     = ""
}

variable "db_engine" {
  description = "RDS engine"
  type        = string
  default     = ""
}

provider "aws" {
  region = var.region
}

# EC2 Instance
resource "aws_instance" "ec2" {
  count         = var.resource_type == "EC2" ? 1 : 0
  ami           = "ami-0c94855ba95c71c99" # Example AMI, update as needed
  instance_type = "t2.micro"
  tags = {
    Name = var.instance_name
  }
}

# S3 Bucket
resource "aws_s3_bucket" "s3" {
  count = var.resource_type == "S3" ? 1 : 0
  bucket = var.bucket_name
}

# RDS Instance
resource "aws_db_instance" "rds" {
  count                     = var.resource_type == "RDS" ? 1 : 0
  identifier                = var.db_instance_identifier
  engine                    = var.db_engine
  instance_class            = "db.t3.micro"
  allocated_storage         = 20
  username                  = "admin"
  password                  = "SuperSecret123!" # Use secrets in production!
  skip_final_snapshot       = true
  publicly_accessible       = true
}
