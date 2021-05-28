{% if aws_vpn_gateways is defined %}
{% for item in aws_vpn_gateways %}
resource "aws_vpn_gateway" "{{ item.name }}" {
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