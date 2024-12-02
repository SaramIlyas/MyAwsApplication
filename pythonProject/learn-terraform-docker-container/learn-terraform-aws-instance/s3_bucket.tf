# S3 Bucket Resource
resource "aws_s3_bucket" "website_bucket" {
  bucket = "my-tf-test-bucket666"  # Ensure a unique bucket name
  tags = {
    Name = "MyWebsiteBucket"
  }
}
# S3 Bucket Website Configuration
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website_bucket.id
  index_document {
    suffix = "index.html"
  }
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.website_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "allow_public_read" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.website_bucket.bucket}/*"
    }
  ]
}
EOF
}
# Output for S3 Bucket Website URL
output "s3_bucket_website_url" {
  value = "http://${aws_s3_bucket.website_bucket.bucket}.s3-website-us-west-2.amazonaws.com"
}
# Uploading index.html to the bucket with public read permissions
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = "index.html"
  source       = "C:/Users/saram/Pycharmproject/pythonProject/learn-terraform-docker-container/index.html"
  content_type = "text/html"
}
