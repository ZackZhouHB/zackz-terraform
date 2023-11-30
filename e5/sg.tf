# Security Group for Bastion Host
resource "aws_security_group" "e3_sg_bastion" {
  vpc_id = aws_vpc.e3_vpc.id
  name   = "e3-bastion-sg"

  # Inbound rule: Allow SSH access from your IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MY_IP] # Replace with your actual IP
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for Backend Server
resource "aws_security_group" "e3_backend_sg" {
  vpc_id = aws_vpc.e3_vpc.id
  name   = "e3-backend-sg"

  # Inbound rule: Allow traffic from Bastion Host Security Group
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.e3_sg_bastion.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
