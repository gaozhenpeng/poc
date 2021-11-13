terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.41.0"
    }
  }
}




provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
  password    = "wz1iAKffyvyKK6o8uPTVB6sqTBzQ8tfj"
  auth_url    = "http://10.20.20.1:5000/v3"
  region      = ""
  domain_name = "Default"
}




resource "openstack_compute_secgroup_v2" "k3s" {
  name        = "k3s"
  description = "k3s"

  rule {
    from_port   = 8472
    to_port     = 8472
    ip_protocol = "udp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 10250
    to_port     = 10250
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 6443
    to_port     = 6443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}




resource "openstack_networking_network_v2" "gcp" {
  name           = "gcp"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "gcp" {
  name       = "gcp"
  network_id = openstack_networking_network_v2.gcp.id
  cidr       = "192.168.0.0/24"
  ip_version = 4
}



resource "openstack_networking_network_v2" "aws" {
  name           = "aws"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "aws" {
  name       = "aws"
  network_id = openstack_networking_network_v2.aws.id
  cidr       = "192.168.1.0/24"
  ip_version = 4
}




data "openstack_networking_network_v2" "external" {
  name = "external"
}

resource "openstack_networking_router_v2" "gcp_aws" {
  name                = "gcp-aws-router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external.id
}

resource "openstack_networking_router_interface_v2" "gcp" {
  router_id = openstack_networking_router_v2.gcp_aws.id
  subnet_id = openstack_networking_subnet_v2.gcp.id
}

resource "openstack_networking_router_interface_v2" "aws" {
  router_id = openstack_networking_router_v2.gcp_aws.id
  subnet_id = openstack_networking_subnet_v2.aws.id
}




# k3s mariadb
resource "openstack_compute_instance_v2" "k3s_mariadb" {
  depends_on = [ openstack_networking_subnet_v2.gcp ]

  name            = "k3s_mariadb"
  image_name      = "ubuntu2004"
  flavor_name     = "g1.small"
  key_pair        = "terraform"

  security_groups = [
    "default",
    openstack_compute_secgroup_v2.k3s.name
  ]

  network {
    name = "gcp"
    fixed_ip_v4 = "192.168.0.50"
  }
}

resource "openstack_networking_floatingip_v2" "k3s_mariadb_ip" {
  pool = "external"
  address = "10.20.20.50"
}

resource "openstack_compute_floatingip_associate_v2" "k3s_mariadb_ip" {
  floating_ip = openstack_networking_floatingip_v2.k3s_mariadb_ip.address
  instance_id = openstack_compute_instance_v2.k3s_mariadb.id
  fixed_ip    = openstack_compute_instance_v2.k3s_mariadb.network.0.fixed_ip_v4
}




# k3s server node
resource "openstack_compute_instance_v2" "k3s_server" {
  depends_on = [ openstack_networking_subnet_v2.gcp ]

  name            = "k3s_server"
  image_name      = "ubuntu2004"
  flavor_name     = "g1.small"
  key_pair        = "terraform"

  security_groups = [
    "default",
    openstack_compute_secgroup_v2.k3s.name
  ]

  network {
    name = "gcp"
    fixed_ip_v4 = "192.168.0.51"
  }
}

resource "openstack_networking_floatingip_v2" "k3s_server_ip" {
  pool = "external"
  address = "10.20.20.51"
}

resource "openstack_compute_floatingip_associate_v2" "k3s_server_ip" {
  floating_ip = openstack_networking_floatingip_v2.k3s_server_ip.address
  instance_id = openstack_compute_instance_v2.k3s_server.id
  fixed_ip    = openstack_compute_instance_v2.k3s_server.network.0.fixed_ip_v4
}




# s2 agent node
resource "openstack_compute_instance_v2" "s2" {
  depends_on = [ openstack_networking_subnet_v2.aws ]

  name            = "s2"
  image_name      = "ubuntu2004"
  flavor_name     = "g1.small"
  key_pair        = "terraform"

  security_groups = [
    "default",
    openstack_compute_secgroup_v2.k3s.name
  ]

  network {
    name = "aws"
    fixed_ip_v4 = "192.168.1.52"
  }
}

resource "openstack_networking_floatingip_v2" "s2_ip" {
  pool = "external"
  address = "10.20.20.52"
}

resource "openstack_compute_floatingip_associate_v2" "s2_ip" {
  floating_ip = openstack_networking_floatingip_v2.s2_ip.address
  instance_id = openstack_compute_instance_v2.s2.id
  fixed_ip    = openstack_compute_instance_v2.s2.network.0.fixed_ip_v4
}




# s3 agent node
resource "openstack_compute_instance_v2" "s3" {
  depends_on = [ openstack_networking_subnet_v2.aws ]

  name            = "s3"
  image_name      = "ubuntu2004"
  flavor_name     = "g1.small"
  key_pair        = "terraform"

  security_groups = [
    "default",
    openstack_compute_secgroup_v2.k3s.name
  ]

  network {
    name = "aws"
    fixed_ip_v4 = "192.168.1.53"
  }
}

resource "openstack_networking_floatingip_v2" "s3_ip" {
  pool = "external"
  address = "10.20.20.53"
}

resource "openstack_compute_floatingip_associate_v2" "s3_ip" {
  floating_ip = openstack_networking_floatingip_v2.s3_ip.address
  instance_id = openstack_compute_instance_v2.s3.id
  fixed_ip    = openstack_compute_instance_v2.s3.network.0.fixed_ip_v4
}

