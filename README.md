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
Logic App based on a json file, and it would be imported using Azure extension for VS Code or directly from Azure console

## Jars

SparkSimpleApp.jar

### Parquet Film 

Scala code to save data in parquet from a csv input file. The job has two arguments (Input path and Outpath path)

### Filter Film

Scala code to process the data saved in parquet in the job before and filter by Film Director. The job has three arguments (Input path, output path and director name)