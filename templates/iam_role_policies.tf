{% if iam_role_policies is defined %}
{% for item in iam_role_policies %}
resource "aws_iam_role_policy" "{{ item.name }}" {
  name = "{{ item.name }}"
  role = aws_iam_role.{{ item.role }}.id
  policy =  jsonencode({{ item.json_policy }})

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