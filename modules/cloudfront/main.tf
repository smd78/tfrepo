resource "aws_cloudfront_distribution" "Devsite" {
  origin {
    custom_origin_config {
      // These are all the defaults.
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    // Here we're using our S3 bucket's URL!
    domain_name = "${var.website_endpoint}"

    // This can be any name to identify this origin.
    origin_id = "${var.www_domain_name}"
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    // This needs to match the `origin_id` above.
    target_origin_id = "${var.www_domain_name}"
    min_ttl          = 0
    default_ttl      = 86400
    max_ttl          = 31536000

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  aliases = ["${var.www_domain_name}"]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${var.acmCertificate}"
    ssl_support_method  = "sni-only"
  }

  /* #not required as using custom cert above
   viewer_certificate {
    cloudfront_default_certificate = true
  }*/
}
