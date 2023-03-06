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
