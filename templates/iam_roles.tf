{% if aws_iam_roles is defined %}
{% for item in aws_iam_roles %}
resource "aws_iam_role" "{{ item.name }}" {
{% if item.name is defined %}
    name = "{{ item.name }}"
{% endif %}
    assume_role_policy =  jsonencode({{ item.json_assume_role_policy }})
{%- if item.tags is defined %}
    tags = {
{% for tag in item.tags %}
     {{ tag.name }}  = "{{ tag.value }}",
{% endfor %}
    }
{% endif %}

}
{% endfor %}
{% endif %}