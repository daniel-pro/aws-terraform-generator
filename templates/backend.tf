{% if backend is defined %}
terraform {
  backend "{{ backend[0].type }}" {
{% for item in backend[0].options %}
    {{ item.key }} = "{{ item.value }}"
{% endfor %}
  }
}
{% endif %}
