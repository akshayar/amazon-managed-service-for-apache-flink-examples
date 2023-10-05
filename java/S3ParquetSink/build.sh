#!/bin/bash
bucket=$1

if [ -z "${bucket}" ]
then
    echo "Bucket name is required"
    echo "Usage: build.sh <bucket_name>"
    exit 1
else
    echo "Bucket name is ${bucket}"
fi

echo "Windowing type is sliding"
class_name=com.amazonaws.services.msf.StreamingJob
jar_name=flink-kds-s3-parquet.jar

echo "main class is ${class_name}"
echo "jar will be uploaded to s3://${bucket}/flink/${jar_name}"
echo "Building code"
mvn -q clean package -DskipTests -Dshade.mainClass=${class_name}
echo "Copying jar"
aws s3 cp target/${jar_name} s3://${bucket}/flink/${jar_name}

echo "Done"




