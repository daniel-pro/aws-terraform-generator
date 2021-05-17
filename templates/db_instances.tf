{% if aws_db_instances is defined %}
{% for item in aws_db_instances %}
resource "aws_db_instance" "{{ item.name }}" {

{% if item.identifier is defined %}
  identifier            = "{{ item.identifier }}"
{% endif %}

{% if item.name is defined %}
  name                  = "{{ item.name }}"
{% endif %}

{% if item.username is defined and item.snapshot_identifier is not defined and item.snapshot_identifier is not defined %}
  username              = "{{ item.username }}"
{% endif %}

{% if item.password is defined and item.snapshot_identifier is not defined and item.snapshot_identifier  is not defined %}
  password              =  "{{ item.password }}"
{% endif %}

{% if item.port is defined %}
  port                  = "{{ item.port }}"
{% endif %}

{% if item.engine is defined and item.snapshot_identifier is not defined and item.snapshot_identifier  is not defined %}
  engine                = "{{ item.engine }}"
{% endif %}

{% if item.engine_version is defined and item.snapshot_identifier is not defined and item.snapshot_identifier  is not defined %}
  engine_version        = "{{ item.engine_version }}"
{% endif %}

  instance_class        = "{{ item.instance_class }}"

{% if item.allocated_storage is defined and item.snapshot_identifier is not defined and item.snapshot_identifier  is not defined %}
  allocated_storage     = "{{ item.allocated_storage }}"
{% endif %}

{% if item.max_allocated_storage is defined and item.snapshot_identifier is not defined and item.snapshot_identifier  is not defined %}
  max_allocated_storage = "{{ item.max_allocated_storage }}"
{% endif %}

{% if item.storage_encrypted is defined %}
  storage_encrypted     = {{ item.storage_encrypted }}
{% endif %}

{% if item.kms_key_id is defined %}
  kms_key_id            = "{{ item.kms_key_arn }}"
{% endif %}

{% if item.vpc_security_group_ids is defined %}
  vpc_security_group_ids = [
{% for vpc_sg_id in item.vpc_security_group_ids %}
                                aws_security_group.{{ vpc_sg_id }}.id,
{% endfor %}
                           ]
{% endif %}

{% if item.db_subnet_group_name is defined %}
  db_subnet_group_name = aws_db_subnet_group.{{ item.db_subnet_group_name }}.name 
{% endif %}

{% if item.availability_zone is defined %}
  availability_zone    = "{{ item.availability_zone }}"
{% endif %}

{% if item.ca_cert_identifier is defined %}
  ca_cert_identifier          = "{{ item.ca_cert_identifier }}"
{% endif %}

{% if item.parameter_group_name is defined %}
  parameter_group_name        = "{{ item.parameter_group_name }}"
{% endif %}

{% if item.option_group_name is defined %}
  option_group_name           = "{{ item.option_group_name }}"
{% endif %}

{% if item.license_model is defined %}
  license_model               = "{{ item.license_model }}"
{% endif %}

{% if item.multi_az is defined %}
  multi_az                    = "{{ item.multi_az }}"
{% endif %}

{% if item.storage_type is defined %}
  storage_type                = "{{ item.storage_type }}"
{% endif %}

{% if item.iops is defined %}
  iops                        = "{{ item.iops }}"
{% endif %}

{% if item.publicly_accessible is defined %}
  publicly_accessible         = {{ item.publicly_accessible }}
{% endif %}

{% if item.snapshot_identifier is defined %}
  snapshot_identifier         = "{{ item.snapshot_identifier }}"
{% endif %}

{% if item.allow_major_version_upgrade is defined %}
  allow_major_version_upgrade = {{ item.allow_major_version_upgrade }}
{% endif %}

{% if item.auto_minor_version_upgrade is defined %}
  auto_minor_version_upgrade  = {{ item.auto_minor_version_upgrade }}
{% endif %}

{% if item.apply_immediately is defined %}
  apply_immediately           = {{ item.apply_immediately }}
{% endif %}

{% if item.maintenance_window is defined %}
  maintenance_window          = "{{ item.maintenance_window }}"
{% endif %}

{% if item.skip_final_snapshot is defined %}
  skip_final_snapshot         = {{ item.skip_final_snapshot }}
{% endif %}

{% if item.final_snapshot_identifier is defined %}
  final_snapshot_identifier   = "{{ item.final_snapshot_identifier }}"
{% endif %}

{% if item.copy_tags_to_snapshot is defined %}
  copy_tags_to_snapshot       = {{ item.copy_tags_to_snapshot }}
{% endif %}

{% if item.backup_retention_period is defined %}
  backup_retention_period     = {{ item.backup_retention_period }}
{% endif %}

{% if item.backup_window is defined %}
  backup_window               = "{{ item.backup_window }}"
{% endif %}

{% if item.deletion_protection is defined %}
  deletion_protection         = {{ item.deletion_protection }}
{% endif %}

{% if item.iam_database_authentication_enabled is defined %}
  iam_database_authentication_enabled   = {{ item.iam_database_authentication_enabled }}
{% endif %}

{% if item.enabled_cloudwatch_logs_exports is defined %}
  enabled_cloudwatch_logs_exports       = "{{ item.enabled_cloudwatch_logs_exports }}"
{% endif %}

{% if item.performance_insights_enabled is defined %}
  performance_insights_enabled          = {{ item.performance_insights_enabled }}
{% endif %}

{% if item.performance_insights_retention_period is defined %}
  performance_insights_retention_period = {{ item.performance_insights_retention_period }}
{% endif %}

{% if item.performance_insights_kms_key_id is defined %}
  performance_insights_kms_key_id       = "{{ item.performance_insights_kms_key_id }}"
{% endif %}

{% if item.monitoring_interval is defined %}
  monitoring_interval = {{ item.monitoring_interval }}
{% endif %}

{% if item.monitoring_role_arn is defined %}
  monitoring_role_arn = "{{ item.monitoring_role_arn }}"
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