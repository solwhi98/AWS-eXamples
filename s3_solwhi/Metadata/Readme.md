## First, creating a bucket

aws s3 mb s3://metadata-testing-bucket-1938

## creating a new file 
echo "This is the Way" > StarWars.txt

## uploading file with metadata - must've created a file already to execute this

aws s3api put-object --bucket metadata-testing-bucket-1938 --key StarWars.txt --body StarWars.txt --metadata Planet=Mars

## Getting metadata with head object

aws s3api head-object --bucket metadata-testing-bucket-1938 --key StarWars.txt 

## removing an object in the bucket

aws s3 rm s3://metadata-testing-bucket-1938/StarWars.txt 