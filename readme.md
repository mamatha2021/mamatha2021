# aws-iac-module-mq

Terraform module to provision AmazonMQ resources on AWS

---


## Introduction

This module provisions the following resources:
  - ActiveMQ broker
  - RabbitMQ broker
  - Security group rules to allow access to the broker

users are created and credentials written to SSM if not passed in as variables.



## Usage

the registry shows many of our inputs as required when in fact they are optional.
The table below correctly indicates which inputs are required.



For a complete example,

```hcl 
module "aws_Rabbit_MQ" {
  source = "..//"

  m_create_aws_ActiveMQ = false
  m_create_aws_RabbitMQ = true

  m_broker_name         = "RabbitMQ"
  m_deployment_mode     = "single_instance"
  m_engine_type         = "RabbitMQ" #"RabbitMQ" "ActiveMQ"
  m_engine_version      = "3.10.10"  #"3.10.10"  #"5.15.9"
  m_publicly_accessible = "false"
  m_host_instance_type  = "mq.t3.micro"
  m_storage_type        = "ebs" #"efs"
  m_subnet_ids          = ["subnet-0ab40c91d0ee14098"]
  m_username            = "ExampleUser"
  m_password            = "dummy_password"
  m_security_group      = [aws_security_group.aws_MQ_security_group.id]
  m_use_aws_owned_key   = true
  m_maintenance_day_of_week = "FRIDAY"
  m_maintenance_time_of_day = "18:00"
  m_maintenance_time_zone   = "UTC"
  m_tags                    = merge(local.common_tags, { type = "MQ" })

}

module "my_secretmanager" {

  source = "git@github.com:TotalEnergiesCode/aws-iac-module-secret-manager.git?ref=v1.2.0"
  depends_on = [
    module.aws_Rabbit_MQ
  ]
  m_app_name                     = "totalenergy"
  m_secrets_manager_account_name = "totalenergyawsmq"
  m_secrets_string = {
    username = module.aws_Rabbit_MQ.mquser_name
    password = module.aws_Rabbit_MQ.mquser_password

  }

  m_secrets_manager_rotation_enabled = false
}

resource "aws_security_group" "aws_MQ_security_group" {
  name        = "MQ securitygroup"
  description = "Security group for AmazonMQ instance"
  vpc_id      = "vpc-0ba3212eaea17f061"

  ingress {
    description = "AmazonMQ access"
    from_port   = 5671
    to_port     = 5671
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "AmazonMQ access"
    from_port   = 15671
    to_port     = 15671
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "AmazonMQ access"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  ```
  
  
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=  1.1.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_awsmq"></a> [aws mq](#module) |
| <a name="module_secretmanager"></a> [this](#module\secretmanager)|

## Resources

| Name | Type |
|------|------|
| [aws_mq_broker.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mq_broker) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_security_group_rules"></a> [additional\_security\_group\_rules](#input\_additional\_security\_group\_rules) | A list of Security Group rule objects to add to the created security group, in addition to the ones<br>this module normally creates. (To suppress the module's rules, set `create_security_group` to false<br>and supply your own security group(s) via `associated_security_group_ids`.)<br>The keys and values of the objects are fully compatible with the `aws_security_group_rule` resource, except<br>for `security_group_id` which will be ignored, and the optional "key" which, if provided, must be unique and known at "plan" time.<br>For more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule<br>. | `list(any)` | `[]` | no |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_broker_arn"></a> [broker\_arn](#output\_broker\_arn) | AmazonMQ broker ARN |
| <a name="output_broker_id"></a> [broker\_id](#output\_broker\_id) | AmazonMQ broker ID |
