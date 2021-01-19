variable "AWS_REGION"{
    default = "us-east-2"
}
variable "PATH_TO_PRIVATE_KEY" {
    default = "gopalkey"
}
variable "PATH_TO_PUBLIC_KEY" {
    default = "gopalkey.pub"
}

variable "AMIS"{
    type = map(string)
    default = {
    us-east-1 = "ami-0885b1f6bd170450c"
    us-east-2 = "ami-0a91cd140a1fc148a"
    us-west-1 = "ami-00831fc7c1e3ddc60"
    us-west-2 = "ami-07dd19a7900a1f049"
    }
}
