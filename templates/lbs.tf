{% if aws_lbs is defined %}
{% for item in aws_lbs %}
resource "aws_lb" "{{ item.name }}" {
  name               = "{{ item.name }}"
  {% if item.internal is defined %}
  internal           = {{ item.internal }}
  {% endif %}
  {% if item.load_balancer_type is defined %}
  load_balancer_type = "{{ item.load_balancer_type }}"
  {% endif %}
  {% if item.security_groups is defined %}
    security_groups    = [
  {% for security_group in item.security_groups %}
                            aws_security_group.{{ security_group }}.id,
  {% endfor %}
                          ]
  {% endif %}

  {% if item.subnets is defined %}
    subnets    = [
  {% for subnet in item.subnets %}
                            aws_subnet.{{ subnet }}.id,
  {% endfor %}
                          ]
  {% endif %}
  

  {% if item.subnet_mapping is defined %}
  {% for sm in item.subnet_mapping %}
    subnet_mapping  {
                            subnet_id = aws_subnet.{{ sm.subnet }}.id
                            {% if sm.elastic_ip is defined %}
                            allocation_id = aws_eip.{{ sm.elastic_ip }}.id
                            {% endif %}
                            {% if sm.private_ipv4_address is defined %}
                            private_ipv4_address = "{{ sm.private_ipv4_address }}"
                            {% endif %}
                            {% if sm.ipv6_address is defined %}
                            ipv6_address = "{{ sm.ipv6_address }}"
                            {% endif %}
                    }
  {% endfor %}
  {% endif %}



  {% if item.enable_deletion_protection is defined %}
  enable_deletion_protection = {{ item.enable_deletion_protection }}
  {% endif %}

  {% if item.access_logs is defined %}
  access_logs {
    bucket  = aws_s3_bucket.{{ item.access_logs.bucket }}.bucket
    {% if item.access_logs.prefix is defined %}
    prefix  = "{{ item.access_logs.prefix }}"
    {% endif %}
    {% if item.access_logs.enaled is defined %}
    enabled = {{ item.access_logs.enabled }}
    {% endif %}
  }
 {% endif %}

{%- if item.tags is defined %}
    tags = {
{% for tag in item.tags %}
     {{ tag.name }}  = "{{ tag.value }}",
{% endfor %}
    }
{% endif %}
}

}
{% endfor %}
{% endif %}
