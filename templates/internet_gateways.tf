{% if aws_internet_gateways is defined %}
{% for item in aws_internet_gateways %}
resource "aws_internet_gateway" "{{ item.name }}" {
  vpc_id     = aws_vpc.{{ item.vpc_name }}.id

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
