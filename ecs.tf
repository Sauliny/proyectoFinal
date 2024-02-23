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
resource "aws_ecs_task_definition" "task-ecs-proyfinal" {
  family                    = "taskECSproyFinal"
  network_mode              = "awsvpc"
  cpu                       = "256" # Cantidad de CPU en milicore
  memory                    = "512" # Cantidad de memoria en MiB
  requires_compatibilities  = ["FARGATE"]
# execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn = "arn:aws:iam::708734958673:role/role-name"
  container_definitions = jsonencode([
  {
    name          = "conteinerProyFinal"
    image         = "708734958673.dkr.ecr.us-east-1.amazonaws.com/registry-proyfinal:latest"
    cpu           = 256 # Cantidad de CPU en milicore
    memory        = 512 # Cantidad de memoria en MiB
    essential     = true
    portMappings  = [
      { 
        containerPort = 80
        hostPort = 80 
      }
    ]
  }
  ])
}

## Se configura el Servicio para ECS
resource "aws_ecs_service" "srv-ecs-proyfinal" {
  name                = "srv-ecs-proyfinal"
  cluster             = aws_ecs_cluster.ecsProyFinal.id
  task_definition     = aws_ecs_task_definition.task-ecs-proyfinal.arn
  desired_count       = 2   # cantidad de instancias para ejecutar
  iam_role            = aws_iam_role.ecs_task_execution_role.arn
#  depends_on          = [aws_iam_role_policy.ecs_iam_role_policy]   

  # Configuración del servicio para Fargate
  launch_type = "FARGATE"
  
   # Configuración de red
  network_configuration {
    security_groups   = [aws_security_group.ecs_sg_ProyFinal.id]
    subnets           = [aws_subnet.subnetproyfinal1.id , aws_subnet.subnetproyfinal2.id]
    assign_public_ip  = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.lb-tg-proyfinal.arn
    container_name   = "conteinerProyFinal"
    container_port   = 80
  }
  /*
  lifecycle {
    ignore_changes = [desired_count]
  }
*/  
}