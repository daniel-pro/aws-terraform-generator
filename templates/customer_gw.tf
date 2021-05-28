{% if aws_customer_gateways is defined %}
{% for item in aws_customer_gateways %}
resource "aws_customer_gateway" "{{ item.name }}" {
    bgp_asn = "{{ item.bgp_asn }}"
    ip_address = "{{ item.public_ip_address }}"
    type = "{{ item.type }}"

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
