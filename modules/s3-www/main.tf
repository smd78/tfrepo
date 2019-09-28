#s3 to host a static site
resource "aws_s3_bucket" "www" {
  bucket = "${var.bucketName}"
  acl       = "public-read"
 tags = "${merge(var.commonTags,map("role", "s3-wwww"))}"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
#bucket policy
resource "aws_s3_bucket_policy" "www_policy" {
  bucket = "${aws_s3_bucket.www.id}"
  policy = "${data.aws_iam_policy_document.www_s3_policyDoc.json}"
}
#iamPolicReadGet
data "aws_iam_policy_document" "www_s3_policyDoc" {
  statement {
    sid    = "publicReadForGetBucketObjects"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.www.arn}/*"]
  }
}

#fileupload
resource "aws_s3_bucket_object" "index_html" {
  bucket = "${aws_s3_bucket.www.id}"
  key    = "index.html"
  source = "${path.module}/html/index.html"
  content_type = "text/html"

 
  etag = 
  "${md5(file("${path.module}/html/index.html"))}"
  }
  resource "aws_s3_bucket_object" "error_html" {
  bucket = "${aws_s3_bucket.www.id}"
  key    = "error.html"
  source = "${path.module}/html/error.html"
  content_type = "text/html"

 
  etag = 
  "${md5(file("${path.module}/html/error.html"))}"
  }