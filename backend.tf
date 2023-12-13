terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "zklogin-prover-tf-state"
    dynamodb_table = "zklogin-prover-tf-state-lock"
    key            = "zklogin-prover-frontend.tfstate"
    region         = "us-west-2"
  }
}
