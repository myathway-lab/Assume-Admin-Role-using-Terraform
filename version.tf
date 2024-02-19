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
