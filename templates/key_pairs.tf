{% if aws_key_pairs is defined %}
{% for item in aws_key_pairs %}
resource "aws_key_pair" "{{ item.key_name }}" {
{% if item.key_name is defined %}
  key_name        = "{{ item.key_name }}"
{% endif %}
{% if item.key_name_prefix is defined %}
  key_name_prefix = "{{ item.key_name_prefix }}"
{% endif %}

  public_key      = "{{ item.public_key }}"

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