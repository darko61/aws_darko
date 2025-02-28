# Require necessary libraries
require 'aws-sdk-s3'  # AWS SDK for interacting with S3
require 'pry'         # Pry for debugging (not used in this script)
require 'securerandom' # SecureRandom for generating UUIDs

# Set up bucket name from environment variables
bucket_name = ENV['BUCKET_NAME']
region = 'eu-north-1' # Define the AWS region for bucket creation

# Initialize an AWS S3 client
client = Aws::S3::Client.new

# Create a new S3 bucket in the specified region
resp = client.create_bucket({
  bucket: bucket_name,
  create_bucket_configuration: {
    location_constraint: region
  }
})

#binding.pry

# Generate a random number of files (between 1 and 6)
number_of_files = rand(1..6)

puts "number_of_files: #{number_of_files}"

# Loop through and create/upload files
number_of_files.times do |i|
  puts "i: #{i}" # Log the current iteration number

  # Define file name and local file path
  filename = "file_#{i}.txt"
  output_file = "/tmp/#{filename}"

  # Create and write a UUID to the file
  File.open(output_file, "w") do |f|
    f.write SecureRandom.uuid
  end

  # Open the file in read-binary mode and upload to S3
  File.open(output_file, 'rb') do |f|
    client.put_object(
      bucket: bucket_name,
      key: filename,
      body: f
    )
  end
end
