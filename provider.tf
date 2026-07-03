terraform {
required_version = ">=1.0.0, <2.0"
required_providers {
    ibm = {
    source = "IBM-Cloud/ibm"
    ibmcloud_api_key = var.ibmcloud_api_key
    }
}
}