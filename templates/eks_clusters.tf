{% if aws_eks_clusters is defined %}
{% for item in aws_eks_clusters %}
resource "aws_eks_cluster" "{{ item.name }}" {
  name     = "{{ item.name }}"
  role_arn = aws_iam_role.{{ item.role_arn }}.arn

  vpc_config {
    subnet_ids = [
{% for subnet in item.subnets %}
                   aws_subnet.{{ subnet }}.id, 
{% endfor %}
                 ]
{% if item.endpoint_private_access is defined %}
  endpoint_private_access = {{ item.endpoint_private_access }}
{% endif %}
{% if item.endpoint_public_access is defined %}
  endpoint_public_access = {{ item.endpoint_public_access }}
{% endif %}
{% if item.public_access_cidrs is defined %}
  public_access_cidrs = [
{% for pac in item.public_access_cidrs %}
                   "{{ pac }}", 
{% endfor %}
                 ]
{% endif %}
{% if item.security_group_ids is defined %}
  security_group_ids = [
{% for sgi in item.security_group_ids %}
                   "{{ sgi }}", 
{% endfor %}
                 ]
{% endif %}

 

  }
{% if item.enabled_cluster_log_types is defined %}
  enabled_cluster_log_types = [
{% for eclt in item.enabled_cluster_log_types %}
                   "{{ eclt }}", 
{% endfor %}
                 ]
{% endif %}

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  #depends_on = [
  #  aws_iam_role_policy_attachment.{{ item.name }}-AmazonEKSClusterPolicy,
  #  aws_iam_role_policy_attachment.{{ item.name }}-AmazonEKSVPCResourceController,
  #]
}

output "endpoint-{{ item.name }}" {
  value = aws_eks_cluster.{{ item.name }}.endpoint
}

output "kubeconfig-certificate-authority-data-{{ item.name }}" {
  value = aws_eks_cluster.{{ item.name }}.certificate_authority[0].data
}
{% endfor %}
{% endif %}
