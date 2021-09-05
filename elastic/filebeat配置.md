``` 
filebeat.inputs:  
- type: log  
 enabled: true  
 paths:  
 - /home/www/ziwei/toutiao_php/storage/logs/*.log  
 tags: ["194-ziwei-php"]  
  
- type: log  
 enabled: true  
 paths:  
 - /var/log/nginx/*error.log  
 tags: ["194-nginx-error"]  
  
filebeat.config.modules:  
 path: ${path.config}/modules.d/*.yml  
 reload.enabled: false  
setup.template.settings:  
 index.number_of_shards: 1  
setup.kibana:  
output.logstash:  
 hosts: ["10.0.40.222:30044"]  
#output.elasticsearch:  
 #hosts: ["10.0.40.222:9200"]  
processors:  
 - add_host_metadata: ~  
 - add_cloud_metadata: ~  
 - add_docker_metadata: ~  
 - add_kubernetes_metadata: ~  

```
