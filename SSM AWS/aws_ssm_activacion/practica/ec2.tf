variable "instancias" {
  description = "Nombre de las instancias"
  # type = set(string)
  type = list(string)                               # se puede usar esta linea de codigo
  default = ["apache"]
  
}

resource "aws_instance" "public_instance" {
   #for_each               = var.instancias
   for_each                = toset(var.instancias)   # se puede usar esta linea de codigo
   ami                     = var.ec2_specs.ami
   instance_type           = var.ec2_specs.instance_type
   subnet_id = aws_subnet.public_subnet.id
   key_name = data.aws_key_pair.key.key_name
   vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
   user_data = file("scripts/userdata.sh")

   tags = {
    "Name" = "${each.value}-${local.sufix}"
  }
}

resource "aws_instance" "monitoring_instance" {
   #for_each               = var.instancias
   #for_each                = toset(var.instancias)   # se puede usar esta linea de codigo
   count = var.enable_monitoring ==1? 1:0
   # count = var.enable_monitoring ? 1:0
   ami                     = var.ec2_specs.ami
   instance_type           = var.ec2_specs.instance_type
   subnet_id = aws_subnet.public_subnet.id
   key_name = data.aws_key_pair.key.key_name
   vpc_security_group_ids = [aws_security_group.sg_public_instance.id]

   tags = {
    "Name" = "monitoreo-${local.sufix}"
  }
}






# variable "cadenas" {
#   type = string
#   default = "test1, test2, test3"
  
# }












  #  provisioner "local-exec" {
  #    command = "echo instancia creada con IP ${aws_instance.public_instance.public_ip} >> datos_instancia.txt"
    
  #  }

  #  provisioner "local-exec" {
  #    when = destroy
  #    command = "echo instancia ${self.public_ip} destruida >> datos_instancia.txt"
  #  }
  #   tags = {
  #    Name = "ec2-test"  # Puedes cambiar "NombreDeTuInstancia" por el nombre que desees
  #    # Puedes agregar más tags si es necesario
  #  }

  #  provisioner "remote-exec" {
  #    inline = [ "echo 'hola mundo' > saludo.txt" ]
    
  #  }

  #  connection {
  #    type = "ssh"
  #    host = self.public_ip
  #    user = "ec2-user"
  #    private_key = file("my_key.pem")
  #  }
 
  /* lifecycle {
   }*/
 


