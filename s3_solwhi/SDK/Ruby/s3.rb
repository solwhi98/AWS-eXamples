require 'aws-sdk-s3'      #importing the tool i downloaded earlier
require 'pry'             #debugging tool 
require 'securerandom'   #a built-in standard library. To generate random values  

bucket_name=ENV['BUCKET_NAME']     # ENV['BUCKET_NAME'] looks for a variable named BUCKET_NAME 그러고 그걸 bucket_name 에 저장 
puts bucket_name                  #  'puts' stands for put string. Menas: print this on the screen. 
 
# bundle exec = run this script using only the specific software versions listed in my Gemfile.lock 라는 명령

region = 'eu-central-1'
client = Aws::S3::Client.new
 
begin           # begin/rescue는 throw/catch 같은 거. If the code crashes in here, we can catch(rescue) it
    resp = client.create_bucket({        # order to create a bucket
        bucket: bucket_name,             #the name i got from bucket_name=ENV['BUCKET_NAME']
        create_bucket_configuration: {    
            location_constraint: region     # telling AWS TO "put this in ffm(eu-central-1)"
    }
})

#if AWS says BucketAlreadyOwnedByYou (Error), we jump here instead of crashing 
rescue Aws::S3::Errors::BucketAlreadyOwnedByYou 
    puts "Bucket already exists! Skipping creation..."
end 

binding.pry  # pauses the program so i can type in the terminal to check variables. 터미널에 exit 치면 프로그램 마저 돌림. exit-program 치면 프로그램 아예 중단 

nmb_of_files = 1+ rand(6)    #rand(6) picks a number from 0 to 6. By adding 1, we pick from 1 ~ 6
puts "number_of_files: #{nmb_of_files}"  # print the number to the screen so i know how many files the program is making.  

nmb_of_files.times.each do |i|         # |i| is the counter. First time i =0, and second time i = 1, ...
    puts "i: #{i}"                     #print which loop number we're on 
    filename = "file_#{i}.txt"         # create a string for the file name (file_0.txt) 
    output_path = "/tmp/#{filename}"       #define where to save the file

    #open a new file at 'output_path' in 'w' mode. |fi| represents the open file. 
     File.open(output_path, "w") do |fi|
        fi.write SecureRandom.uuid      #generate a random ID and write it into the file
     end

     File.open(output_path, 'rb') do |file|     #위랑 똑같지만 이번엔 rb (read binary) 모드  
        client.put_object(                      #tell the worker (client) to upload the object
            bucket: bucket_name, 
            key: filename, 
            body: file)
     end
end     # End of the loop. if i < nmb_of_files : goes back to the top of the loop 

# Inside the terminal: BUCKET_NAME='a name i wanna give' bundle exec ruby s3.rb  치면 먼저 버킷을 새로 만들고, 중간에 멈춤. 거기서 exit 치면 무작위 갯수로 
#파일 생성하고 그 파일들 버킷에 넣어줌. 터미널에 cat /tmp/file_0.txt 치면 파일 내용물 열람 가능 
