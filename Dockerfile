FROM nginx

# common dependencies
RUN apt-get update && apt-get -y install curl

# install consul template
RUN curl -L https://github.com/hashicorp/consul-template/releases/download/v0.6.5/consul-template_0.6.5_linux_amd64.tar.gz | tar zxvf - -C /usr/bin --strip-component 1

# install app
COPY html /usr/share/nginx/html

# configure app
COPY consul-template /consul-template
COPY bootstrap.sh /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]
