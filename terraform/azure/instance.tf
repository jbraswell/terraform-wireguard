resource "azurerm_linux_virtual_machine" "wireguard" {
  name                = "wireguard-machine"
  resource_group_name = azurerm_resource_group.wireguard.name
  location            = azurerm_resource_group.wireguard.location
  size                = "Standard_F1"
  admin_username      = "wireguard"
  custom_data         = data.cloudinit_config.wireguard.rendered
  network_interface_ids = [
    azurerm_network_interface.wireguard.id,
  ]

  admin_ssh_key {
    username   = "wireguard"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_resource_group" "wireguard" {
  name     = "wireguard-${terraform.workspace}"
  location = var.region
}

resource "azurerm_virtual_network" "wireguard" {
  name                = "wireguard-${terraform.workspace}"
  address_space       = [var.vpc_cidr_block]
  location            = azurerm_resource_group.wireguard.location
  resource_group_name = azurerm_resource_group.wireguard.name
}

resource "azurerm_subnet" "wireguard" {
  name                 = "wireguard-${terraform.workspace}"
  resource_group_name  = azurerm_resource_group.wireguard.name
  virtual_network_name = azurerm_virtual_network.wireguard.name
  address_prefixes     = [cidrsubnet(var.vpc_cidr_block, 8, 0)]
}

resource "azurerm_public_ip" "wireguard" {
  name                = "wireguardPublicIP"
  location            = azurerm_resource_group.wireguard.location
  resource_group_name = azurerm_resource_group.wireguard.name
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "wireguard" {
  name                = "wireguard-${terraform.workspace}"
  location            = azurerm_resource_group.wireguard.location
  resource_group_name = azurerm_resource_group.wireguard.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "22"
    destination_address_prefix = "*"
    source_port_range          = "*"
    source_address_prefix      = local.myip
  }

  security_rule {
    name                       = "Wireguard"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    destination_port_range     = "51820"
    destination_address_prefix = "*"
    source_port_range          = "*"
    source_address_prefix      = "0.0.0.0/0"
  }
}

resource "azurerm_network_interface_security_group_association" "wireguard" {
  network_interface_id      = azurerm_network_interface.wireguard.id
  network_security_group_id = azurerm_network_security_group.wireguard.id
}

resource "azurerm_network_interface" "wireguard" {
  name                 = "wireguard-${terraform.workspace}-nic"
  location             = azurerm_resource_group.wireguard.location
  resource_group_name  = azurerm_resource_group.wireguard.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "wireguard-${terraform.workspace}"
    subnet_id                     = azurerm_subnet.wireguard.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.wireguard.id
  }
}

data "cloudinit_config" "wireguard" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = <<EOF
#cloud-config

packages:
  - wireguard
EOF
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })
  }
}
