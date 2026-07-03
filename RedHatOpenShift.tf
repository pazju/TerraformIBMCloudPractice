data "ibm_resource_group" "resource_group" {
    name = "default"
}

resource "ibm_container_cluster" "tfcluster" {
    name            = "tfcluster"
    datacenter      = "dal10"
    machine_type    = "b3c.4x16"
    hardware        = "shared"
    public_vlan_id  = "<public_vlan_ID_dal10>"
    private_vlan_id = "<private_vlan_ID_dal10>"

    kube_version = "3.11_openshift"

    default_pool_size = 3

    public_service_endpoint  = "true"
    private_service_endpoint = "true"

    resource_group_id = data.ibm_resource_group.resource_group.id
}


# ibmcloud oc workers --cluster tfcluster