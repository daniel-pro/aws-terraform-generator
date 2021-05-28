{% if aws_vpn_connections is defined %}
{% for item in aws_vpn_connections %}
resource "aws_vpn_connection" "{{ item.name }}" {
    vpn_gateway_id = aws_vpn_gateway.{{ item.vpn_gw_name }}.id
    customer_gateway_id = aws_customer_gateway.{{ item.cust_gw_name }}.id
    type = "{{ item.type }}"
    static_routes_only  = "{{ item.static_routes_only }}"

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