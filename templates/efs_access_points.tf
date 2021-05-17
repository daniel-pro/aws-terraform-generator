{% if aws_efs_access_points is defined %}
{% for item in  aws_efs_access_points %}
resource "aws_efs_access_point" "{{ item.name }}" {
  file_system_id = aws_efs_file_system.{{ item.file_system }}.id
{% if item.posix_user is defined %}
  posix_user = "{{ item.posix_user }}"
{% endif %}
{% if item.root_directory is defined %}
  root_directory {
{% if item.root_directory[0].path is defined %}
                     path = "{{ item.root_directory[0].path }}"    
{% endif %}
{% if item.root_directory[0].creation_info is defined %}
                     creation_info {
                       owner_uid   =  "{{ item.root_directory[0].creation_info[0].owner_uid }}"
                       owner_gid   =  "{{ item.root_directory[0].creation_info[0].owner_gid }}"
                       permissions =  "{{ item.root_directory[0].creation_info[0].permissions }}"
                     }   
{% endif %}
                   }
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