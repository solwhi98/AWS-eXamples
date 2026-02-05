## create a bucket 
aws s3 mb s3://class-changing-bucket-1834   #젤 먼저 터미널에 넣어야 함 

## create a file
echo "helloWorld" > thisFile.txt     # 여기서 파일을 만들고 무슨 내용을 넣을지 결정 
aws s3 cp thisFile.txt s3://class-changing-bucket-1834      # 여기서 만든 파일을 aws console에 업로드. 이걸 해야 함. 

#여기까지 하고 aws console 가서 내가 만든 파일에서 storage class 확인하면 standard 로 돼 있음 

## changing the class of the file 
aws s3 cp thisFile.txt s3://class-changing-bucket-1834 --storage-class STANDARD_IA  

#11번 라인까지 터미널에 돌린 후 aws console 가서 파일 확인해보면 내가 원하던 데로 바뀌어있음 

## clean up the bucket
aws s3 rm s3://class-changing-bucket-1834/thisFile.txt
aws s3 rb s3://class-changing-bucket-1834