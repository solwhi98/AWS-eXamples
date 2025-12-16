require 'aws-sdk-s3'      #importing the tool i downloaded earlier
require 'pry'             #debugging tool 
require 'securerandom'   #a built-in standard library. To generate random values  

bucket_name=ENV['BUCKET_NAME']     # ENV['BUCKET_NAME'] looks for a variable named BUCKET_NAME 그러고 그걸 bucket_name 에 저장 
puts bucket_name                  #  'puts' stands for put string. Menas: print this on the screen. 
 
# 이거 담에 터미널에 bundle exec ruby s3.rb 입력. bundle exec -> run this script using only the specific software versions listed in my Gemfile.lock 라는 명령