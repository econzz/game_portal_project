rails g controller sessions new create destroy
rails console

admin = new Admin(email:"aa@aa.com",password:"pass")
admin.save

Admin.create(email: "aa@aa.com", password: "p0p0rinG")

https://github.com/rubyzip/rubyzip

https://prograils.com/posts/rails-5-2-active-storage-new-approach-to-file-uploads

https://stackoverflow.com/questions/16016188/how-do-you-upload-a-zip-file-and-unzip-to-s3

class S3ZipUploader

  require 'thread'
  require 'thwait'
  require 'find'

  attr_reader *%i{ bucket s3 zip failed_uploads }

  def initialize(zipfilepath, mys3creds)
    # next 4 lines are important
    @s3 = AWS::S3.new(access_key_id: mys3creds[Rails.env]['aws_access_key'],
                         secret_access_key: mys3creds[Rails.env]['aws_secret_access_key'],
                         region: 'us-west-2')
    @bucket = @s3.buckets[ mys3creds[Rails.env]['bucket'] ]

    @failed_uploads = []
    @zip = Zip::File.open(zipfilepath)

  end


  def upload_zip_contents

    rootpath = "mypath/"

    desired_threads = 10
    total_entries = zip.entries.count
    slice_size = (total_entries / desired_threats).ceil
    threads = []
    zip.entries.each_slice(slice_size) do |e_arr|
      threads << Thread.new do |et|
        e_arr.each do |e|
          result = upload_to_s3(rootpath + e.name, e.get_input_stream.read) 
          if !result
            @failed_uploads << {name: e.name, entry: e, error: err}
          end
        end
      end
    end
    ThreadsWait.all_waits(*threads)
  end

  def upload_file_to_s3(filedata,path, rewrite_basepath)
    retries = 0
    success = false
    while !success && retries < 3
      success = begin
        obj = bucket.objects[path]
        obj.write(Pathname.new(outputhtml))
        obj.acl = :public_read
        success = true
      rescue
        retries += 1
        success = false
      end
    end
    return success
  end

end

uploader = S3ZipUploader.new("/path/to/myzip.zip", MYS3CREDS)
uploader.upload_zip_contents