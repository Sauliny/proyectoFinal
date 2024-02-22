################################################################
## Archivo de configuración de Networking - Proyecto Final SE ##
## networking.tf					                                    ##
################################################################

# Creación de VPC en AWS para el Proyecto Final
resource "aws_vpc" "vpcProyFinal" {
  cidr_block = "40.0.0.0/24"
  tags = {
    Name = "vpcProyFinal"
  }
}

# Creación de Subred1 en AWS para el Proyecto Final
resource "aws_subnet" "subnetProyFinal1" {
  vpc_id                  = aws_vpc.vpcProyFinal.id
  cidr_block              = "40.0.0.0/28"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "subnetProyFinal1"
  }
}

# Creación de Subred2 en AWS para el Proyecto Final
resource "aws_subnet" "subnetProyFinal2" {
  vpc_id                  = aws_vpc.vpcProyFinal.id
  cidr_block              = "40.0.0.16/28"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "subnetProyFinal2"
  }
}

# Creación Internet Gateway en AWS para el Proyecto Final
resource "aws_internet_gateway" "igwProyFinal" {
  vpc_id = aws_vpc.vpcProyFinal.id
  tags = {
    Name = "igwProyFinal"
  }
}

# Creación de Tabla de Rutas en AWS para el Proyecto Final
resource "aws_route_table" "rtProyFinal" {
  vpc_id = aws_vpc.vpcProyFinal.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igwProyFinal.id
  }
  tags = {
    Name = "rtProyFinal"
  }
}
