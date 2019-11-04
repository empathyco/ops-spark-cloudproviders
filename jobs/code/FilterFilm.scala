package SparkSimpleApp

import java.sql.Struct

import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.sql._
import org.apache.spark.sql.types.{ArrayType, IntegerType, Metadata, StringType, StructField, StructType}


/**
  * Test Filter Film
  * ARGS:
  * 0: InputPath where the parquet files are located
  * 1: OutputPath where the csv with the Filter Film will be located
  * 2: Director which we want to filter
  */
object FilterFilm {
  def main (args: Array[String]): Unit = {

    val sparkConf = new SparkConf()
      .setAppName("FilterFilm")
      .set("mapreduce.fileoutputcommitter.algorithm.version", "2")
      .set("spark.sql.parquet.cacheMetadata", "false")
      .set("spark.streaming.stopGracefullyOnShutdown", "true")
     // .setMaster("local[*]")

    if (args.length >3){
      System.err.print("Args out of bounds")
    }


    val inputPath = args(0)
    val outputPath = args(1)
    val directorFilter = args(2)


    val sc = new SparkContext(sparkConf)

    val sparkSession = SparkSession.builder
      .config(sc.getConf)
      .getOrCreate()


    val eventSchema = StructType (
      List(
        StructField("title_year", IntegerType, nullable = false),
        StructField("director_name", StringType, nullable = false),
        StructField("movieTitle", ArrayType(StringType, containsNull = false), nullable = false)
      )
    )
    var all = sparkSession.read
        .option("basepath",inputPath)
        .schema(eventSchema)
        .parquet(inputPath)

    val FilterFilms = all.filter(new Column("director_name").contains(directorFilter))

    val arrayListFilm = FilterFilms.withColumn("Title",functions.explode(new Column("movieTitle"))).drop("movieTitle")

    arrayListFilm.repartition(1)
        .write.mode(SaveMode.Append)
        .option("basepath",outputPath)
        .option("header", "true")
        .csv(outputPath)

    sc.stop()
  }
}