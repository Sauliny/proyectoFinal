############################################################
## Archivo de configuración de ECS para proyecto Final SE ##
## ECS (Elastic Container Service)                        ##
## ecs.tf                                                 ##
############################################################

resource "aws_ecs_cluster" "ecsProyFinal" {
  name = "cluster-ecs-ProyFinal"
  tags = {
    Name = "cluster-ecs-ProyFinal"
  }
}

## Configurar Grupo de Seguridad para ECS
resource "aws_security_group" "ecs_sg_ProyFinal" {
  name_prefix = "ecs_sg_ProyFinal"
  description = "Allow all traffic within the VPC"
  vpc_id      = aws_vpc.vpcProyFinal.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpcProyFinal.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## Configurar Tarea para ECS
resource "aws_ecs_task_definition" "taskECSproyFinal" {
  family             = "taskECSproyFinal"
#  task_role_arn      = aws_iam_role.ecs_task_role.arn
#  execution_role_arn = aws_iam_role.ecs_exec_role.arn
  network_mode       = "awsvpc"
  cpu                = 256
  memory             = 256
  container_definitions = jsonencode([{
    name         = "app",
    image        = "${aws_ecr_repository.ecrProyFinal.repository_url}:latest",
    essential    = true,
    portMappings = [{ containerPort = 8080, hostPort = 8080 }],

    environment = [
      { name = "EXAMPLE SE", value = "example SE" }
    ]

  }])
}

## Configurar Servicio para ECS
resource "aws_ecs_service" "srvECSproyFinal" {
  name            = "srvECSproyFinal"
  cluster         = aws_ecs_cluster.ecsProyFinal.id
  task_definition = aws_ecs_task_definition.taskECSproyFinal.arn
  desired_count   = 2
  network_configuration {
    security_groups = [aws_security_group.ecs_sg_ProyFinal.id]
    subnets         = ["aws_subnet.subnetProyFinal1.id" , "aws_subnet.subnetProyFinal2.id"]
  }
  lifecycle {
    ignore_changes = [desired_count]
  }
}

