Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_credentials] = {
  bucket: ENV['S3_BUCKET_NAME'],
  access_key_id: ENV['S3_KEY'],
  secret_access_key: ENV['S3_SECRET']
}
