# Sagemaker Endpoint Deployment

Sagemaker endpoint deployment with Serverless Lambda and API Gateway.

[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
    </li>
    <li><a href="#api-gateway">API Gateway</a></li>
    <li><a href="#serverless-lambda">Serverless Lambda</a></li>
    <li><a href="#sagemaker-endpoint">Sagemaker Endpoint</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

An AWS Sagemaker Model endpoint that loads a custom FastAPI (or other API framework) application from ECR (Elastic Container Registry) and exposes the endpoint outside of AWS via Serverless Lambda function and API Gateway.  
The Lambda function code and the API is outside the scope of this repository.

### Built With

#### AWS Services

* [Sagemaker Endpoint](https://docs.aws.amazon.com/sagemaker/latest/dg/realtime-endpoints.html)
* [API Gateway](https://aws.amazon.com/api-gateway/)
* [Lambda](https://aws.amazon.com/lambda/)
* [ECR](https://aws.amazon.com/ecr/)

#### Deployment Tools

* [Docker](https://www.docker.com/)
* [Terraform](https://www.terraform.io/)

## Getting Started

The deployment is done on AWS via Terraform. Terraform is an Infrastructure as Code (IaC) tools to deploy infrastructure using code. Terraform can be installed using Homebrew on MacOS or by following the instructions [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).  

To deploy the infrastructure, use the below commands:

```bash
terraform plan
```

This command will output the changes that will happen to the infrastructure in the CLI. No changes are applied yet. The following command is used to deploy the changes.

```bash
terraform apply
```

## API Gateway

AWS API Gateway is a fully managed service that makes it easy for developers to create, publish, maintain, monitor, and secure APIs at any scale. 

It acts as a front door for applications to access data, business logic, or functionality from back-end services, such as AWS Lambda, Amazon EC2, or any publicly accessible web service. With API Gateway, developers can quickly build RESTful APIs and WebSocket APIs, handle authentication and authorization, throttle requests, and transform and cache responses. This service simplifies the process of creating APIs and enables developers to focus on building the core logic of their applications without worrying about the underlying infrastructure.

## Serverless Lambda

AWS Lambda is a serverless compute service that allows developers to run code without provisioning or managing servers. 

Developers can upload their code and Lambda automatically handles the deployment, scaling, and execution of the code in response to triggers such as HTTP requests, database events, or file uploads. Lambda functions can be written in multiple programming languages including Python, Node.js, and Java, and they can access other AWS services seamlessly. This pay-as-you-go service eliminates the need for maintaining infrastructure, enabling developers to focus solely on writing code to implement business logic.

## Sagemaker Endpoint

AWS SageMaker Endpoint is a managed machine learning inference service provided by Amazon SageMaker. 

It allows users to deploy machine learning models trained using Amazon SageMaker or elsewhere for real-time inference. Users can create endpoints for their models with a few clicks, and SageMaker takes care of provisioning the necessary infrastructure, scaling the endpoint based on demand, and managing the deployment lifecycle. These endpoints expose a secure HTTPS endpoint, enabling applications to integrate machine learning predictions directly into their workflows. SageMaker endpoints are designed to provide low-latency and high-throughput inference, making it suitable for a wide range of real-time prediction applications.


[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-white.svg?
[linkedin-url]: https://linkedin.com/in/stelios-giannikis
