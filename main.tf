###########################
####  Create Linux VM #####
###########################
module "linux-virtual-machine" {
  for_each = toset([
    "linux-vm-1", "linux-vm_2"
  ])
  source              = "./linux"
  name                = each.key
  resource_group_name = "jojo-rg"

  ssh_key = {
    username   = "jojo"
    public_key = module.security-keys.ssh-public-key
  }

  image_reference = {
    offer     = "ubuntu-24_04-lts"
    publisher = "canonical"
    sku       = "server"
    version   = "latest"
  }
  depends_on = [azurerm_resource_provider_registration.azureterraform]
}

resource "azurerm_resource_provider_registration" "azureterraform" {
  name = "Microsoft.AzureTerraform"
}

###################################
##  Create Keys (.pub and .pem)  ##
###################################
module "security-keys" {
  source    = "./keys"
  algorithm = "RSA"
  rsa_bits  = 4096
}


####################################
##   Export & Download .pem Key   ##
####################################

resource "terraform_data" "download_generated_key" {
  provisioner "local-exec" {
    command = <<-EOT
        echo '${module.security-keys.ssh-private-key}' > ./'${random_id.this.hex}'.pem
        chmod 400 ./'${random_id.this.hex}'.pem
      EOT
  }
}

resource "random_id" "this" {
  byte_length = 1
}