{% if aws_vpcs is defined %}
{% for item in aws_vpcs %}
resource "aws_vpc" "{{ item.name }}" {
  cidr_block       = "{{ item.cidr_block }}"
{% if instance_tenancy is defined %}
  instance_tenancy = "{{ item.instance_tenancy }}"
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
