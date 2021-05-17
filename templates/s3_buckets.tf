{% if aws_s3_buckets is defined %}
{% for item in aws_s3_buckets %}
resource "aws_s3_bucket" "{{ item.name }}" {
    bucket        = "{{ item.name }}"
{% if item.acl is defined %}
    acl           = "{{ item.acl }}"
{% endif %}
{% if item.versioning is defined %}
    versioning {
      enabled = "{{ item.versioning }}"
    } 
{% endif %}

{%- if item.server_side_encryption_configuration is defined %}
    server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm     = "{{ item.server_side_encryption_configuration[0].sse_algorithm }}"
        }
      }
    }
{% endif %}

{%- if item.tags is defined %}
    tags = {
{% for tag in item.tags %}
     {{ tag.name }}  = "{{ tag.value }}",
{% endfor %}
    }
{% endif %}
}

resource "aws_s3_bucket_public_access_block" "{{ item.name }}_public_access_block" {
  bucket = aws_s3_bucket.{{ item.name }}.id

  block_public_acls       = {{ item.block_public_acls }}
  block_public_policy     = {{ item.block_public_policy }}
  ignore_public_acls      = {{ item.ignore_public_acls }}
  restrict_public_buckets = {{ item.restrict_public_buckets }}
  
}

{% endfor %}
{% endif %}