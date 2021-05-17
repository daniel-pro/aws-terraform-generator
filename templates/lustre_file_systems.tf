{% if aws_fsx_lustre_file_systems is defined %}
{% for item in aws_fsx_lustre_file_systems %}
resource "aws_fsx_lustre_file_system" "{{ item.name }}" {

{% if item.import_path is defined %}
  import_path      = "{{ item.import_path }}"
{% endif %}
  storage_capacity = {{ item.storage_capacity }}
  subnet_ids       = [
{% for subnet in item.subnets %}
                        aws_subnet.{{ subnet }}.id,
{% endfor %}
                     ]
{% if item.export_path is defined and item.import_path is defined %}
  export_path      = "{{ item.import_path }}"
{% endif %}
{% if item.imported_file_chunk_size is defined %}
  imported_file_chunk_size  = "{{ item.imported_file_chunk_size }}"
{% endif %}
{% if item.security_groups is defined %}
  security_group_ids = [
{% for sg in item.security_groups %}
                                aws_security_group.{{ sg }}.id,
{% endfor %}
                           ]
{% endif %}
{% if item.weekly_maintenance_start_time is defined %}
  weekly_maintenance_start_time = "{{ item.weekly_maintenance_start_time }}"
{% endif %}
{% if item.deployment_type is defined %}
  deployment_type = "{{ item.deployment_type }}"
{% endif %}
{% if item.kms_key_id is defined %}
   kms_key_id = "{{ item.kms_key_id }}"
{% endif %}
{% if item.per_unit_storage_throughput is defined %}
  per_unit_storage_throughput = {{ item.per_unit_storage_throughput }}
{% endif %}
{% if item.automatic_backup_retention_days is defined %}
  automatic_backup_retention_days = {{ item.automatic_backup_retention_days }}
{% endif %}
{% if item.storage_type is defined %}
  storage_type = "{{ item.storage_type }}"
{% endif %}
{% if item.drive_cache_type is defined %}
  drive_cache_type = "{{ item.drive_cache_type }}"
{% endif %}
{% if item.daily_automatic_backup_start_time is defined %}
  daily_automatic_backup_start_time = "{{ item.daily_automatic_backup_start_time }}"
{% endif %}
{% if item.auto_import_policy is defined %}
  auto_import_policy = "{{ item.auto_import_policy }}"
{% endif %}
{% if item.copy_tags_to_backups is defined %}
  copy_tags_to_backups = {{ item.copy_tags_to_backups }}
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
