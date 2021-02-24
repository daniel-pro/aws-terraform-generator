provider "aws" {
{% if region is defined %}
  region = "{{ region }}"
{% endif %}
{% if access_key is defined %}
  access_key = "{{ access_key }}"
{% endif %}
{% if secret_key is defined %}
  secret_key = "{{ secret_key }}"
{% endif %}

}

