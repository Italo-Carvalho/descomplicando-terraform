resource "aws_instance" "cluster" {
  count = 3

  # ...
}


resource "null_resource" "cluster" {
  # Capta mudança em qualuqer instacia do cluster [requer preprovisionamento]
  triggers = {
    cluster_instance_ids = join(",", aws_instance.cluster.*.id)
  }

    # Pode exutar em qualquer instancia do cluster
    # Executa apenas na primeira neste caso
  connection {
    host = element(aws_instance.cluster.*.public_ip, 0)
  }

  provisioner "remote-exec" {
    inline = [
      "bootstrap-cluster.sh ${join(" ",
      aws_instance.cluster.*.private_ip)}",
    ]
  }
}