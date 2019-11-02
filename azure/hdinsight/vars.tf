variable "resource_group_name" {
    description = "Set resource group name"
}
variable "resource_group_location" {
    description = "Set resource group location"
}
variable "azurerm_storage_account_name" {
    description = "Set storage name"
}

variable "azurerm_storage_account_tier" {
    description = "Set storage account tier"
    default = "Standard"
}

variable "azurerm_storage_account_replication_type" {
    description = "Set storage account replication type"
    default = "LRS"
}
variable "azurerm_storage_container_name" {
    description = "Set storage container name"
}

variable "azurerm_storage_container_access_type" {
    description = "Set storage container access type"
    default = "private"
}

variable "azurerm_hdinsight_spark_cluster_name" {
    description = "Set hdinsight spark cluster name"
}

variable "azurerm_hdinsight_spark_cluster_version" {
    description = "Set hdinsight spark cluster version"
}

variable "azurerm_hdinsight_spark_cluster_spark_version" {
    description = "Set hdinsight spark cluster spark version"
}

variable "azurerm_hdinsight_spark_cluster_tier" {
    description = "Set hdinsight spark cluster tier"
}

variable "azurerm_hdinsight_spark_cluster_username" {
    description = "Set hdinsight spark cluster username"
}

variable "azurerm_hdinsight_spark_cluster_password" {
    description = "Set hdinsight spark cluster password"
}

variable "azurerm_hdinsight_spark_cluster_head_node_vmsize" {
    description = "Set hdinsight spark cluster head node vmsize"
}

variable "azurerm_hdinsight_spark_cluster_worker_node_vmsize" {
    description = "Set hdinsight spark cluster worker node vmsize"
}

variable "azurerm_hdinsight_spark_cluster_worker_node_target_instance_count" {
    description = "Set hdinsight spark cluster worker node target instance count"
}

variable "azurerm_hdinsight_spark_cluster_zookeeper_node_vmsize" {
    description = "Set hdinsight spark cluster zookeeper node vmsize"
}