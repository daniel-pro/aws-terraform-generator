{% if aws_security_groups is defined %}
{% for item in aws_security_groups %}
resource "aws_security_group" "{{ item.name }}" {
{% if item.name is defined %}
   name       = "{{ item.name }}"
{% endif %}
{% if item.description is defined %}
   description       = "{{ item.description }}"
{% endif %}
   vpc_id     = aws_vpc.{{ item.vpc_name }}.id
    
{% if item.ingress_rules is defined %}
{% for ingress_rule in item.ingress_rules %}
   ingress {
{% if ingress_rule.description is defined %}
     description = "{{ ingress_rule.description }}"
{% endif %}
     from_port   = {{ ingress_rule.from_port }}
     to_port     = {{ ingress_rule.to_port }}
     protocol    = "{{ ingress_rule.protocol }}"
 
{% if ingress_rule.cidr_blocks is defined %}
     cidr_blocks = [
{% for cidr_block in ingress_rule.cidr_blocks %}
              {{ cidr_block }},
{% endfor %}
                      ]
{% endif %}

{% if ingress_rule.security_groups is defined %}
     security_groups = [
{% for sec_group in ingress_rule.security_groups %}
              {{ sec_group }},
{% endfor %}
                      ]
{% endif %}
    }
{% endfor %}
{% endif %}


{% if item.egress_rules is defined %}
{% for egress_rule in item.egress_rules %}
   egress {
{% if egress_rule.description is defined %}
     description = "{{ egress_rule.description }}"
{% endif %}
     from_port   = {{ egress_rule.from_port }}
     to_port     = {{ egress_rule.to_port }}
     protocol    = "{{ egress_rule.protocol }}"
 
{% if egress_rule.cidr_blocks is defined %}
     cidr_blocks = [
{% for cidr_block in egress_rule.cidr_blocks %}
              {{ cidr_block }},
{% endfor %}
                      ]
{% endif %}
    }
{% endfor %}
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
