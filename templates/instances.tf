{% if aws_instances is defined %}
data "aws_ebs_default_kms_key" "current" {}

{% for item in aws_instances %}

resource "aws_instance" "{{ item.name }}" {
  ami              = "{{ item.ami }}"
  instance_type    = "{{ item.instance_type }}"
{% if item.user_data is defined %}
  user_data        = "{{ item.user_data }}"
{% endif %}
{% if item.user_data_base64 is defined %}
  user_data_base64 = "{{ item.user_data_base64 }}"
{% endif %}

{% if item.key_name is defined %}
  key_name               = "{{ item.key_name }}"
{% endif %}

{% if item.monitoring is defined %}
  monitoring             = {{ item.monitoring }}
{% endif %}

{% if item.get_password_data is defined %}
  get_password_data      = "{{ item.get_password_data }}"
{% endif %}

{% if item.iam_instance_profile is defined %}
  iam_instance_profile   = aws_iam_instance_profile.{{ item.iam_instance_profile }}.name
{% endif %}

{% if item.ebs_optimized is defined %}
  ebs_optimized = "{{ item.ebs_optimized }}"
{% endif %}


{% if item.root_block_device is defined %}
  root_block_device {
{% if item.root_block_device[0].delete_on_termination is defined %}
      delete_on_termination = "{{ item.root_block_device[0].delete_on_termination }}"
{% endif %}

{% if item.root_block_device[0].encrypted is defined %}
      encrypted             = {{ item.root_block_device[0].encrypted }}
{% endif %}

{% if item.root_block_device[0].kms_key_id is defined %}
      kms_key_id            = {{ item.root_block_device[0].kms_key_id }}
{% endif %}

{% if item.root_block_device[0].iops is defined %}
      iops                  = "{{ item.root_block_device[0].iops }}"
{% endif %}
{% if item.root_block_device[0].volume_size is defined %}
      volume_size           = {{ item.root_block_device[0].volume_size }}
{% endif %}
{% if item.root_block_device[0].volume_type is defined %}
      volume_type           = "{{ item.root_block_device[0].volume_type }}"
{% endif %}
    }
{% endif %}



{% if item.ebs_block_devices is defined %}
  ebs_block_device = [
{% for ebd in item.ebs_block_devices %}
    {

      device_name           = "{{ ebd.device_name }}"
{% if ebd.delete_on_termination is defined %}
      delete_on_termination = "{{ ebd.delete_on_termination }}"
{% endif %}
{% if ebd.encrypted is defined %}
      encrypted             = "{{ ebd.encrypted }}"
{% endif %}
{% if ebd.iops is defined %}
      iops                  = "{{ ebd.iops }}"
{% endif %}
{% if ebd.kms_key_id is defined %}
      kms_key_id            = "{{ ebd.kms_key_id }}"
{% endif %}
{% if ebd.volume_size is defined %}
      volume_size           = "{{ ebd.volume_size }}"
{% endif %}
{% if ebd.volume_type is defined %}
      volume_type           = "{{ ebd.volume_type }}"
{% endif %}
{% if ebd.snapshot_id is defined %}
      snapshot_id           = "{{ ebd.snapshot_id }}"
{% endif %}

    }
{% endfor %}
  ]
{% endif %}

{% if item.source_dest_check is defined %}
  source_dest_check                    = {{ item.source_dest_check }}
{% endif %}
{% if item.disable_api_termination is defined %}
  disable_api_termination              = {{ item.disable_api_termination }}
{% endif %}
{% if item.instance_initiated_shutdown_behavior is defined %}
  instance_initiated_shutdown_behavior = {{ item.instance_initiated_shutdown_behavior }}
{% endif %}
{% if item.placement_group is defined %}
  placement_group                      = {{ item.placement_group }}
{% endif %}
{% if item.tenancy is defined %}
  tenancy                              = {{ item.tenancy }}
{% endif %}

{% if item.network_interfaces is defined %}
{% for nic in item.network_interfaces %}
network_interface {
    network_interface_id = aws_network_interface.{{ nic.name }}.id
    device_index         = {{ loop.index - 1 }}
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

{% if item.network_interfaces is defined %}
{% for nic in item.network_interfaces %}
resource "aws_network_interface" "{{ nic.name }}" {
  subnet_id   = aws_subnet.{{ nic.subnet }}.id
{% if nic.private_ips is defined %}
  private_ips = [
{% for ip in nic.private_ips %}
                  "{{ ip }}",
{% endfor %}
                ]
{% endif %}

{% if nic.security_groups is defined %}
  security_groups = [
{% for sg in nic.security_groups %}
                            "{{ sg }}",
{% endfor%}
                           ]
{% endif %}

{% if nic.tags is defined %}
  tags = {
{% for tag in item.tags %}
   {{ tag.name }}  = "{{ tag.value }}",
{% endfor %}
  }
{% endif %}

}
{% endfor %}
{% endif %}

{% endfor %}
{% endif %}
