{% if aws_route_table_associations is defined %}
{% for item in aws_route_table_associations %}
resource "aws_route_table_association" "{{ item.name }}" {
{% if item.subnet_name is defined %}
  subnet_id = aws_subnet.{{ item.subnet_name }}.id
{% endif %}
{% if item.igw_name is defined %}
  gateway_id = aws_internet_gateway.{{ item.igw_name }}.id
{% endif %}
  route_table_id = aws_route_table.{{ item.rt_name }}.id

}

{% endfor %}
{% endif %}