[spark_master]
${master_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/spark_key

[spark_workers]
%{ for ip in worker_ips ~}
${ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/spark_key
%{ endfor ~}

[spark_cluster:children]
spark_master
spark_workers


[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'