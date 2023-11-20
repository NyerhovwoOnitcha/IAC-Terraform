# Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}


# Create public subnets1
resource "aws_subnet" "public" {
  count                   = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets  
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

}
# # Create public subnet2
#     resource "aws_subnet" "public2" {
#     vpc_id                     = aws_vpc.main.id
#     cidr_block                 = "10.0.2.0/24"
#     map_public_ip_on_launch    = true
#     availability_zone          = "us-east-1b"
# }
