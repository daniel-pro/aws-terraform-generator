{% if aws_db_subnet_groups is defined %}
{% for item in aws_db_subnet_groups %}
resource "aws_db_subnet_group" "{{ item.name }}" {

  name       = "{{ item.name }}"
  subnet_ids = [
{% for subnet in item.subnets %}
                aws_subnet.{{subnet}}.id,
{% endfor %}  
               ]
{% if item.description is defined %}
  description = "{{ item.description }}"
{% endif %}

{% if item.tags is defined %}
  tags = {
{% for tag in item.tags %}
   {{ tag.name }}  = "{{ tag.value }}",
{% endfor %}
  }
{% endif %}
}
{% endfor %}
{% endif %}