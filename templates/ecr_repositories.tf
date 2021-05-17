{% if aws_ecr_repositories is defined %}
{% for item in aws_ecr_repositories %}
resource "aws_ecr_repository" "{{ item.name }}" {
  name                 = "{{ item.name }}"
  image_tag_mutability = "{{ item.image_tag_mutability }}"

  image_scanning_configuration {
    scan_on_push = {{ item.scan_on_push }}
  }
}
{% endfor %}
{% endif %}