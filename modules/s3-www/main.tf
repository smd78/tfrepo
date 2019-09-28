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
      type        = "aws"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObjects"]
    resources = ["${aws_s3_bucket.www.arn}/*"]
  }
}
