{% if aws_route_tables is defined %}
{% for item in aws_route_tables %}
resource "aws_route_table" "{{ item.name }}" {
  vpc_id     = aws_vpc.{{ item.vpc_name }}.id

{% for route in item.routes %}
  route {
    cidr_block = "{{ route.cidr_block }}"
    {{ route.target_type_id_definition }} = {{ route.target_resource_type }}.{{ route.target_name }}.id
  }
{% endfor %}

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
