variable "account_guid_var" {
  type = "string"
  description = "Get the accont guid using 'bx iam accounts'"
}

variable "ibm_bmx_api_key" {
  type = "string"
  description = "Get the bluemix api key using 'bluemix iam api-key-create NAME'"
}

# Configure the IBM Cloud Provider
provider "ibm" {
  bluemix_api_key = "${var.ibm_bmx_api_key}"
}

resource "ibm_container_cluster" "majinuni_cluster" {
  name            = "majinuni"
  datacenter      = "AMS01"
  kube_version    = "1.9"
  machine_type    = "free"
  isolation       = "public"
  account_guid    = "${var.account_guid_var}"

  workers = [{
    name = "worker1"
    action = "add"
  }]

  tags = ["dev","test","hackathon"]

}

variable "secret_key" {}
