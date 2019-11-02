# spark-cloudproviders
Deploying Spark using each cloud provider solution (AWS-EMR, GCP-Dataproc, Azure-HDInsight)
## AWS
### Resources
Bucket, Step functions, Lambda functions
### EMR
A EMR Cluster using Terraform to deploy the jobs
## GCP
### Resources
A bucket is needed to save the Dataproc setup.
Another bucket to save the jars from the jobs.
A Service Account to deploy the Dataproc cluster
### Workflow templates
Using Google Cloud Dataproc Workflow Templates API to automate Spark and Hadoop workfload on GCP
## Azure
### HDInsight 
A HDInsight Cluster using Terraform
### Logic App
Logic App based on a json file, and it would be imported using Azure extension for VS Code

## Jars

### Examples
Initial example from https://github.com/nnkumar13/nelamalli-projects-test/blob/master/spark-examples/src/main/scala/com/nelamalli/spark/SparkSessionTest.scala 
