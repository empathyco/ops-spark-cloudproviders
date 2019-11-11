provider "azurerm" {
  
}

resource "azurerm_resource_group" "example" {
  name     = "${var.resource_group_name}"
  location = "${var.resource_group_location}"
}

resource "azurerm_storage_account" "example" {
  name                     = "${var.azurerm_storage_account_name}"
  resource_group_name      = "${azurerm_resource_group.example.name}"
  location                 = "${azurerm_resource_group.example.location}"
  account_tier             = "${var.azurerm_storage_account_tier}"
  account_replication_type = "${var.azurerm_storage_account_replication_type}"
}

resource "azurerm_storage_container" "example" {
  name                  = "${var.azurerm_storage_container_name}" 
  storage_account_name  = "${azurerm_storage_account.example.name}"
  container_access_type = "${var.azurerm_storage_container_access_type}"
}


resource "azurerm_hdinsight_spark_cluster" "example" {
  name                = "${var.azurerm_hdinsight_spark_cluster_name}" 
  resource_group_name = "${azurerm_resource_group.example.name}"
  location            = "${azurerm_resource_group.example.location}"
  cluster_version     = "${var.azurerm_hdinsight_spark_cluster_version}" 
  tier                = "${var.azurerm_hdinsight_spark_cluster_tier}" 

  component_version {
    spark = "${var.azurerm_hdinsight_spark_cluster_spark_version}" 
  }

  gateway {
    enabled  = true
    username = "${var.azurerm_hdinsight_spark_cluster_username}"
    password = "${var.azurerm_hdinsight_spark_cluster_password}"
  }

  storage_account {
    storage_container_id = "${azurerm_storage_container.example.id}"
    storage_account_key  = "${azurerm_storage_account.example.primary_access_key}"
    is_default           = true
  }

  roles {
    head_node {
      vm_size  = "${var.azurerm_hdinsight_spark_cluster_head_node_vmsize}" 
      username = "${var.azurerm_hdinsight_spark_cluster_username}"
      password = "${var.azurerm_hdinsight_spark_cluster_password}"
    }

    worker_node {
      vm_size               = "${var.azurerm_hdinsight_spark_cluster_worker_node_vmsize}"
      username = "${var.azurerm_hdinsight_spark_cluster_username}"
      password = "${var.azurerm_hdinsight_spark_cluster_password}"
      target_instance_count = "${var.azurerm_hdinsight_spark_cluster_worker_node_target_instance_count}" 
    }

    zookeeper_node {
      vm_size  = "${var.azurerm_hdinsight_spark_cluster_zookeeper_node_vmsize}"
      username = "${var.azurerm_hdinsight_spark_cluster_username}"
      password = "${var.azurerm_hdinsight_spark_cluster_password}"
    }
  }
}


