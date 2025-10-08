# Launch EC2 instance that joins ECS Cluster automatically
resource "aws_instance" "ecs_instance" {
  ami                         = data.aws_ami.ecs_optimized.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.subnet_ids[0]
  key_name                    = var.ec2_key_name
  vpc_security_group_ids      = [var.security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.ecs_instance_profile.name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              echo "ECS_CLUSTER=${var.ecs_cluster_name}" >> /etc/ecs/ecs.config
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              EOF

  tags = {
    Name = "${var.project_name}-ecs-instance"
  }
}

# Use Amazon ECS-Optimized AMI (Amazon Linux 2)
data "aws_ami" "ecs_optimized" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

# IAM role and instance profile for ECS EC2
resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.project_name}-ecs-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_instance_policy" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "${var.project_name}-ecs-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}
