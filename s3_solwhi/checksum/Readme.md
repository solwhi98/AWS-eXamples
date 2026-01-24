## creating a new S3 Bucket

'''md
aws s3 mb s3://checksums-example-ab-1964   #버킷 만드는 명령어 
'''

## creating a file to test checksum on 
'''
echo "what the hell is ths for " > myfile.txt   # myfile.txt 오브젝트에 왼쪽의 내용을 넣은거임 
'''

## get the checksum of a file for md5 

md5sum myfile.txt
# ed5450600f38d4cc701d29eaca18b1e9 myfile.txt    # 이게 md5 계산값. 문장을 조금이라도 변경하면 이 값도 확 달라짐 


## upload my file and check the etag 

'''
aws s3 cp myfile.txt s3://checksums-example-ab-1964
aws s3api head-object --bucket checksums-example-ab-1964 --key myfile.txt

'''