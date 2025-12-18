require 'aws-sdk-s3'      #importing the tool i downloaded earlier
require 'pry'             #debugging tool 
require 'securerandom'   #a built-in standard library. To generate random values  

bucket_name=ENV['BUCKET_NAME']     # ENV['BUCKET_NAME'] looks for a variable named BUCKET_NAME 그러고 그걸 bucket_name 에 저장 
puts bucket_name                  #  'puts' stands for put string. Menas: print this on the screen. 
 
# bundle exec = run this script using only the specific software versions listed in my Gemfile.lock 라는 명령

region = 'eu-central-1'
client = Aws::S3::Client.new

begin
    resp = client.create_bucket({
        bucket: bucket_name,    
        create_bucket_configuration: {
            location_constraint: region
    }
})
rescue Aws::S3::Errors::BucketAlreadyOwnedByYou
    puts "Bucket already exists! Skipping creation..."
end 
binding.pry

nmb_of_files = 1+ rand(6) 
puts "number_of_files: #{nmb_of_files}"

nmb_of_files.times.each do |i|
    puts "i: #{i}"
    filename = "file_#{i}.txt"
    output_path = "/tmp/#{filename}"

     File.open(output_path, "w") do |fi|
        fi.write SecureRandom.uuid
     end

     File.open(output_path, 'rb') do |file|
        client.put_object(
            bucket: bucket_name, 
            key: filename, 
            body: file)
     end
end

# Inside the terminal: BUCKET_NAME='a name i wanna give' bundle exec ruby s3.rb  치면 먼저 버킷을 새로 만들고, 중간에 멈춤. 거기서 exit 치면 무작위 갯수로 
#파일 생성하고 그 파일들 버킷에 넣어줌. 터미널에 cat /tmp/file_0.txt 치면 파일 내용물 열람 가능 
