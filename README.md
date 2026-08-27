# DevOps Assessment – Terraform + Database Reliability

## Overview

This project demonstrates AWS infrastructure design using Terraform and database reliability practices using PostgreSQL, Docker Compose, SQL migrations, seed data, backup and restore scripts.

## Architecture

Internet → Application Load Balancer → ECS/Fargate → Private RDS PostgreSQL

### AWS Components

- VPC
- Public and private subnets
- Application Load Balancer
- ECS Fargate cluster and service
- ECS security group
- RDS PostgreSQL
- RDS security group
- CloudWatch logging

## Repository Structure

```text
.
├── database/
│   ├── migrations/
│   │   └── 001_schema.sql
│   └── seed/
│       ├── seed.sql
│       └── events.sql
├── infra/
│   ├── modules/
│   │   ├── network/
│   │   ├── ecs/
│   │   └── rds/
│   └── envs/
│       ├── dev/
│       └── prod/
├── scripts/
│   ├── backup.sh
│   └── restore.sh
├── docker-compose.yml
└── README.md
## Terraform Validation

Run the following commands:

```bash
cd infra/envs/dev
terraform init
terraform fmt -recursive
terraform validate
terraform plan -refresh=false
