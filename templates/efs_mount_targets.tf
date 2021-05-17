{% if aws_efs_mount_targets is defined %}
{% for item in aws_efs_mount_targets %}
resource "aws_efs_mount_target" "{{ item.name }}" {
  file_system_id = aws_efs_file_system.{{ item.file_system }}.id
  subnet_id      = aws_subnet.{{ item.subnet }}.id
{% if item.ip_address is defined %}
  ip_address     = "{{ item.ip_address }}"
{% endif %}

{% if item.security_groups is defined %}
  security_groups = [
{% for sg in item.security_groups %}
                                aws_security_group.{{ sg }}.id,
{% endfor %}
                           ]
{% endif %}
}
{% endfor %}
{% endif %}