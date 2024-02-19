# Assume Role to another AWS account using Terraform.

### In this lab, we will create "Administrator" role in Master acc "582xxxxxx95" & Assume this role to itself. 
### I will create "Administrator" role in Dev acc "767xxxxxxx73" & Assume this role to Master acc "582xxxxxx95". 

I have two AWS accounts for assume role testing.

```yaml
Master account id	582xxxxxx95
Dev account id	767xxxxxxx73
```


- version.tf
    
    ```
    terraform {
      required_providers {
        aws = {
          source = "hashicorp/aws"
          version = "5.35.0"
        }
      }
    }
    
    provider "aws" {
      shared_config_files      = ["/home/vagrant/.aws/config"]
      shared_credentials_files = ["/home/vagrant/.aws/credentials"]
      profile                  = "mt-lab-master-mgmt"  #Master account id 582xxxxxx95
      alias                    = "mt-lab-master-mgmt"
    }
    
    provider "aws" {
      shared_config_files      = ["/home/vagrant/.aws/config"]
      shared_credentials_files = ["/home/vagrant/.aws/credentials"]
      profile                  = "mt-lab-dev-mgmt"  #Dev account id 767xxxxxxx73
      alias                    = "mt-lab-dev-mgmt"
    }
    ```
    

- main.tf
    
    ```yaml
    resource "aws_iam_role" "AdministratorRole-Dev" {
      name     = "AdministratorRole-Dev"
      provider = aws.mt-lab-dev-mgmt
      assume_role_policy = jsonencode(
        {
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Action" : "sts:AssumeRole",
              "Principal" : {
                "AWS" : var.Master-acc-id
              },
              "Condition" : {}
            }
        ] }
      )
      managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
    
    resource "aws_iam_role" "AdministratorRole-Master" {
      name     = "AdministratorRole-Master"
      provider = aws.mt-lab-master-mgmt
      assume_role_policy = jsonencode(
        {
          "Version" : "2012-10-17",
          "Statement" : [
            {
              "Effect" : "Allow",
              "Action" : "sts:AssumeRole",
              "Principal" : {
                "AWS" : var.Master-acc-id
              },
              "Condition" : {}
            }
        ] }
      )
      managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
    ```
    

- variables.tf
    
    ```yaml
    variable "Master-acc-id" {
      type = string
      default = "582xxxxxx95"
    }
    variable "Dev-acc-id" {
      type = string
      default = "767xxxxxxx73"
    }
    ```
    

Apply Terraform. 

Verify the roles are created. 

![image](https://github.com/myathway-lab/Assume-Admin-Role-using-Terraform/assets/157335804/7640c063-39cb-41da-bd7f-ea84cb55fc4a)


![image](https://github.com/myathway-lab/Assume-Admin-Role-using-Terraform/assets/157335804/69a0b0b7-18b3-48d5-acc7-61b03f53be4d)


Login to Master IAM account.

Switch to Dev using “AdministratorRole-Dev”. 
![image](https://github.com/myathway-lab/Assume-Admin-Role-using-Terraform/assets/157335804/9e3dbb38-200e-4af3-b612-8e1129e8f096)


Now we are able to manage everything on the Dev by using assumerole “AdministratorRole-Dev”. 

![image](https://github.com/myathway-lab/Assume-Admin-Role-using-Terraform/assets/157335804/2a471f30-185e-4786-a6ba-201f29361668)

