data "ibm_resource_group" "group" {
    name = "default"
}

resource "ibm_cr_namespace" "cr_namespace" {
    name = "<namespace_name>"
    resource_group_id = data.ibm_resource_group.group.id
}

resource "ibm_cr_retention_policy" "cr_retention_policy" {
    namespace = ibm_cr_namespace.cr_namespace.id
    images_per_repo = 10
}

resource "ibm_iam_user_policy" "policy" {
    ibm_id = "user@ibm.com"
    roles  = ["Manager"]

    resources {
        service = "container-registry"
        resource = ibm_cr_namespace.cr_namespace.id
        resource_type = "namespace"
        region = var.region
    }
}

# El siguiente ejemplo crea un espacio de nombres en el grupo de recursos
# predeterminado con un nombre de su elección 
# y adjunta una política de retención de imágenes a ese espacio de nombres que retiene 10 imágenes. 
# Para recuperar el ID del grupo de recursos predeterminado, se utiliza el origen de datos ibm_resource_group. 
# A continuación, el usuario user@ibm.com se asigna a la función Administrador en la política de acceso de IAM 
# para el espacio de nombres de una región determinada. 
# La región se recupera del archivo terraform.tfvars que ha creado en el paso 1.