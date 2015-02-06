FROM nginx

COPY html /usr/share/nginx/html
COPY bootstrap.sh /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]
