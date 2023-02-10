resource "aws_eip" "lb"{
    vpc = true
    depends_on = [null_resource.health_check]
}

resource "null_resource" "helth_check"{
    provider "local-exec"{
        command = "curl https://google.com"
    }
}