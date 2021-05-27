{% if aws_vpcs is defined %}
{% for item in aws_vpcs %}
resource "aws_vpc" "{{ item.name }}" {
  cidr_block       = "{{ item.cidr_block }}"
{% if item.instance_tenancy is defined %}
  instance_tenancy = "{{ item.instance_tenancy }}"
{% endif %}

{% if item.enable_dns_support is defined %}
  enable_dns_support  = "{{ item.enable_dns_support }}"
{% endif %}

{% if item.enable_dns_hostnames is defined %}
  enable_dns_hostnames  = "{{ item.enable_dns_hostnames }}"
{% endif %}

{% if item.assign_generated_ipv6_cidr_block is defined %}
  assign_generated_ipv6_cidr_block = "{{ item.assign_generated_ipv6_cidr_block }}"
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
