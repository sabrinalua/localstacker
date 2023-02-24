Localstacker 
===============

toolchain to setup a A fully functional local AWS cloud stack, which can be used for local development 

## Table of contents ##


1. [Getting started](#getting-started)
    1. [Using AWS CLI / AWS CDK with localstack](#with-aws)
    2. [Using Terraform with localstack](#with-tf)
2. [Troubleshooting](#ts)


<div id='getting-started'/>

Getting Started 
===============

this repo provides a docker-compose file which allows you to create a fully-functional local AWS cloud stack, `localstack`.

Installing the [Localstack CLI](https://docs.localstack.cloud/getting-started/installation/#localstack-cli) & [tflocal CLI](https://github.com/localstack/terraform-local) is highly recommended.

Start by running
```bash
docker compose up -d
```

after the container is up, verify `localstack` is running
```bash
localstack status services
```
which should output something along the lines of

```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┓
┃ Service                  ┃ Status      ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━┩
│ acm                      │ ✔ available │
│ apigateway               │ ✔ available │
│ cloudformation           │ ✔ available │
│ cloudwatch               │ ✔ available │
│ config                   │ ✔ available │
│ dynamodb                 │ ✔ available │
│ dynamodbstreams          │ ✔ available │
│ ec2                      │ ✔ available │
│ es                       │ ✔ available │
│ events                   │ ✔ available │
│ firehose                 │ ✔ available │
│ iam                      │ ✔ available │
│ kinesis                  │ ✔ available │
│ kms                      │ ✔ available │
│ lambda                   │ ✔ available │
│ logs                     │ ✔ available │
│ opensearch               │ ✔ available │
│ redshift                 │ ✔ available │
│ resource-groups          │ ✔ available │
│ resourcegroupstaggingapi │ ✔ available │
│ route53                  │ ✔ available │
│ route53resolver          │ ✔ available │
│ s3                       │ ✔ available │
│ s3control                │ ✔ available │
│ secretsmanager           │ ✔ available │
│ ses                      │ ✔ available │
│ sns                      │ ✔ available │
│ sqs                      │ ✔ available │
│ ssm                      │ ✔ available │
│ stepfunctions            │ ✔ available │
│ sts                      │ ✔ available │
│ support                  │ ✔ available │
│ swf                      │ ✔ available │
│ transcribe               │ ✔ available │
└──────────────────────────┴─────────────┘

```

<div id='with-aws'/>

## Using AWS CLI / AWS CDK with localstack ##
to develop/deploy locally using AWS CLI, include the `--endpoint` & `profile` flags with the AWS cli command, ie:

```bash
aws --endpoint-url=${AWS_ENDPOINT} s3 ls --profile=${PROFILE}
```

localstack also provides an [awslocal](https://github.com/localstack/awscli-local) toolchain, which is a drop-in replacement for localstack.
```bash
awslocal s3 ls 
```

<div id='with-tf'/>

## Using Terraform with localstack #

with the assumption that an aws profile `localstack2` exists (note, can be dummy value)

the terraform script in `tf-s3-backend-setup` creates a s3 bucket, `tfstate-s3bucket` and a dynamodb `tfstate-ddb`, for state-locking. See [here](https://developer.hashicorp.com/terraform/language/settings/backends/s3) for more details on tf s3 backend.

localstack provides the `tflocal CLI` expressly as a drop-in replacement for `terraform` local development, which we will be using. in either case, should you wish to use the `terraform`  command, you can also do so, with some additional [configurations](https://docs.localstack.cloud/user-guide/integrations/terraform/)

```bash
tflocal init
```
```bash
tflocal plan
```
```bash
tflocal apply
```


### example ###
tf-example-creates3 contains a tf config file written to use `terraform` with localstack. 


<div id='ts'/>

Troubleshooting
===============

[click here ](docs/troubleshooting/readme.md)