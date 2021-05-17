{% if aws_network_acls is defined %}
{% for item in aws_network_acls %}
resource "aws_network_acl" "{{ item.name }}" {
   vpc_id     = aws_vpc.{{ item.vpc_name }}.id
    
{% if item.ingress_rules is defined %}
{% for ingress_rule in item.ingress_rules %}
   ingress {
     from_port   = {{ ingress_rule.from_port }}
     to_port     = {{ ingress_rule.to_port }}
     protocol    = "{{ ingress_rule.protocol }}"
     rule_no     = {{ ingress_rule.rule_no }}
     action      = "{{ ingress_rule.action }}"
 
{% if ingress_rule.cidr_blocks is defined %}
     cidr_block  = {{ ingress_rule.cidr_block }}
{% endif %}
    }
{% endfor %}
{% endif %}

{% if item.egress_rules is defined %}
{% for egress_rule in item.egress_rules %}
   egress {
     from_port   = {{ egress_rule.from_port }}
     to_port     = {{ egress_rule.to_port }}
     protocol    = "{{ egress_rule.protocol }}"
     rule_no     = {{ egress_rule.rule_no }}
     action      = "{{ egress_rule.action }}"
 
{% if egress_rule.cidr_blocks is defined %}
     cidr_block  = {{ egress_rule.cidr_block }}
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
