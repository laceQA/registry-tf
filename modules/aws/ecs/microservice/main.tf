module "cluster" {
  source = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/ecs/cluster?ref=7786a6b944ff99c1f5e848f327f6512416c710aa"
  name   = "test-cluster"
}
module "listener" {
  source                          = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/alb/listener?ref=7786a6b944ff99c1f5e848f327f6512416c710aa"
  default_action_target_group_arn = module.target_group.arn
  load_balancer_arn               = module.load_balancer.arn
  port                            = 80
}
module "load_balancer" {
  source             = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/alb/load_balancer?ref=7786a6b944ff99c1f5e848f327f6512416c710aa"
  name               = "test-lb-name"
  security_group_ids = [module.security_group.security_group_id]
  subnet_ids         = module.vpc.public_subnet_ids
}
module "log_group" {
  source = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/cloudwatch/log_group?ref=7786a6b944ff99c1f5e848f327f6512416c710aa"
  name   = "test-lace-log-group"
}
module "repository" {
  source = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/ecr/repository?ref=7786a6b944ff99c1f5e848f327f6512416c710aa"
  name   = "test-ecs-repository-name"
}
module "role" {
  source             = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/iam/role?ref=254a248d30bd941f8c2f2b1c54707f50a9a67493"
  assume_role_policy = jsonencode({ Version = "2012-10-17", Statement = [{ Effect = "Allow", Principal = { Service = "ecs-tasks.amazonaws.com" }, Action = "sts:AssumeRole" }] })
  name               = "test-role"
}
module "security_group" {
  source = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/ec2/security_group?ref=7786a6b944ff99c1f5e848f327f6512416c710aa"
  name   = "test-security-group"
  vpc_id = module.vpc.id
}
module "service" {
  source             = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/ecs/service?ref=7786a6b944ff99c1f5e848f327f6512416c710aa"
  cluster_id         = module.cluster.id
  container_name     = "app"
  container_port     = 80
  launch_type        = "FARGATE"
  name               = "test-service"
  security_group_ids = [module.security_group.security_group_id]
  subnet_ids         = module.vpc.public_subnet_ids
  target_group_arn   = module.target_group.arn
  task_definition    = module.task_definition.arn
}
module "target_group" {
  source = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/alb/target_group?ref=7786a6b944ff99c1f5e848f327f6512416c710aa"
  name   = "test-target-group"
  port   = 80
  vpc_id = module.vpc.id
}
module "task_definition" {
  source                = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/ecs/task_definition?ref=7786a6b944ff99c1f5e848f327f6512416c710aa"
  container_definitions = jsonencode([{ name = "app", image = "${module.repository.repository_url}:latest", essential = true, portMappings = [{ containerPort = 80, hostPort = 80, protocol = "tcp" }], logConfiguration = { logDriver = "awslogs", options = { awslogs-group = module.log_group.log_group_name, awslogs-region = var.aws_region, awslogs-stream-prefix = "ecs" } } }])
  cpu                   = 256
  execution_role_arn    = module.role.role_arn
  family                = "test-task"
  memory                = 512
}
module "vpc" {
  source     = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/vpc?ref=9451c7cffba19f0d891dd19212e0e5c54b4d6ab0"
  cidr_block = "10.0.0.0/16"
  name       = "test-vpc"
}
