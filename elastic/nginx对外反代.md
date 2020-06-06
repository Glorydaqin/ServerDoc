```
vi /usr/local/nginx/vhost/conf/elasticsearch.conf;
server{
        server_name _;
        listen 9222;

        location /{
            proxy_http_version 1.1;
            proxy_set_header   Connection          "";
            proxy_set_header   Host             $host;
            proxy_set_header   X-Real-IP        $remote_addr;
            proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;

            auth_basic "login";
            auth_basic_user_file /usr/local/nginx/conf/htpasswd;
            autoindex on;

            proxy_pass http://127.0.0.1:9200; 
        }

}

vi /usr/local/nginx/conf/htpasswd;
elastic:Bjkdl2N2vgQi6   # 账号:elastic 密码:elasticpass
```

#### nginx 密码加密方式
``` 

```
