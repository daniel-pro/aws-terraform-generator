{% if iam_instance_profiles is defined %}
{% for item in iam_instance_profiles %}
resource "aws_iam_instance_profile" "{{ item.name }}" {
    name = "{{ item.name }}"
    role = "{{ item.role }}"   

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