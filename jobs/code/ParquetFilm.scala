package SparkSimpleApp

import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.sql._




/**
  * Test CSV to Parquet
  * ARGS:
  * 0: CSV input File
  * 1: Path where the Parquet files will be located
  */
object ParquetFilm {
  def main (args: Array[String]): Unit = {

    val sparkConf = new SparkConf()
      .setAppName("ParquetFilm")
      .set("mapreduce.fileoutputcommitter.algorithm.version", "2")
      .set("spark.sql.parquet.cacheMetadata", "false")
      .set("spark.streaming.stopGracefullyOnShutdown", "true")
    //  .setMaster("local[*]")

    if (args.length >2){
      System.err.print("Args out of bounds")
    }


    val fileCsv = args(0)
    val outputPath = args(1)

    val sc = new SparkContext(sparkConf)

    val sparkSession = SparkSession.builder
      .config(sc.getConf)
      .getOrCreate()

    var all = sparkSession.read
        .option("delimiter",",")
        .option("inferSchema","true")
        .option("header","true")
        .csv(fileCsv)


    val grouped = all.groupBy("director_name", "title_year")
      .agg(
        functions.collect_list("movie_title").as("movieTitle")
        )

  grouped.repartition(1)
    .write
    .mode(SaveMode.Overwrite)
    .partitionBy("title_year")
    .option("basepath",outputPath)
    .parquet(outputPath)



    sc.stop()
  }
}