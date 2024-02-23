############################################################
## Archivo de configuración de ECS para proyecto Final SE ##
## ECS (Elastic Container Service)                        ##
## ecs.tf                                                 ##
############################################################

## Se configura el Cluster ECS
resource "aws_ecs_cluster" "ecsProyFinal" {
  name = "cluster-ecs-ProyFinal"
  tags = {
    Name = "cluster-ecs-ProyFinal"
  }
}


## Se configura la Tarea para ECS
resource "aws_ecs_task_definition" "taskECSproyFinal" {
  family                    = "taskECSproyFinal"
  network_mode              = "awsvpc"
  cpu                       = "256" # Cantidad de CPU en milicore
  memory                    = "512" # Cantidad de memoria en MiB
  requires_compatibilities  = ["FARGATE"]
#  task_role_arn      = aws_iam_role.ecs_task_role.arn
#  execution_role_arn = aws_iam_role.ecs_exec_role.arn
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
  {
    name          = "conteinerProyFinal",
    image         = "${aws_ecr_repository.ecr-proyfinal.repository_url}:latest",
    cpu           = 256 # Cantidad de CPU en milicore
    memory        = 512 # Cantidad de memoria en MiB
    essential     = true,
    portMappings  = [{ containerPort = 80, hostPort = 80 }],
  }
  ])
}

## Se configura el Servicio para ECS
resource "aws_ecs_service" "srvECSproyFinal" {
  name            = "srvECSproyFinal"
  cluster         = aws_ecs_cluster.ecsProyFinal.id
  task_definition = aws_ecs_task_definition.taskECSproyFinal.arn
  desired_count   = 2   # cantidad de instancias para ejecutar

  # Configuración del servicio para Fargate
  launch_type = "FARGATE"
  
   # Configuración de red
  network_configuration {
    security_groups   = [aws_security_group.ecs_sg_ProyFinal.id]
    subnets           = [aws_subnet.subnetproyfinal1.id , aws_subnet.subnetproyfinal2.id]
    assign_public_ip  = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.foo.arn
    container_name   = "myapp"
    container_port   = 8080
  }
  lifecycle {
    ignore_changes = [desired_count]
  }
}