provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = var.workspace_iam_role_emr
  }
}

terraform {
  backend "remote" {
    organization = "empathy"

    workspaces {
      name = "devfest-emr"
    }
  }
}

resource "aws_emr_cluster" "emr_cluster" {
  name                   = var.emr_cluster_name
  release_label          = var.release_label
  applications           = ["Spark", "Livy"]
  log_uri                = var.log_uri
  termination_protection = false
  configurations         = file(var.configurations)
  keep_job_flow_alive_when_no_steps = true

  master_instance_group {
    
    instance_type  = var.instance_type_master
    instance_count = 1
    ebs_config {
      size = 32
      type = "gp2"
    }
  }

  core_instance_group {
    
    instance_type  = var.instance_type_core
    instance_count = 1

    ebs_config {
      size = 32
      type = "gp2"
    }
  }

  ec2_attributes {
    key_name                          = var.key_name
    subnet_id                         = element(var.subnet_ids, 1)
    additional_master_security_groups = var.additional_master_security_groups
    additional_slave_security_groups  = var.additional_slave_security_groups
    instance_profile                  = "EMR_EC2_DefaultRole"
  }
  lifecycle {
    ignore_changes = [ec2_attributes]
  }

  bootstrap_action {
    name = "Startup config master"
    path = "s3://devfest-emr-2163418192/bootstrap.sh"
  }

  step {
    action_on_failure = "CONTINUE"
    name              = "Setup emrfs and jobs"

    hadoop_jar_step {
      jar  = "command-runner.jar"
      args = ["bash", "-c", "aws s3 cp s3://devfest-emr-2163418192/bootstrap_master.sh /tmp/; chmod +x /tmp/bootstrap_master.sh ; /tmp/bootstrap_master.sh"]
    }
  }
  step {
    action_on_failure = "CONTINUE"
    name              = "Setup shutdown scripts"

    hadoop_jar_step {
      jar  = "command-runner.jar"
      args = ["bash", "-c", "aws s3 cp s3://devfest-emr-2163418192/shutdown_emrfs.sh /tmp/; mv /tmp/shutdown_emrfs.sh /mnt/var/lib/instance-controller/public/shutdown-actions/shutdown_emrfs.sh ;  chmod +x /mnt/var/lib/instance-controller/public/shutdown-actions/shutdown_emrfs.sh"]
    }
  }

  tags                   = var.tagsCluster
  autoscaling_role       = var.autoscaling_role
  service_role           = var.service_role
  security_configuration = "EMR Security"
  ebs_root_volume_size   = var.root_volume_size
}

resource "aws_emr_instance_group" "task" {
  cluster_id     = "${aws_emr_cluster.emr_cluster.id}"
  instance_type  = var.instance_type_task
  instance_count = 1
  bid_price      = var.bid_price_task

  name           = "task-instance-group"
  ebs_config {
      size = 32
      type = "gp2"
  }
}