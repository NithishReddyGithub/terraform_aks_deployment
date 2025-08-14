# linux-vm.tf

# Create Virtual Network
resource "azurerm_virtual_network" "linux_vnet" {
  name                = "linux-vnet"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create Subnet
resource "azurerm_subnet" "linux_subnet" {
  name                 = "linux-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.linux_vnet.name
  address_prefixes     = var.subnet_address_prefix
}

# Create Public IP
resource "azurerm_public_ip" "linux_vm_pip" {
  name                = "linux-vm-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create Network Security Group
resource "azurerm_network_security_group" "linux_vm_nsg" {
  name                = "linux-vm-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create NIC
resource "azurerm_network_interface" "linux_vm_nic" {
  name                = "linux-vm-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.linux_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_vm_pip.id
  }
}

# Associate NSG with NIC
resource "azurerm_network_interface_security_group_association" "linux_vm_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.linux_vm_nic.id
  network_security_group_id = azurerm_network_security_group.linux_vm_nsg.id
}

# Create Linux VM
resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = "linux-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.linux_admin_username
  admin_password      = var.linux_admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.linux_vm_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}