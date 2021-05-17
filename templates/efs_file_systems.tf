{% if aws_efs_file_systems is defined %}
{% for item in aws_efs_file_systems %}
resource "aws_efs_file_system" "{{ item.name }}" {

{% if item.creation_token is defined %}
  creation_token = "{{ item.creation_token }}"
{% endif %}

{% if item.encrypted is defined %}
  encrypted = {{ item.encrypted }}
{% endif %}

{% if item.kms_key_id is defined %}
  kms_key_id = "{{ item.kms_key_id }}"
{% endif %}

{% if item.lifecycle_policy is defined %}
  lifecycle_policy {{ item.lifecycle_policy }}
{% endif %}

{% if item.performance_mode is defined %}
  performance_mode = "{{ item.performance_mode }}"
{% endif %}

{% if item.provisioned_throughput_in_mibps is defined %}
  provisioned_throughput_in_mibps = "{{ item.provisioned_throughput_in_mibps }}"
{% endif %}

{% if item.throughput_mode is defined %}
  throughput_mode = "{{ item.throughput_mode }}"
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