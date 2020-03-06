provider "aws" {
  region = "us-east-2"
  version = "~> 2.8"
  shared_credentials_file = "$HOME/.aws/credentials"
  profile = "yemin"
}
