output "cluster_id" {
  value = aws_emr_cluster.emr_cluster.id
}

output "cluster_release_label" {
  value = aws_emr_cluster.emr_cluster.release_label
}

output "cluster_master_public_dns" {
  value = aws_emr_cluster.emr_cluster.master_public_dns
}

output "cluster_log_uri" {
  value = aws_emr_cluster.emr_cluster.log_uri
}

output "cluster_applications" {
  value = aws_emr_cluster.emr_cluster.applications
}

output "cluster_ec2_attributes" {
  value = aws_emr_cluster.emr_cluster.ec2_attributes
}

output "cluster_configurations" {
  value = aws_emr_cluster.emr_cluster.configurations
}

output "cluster_visible_to_all_users" {
  value = aws_emr_cluster.emr_cluster.visible_to_all_users
}

output "cluster_tags" {
  value = aws_emr_cluster.emr_cluster.tags
}

output "route53" {
  value = replace(
    element(
      split(
        ".",
        substr(aws_emr_cluster.emr_cluster.master_public_dns, 3, -1),
      ),
      0,
    ),
    "-",
    ".",
  )
}

