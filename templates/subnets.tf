{% if aws_subnets is defined %}
{% for item in aws_subnets %}
resource "aws_subnet" "{{ item.name }}" {
  vpc_id     = aws_vpc.{{ item.vpc_name }}.id
  cidr_block = "{{ item.cidr_block }}"

{% if item.availability_zone is defined %}
  availability_zone = "{{ item.availability_zone }}"
{% endif %}

{% if item.availability_zone_id is defined %}
  availability_zone_id = "{{ item.availability_zone_id }}"
{% endif %}

{% if item.ipv6_cidr_block  is defined %}
  ipv6_cidr_block = "{{ item.ipv6_cidr_block }}"
{% endif %}

{% if item.map_public_ip_on_launch  is defined %}
  map_public_ip_on_launch = "{{ item.map_public_ip_on_launch }}"
{% endif %}

{% if item.assign_ipv6_address_on_creation is defined %}
  assign_ipv6_address_on_creation = "{{ item.assign_ipv6_address_on_creation }}"
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
