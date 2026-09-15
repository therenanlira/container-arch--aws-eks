data "terraform_remote_state" "aws_eks_vpc" {
  backend = "s3"
  config = {
    bucket = "${var.account_id}--terraform-backend"
    key    = "ct-arch/prd/aws-eks-vpc/terraform.tfstate"
    region = "us-east-2"
  }
}
