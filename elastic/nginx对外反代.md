```
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
```
