## First, creating a bucket

aws s3 mb s3://metadata-testing-bucket-1938

## creating a new file 
echo "This is the Way" > StarWars.txt

## uploading file with metadata - must've created a file already to execute this

aws s3api put-object --bucket metadata-testing-bucket-1938 --key StarWars.txt --body StarWars.txt --metadata Planet=Mars