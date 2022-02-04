FROM mono:6.12.0.122

MAINTAINER yifan <yifan.liu@anruidigital.com>

ENV APP_WORKDIR=/app/web
ENV LANG C.UTF-8

# Create workDir
RUN mkdir -p $APP_WORKDIR
RUN mkdir -p /home/nugets
# Put Init File into image
ADD init.sh /usr/local/bin/init.sh
ADD start-nginx.sh /usr/local/bin/start-nginx.sh

# Get package 
RUN chmod a+x /usr/local/bin/init.sh
RUN chmod a+x /usr/local/bin/start-nginx.sh 
RUN apt-get update 
RUN apt-get install ca-certificates wget mc git procps nginx mono-fastcgi-server openssh-server mc git less nano -y --no-install-recommends
RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* 
RUN mkdir -p /etc/mono/registry /etc/mono/registry/LocalMachine 
# RUN wget --ca-directory=/etc/ssl/certs -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64 
ADD dumb-init_1.0.0_amd64 /usr/local/bin/dumb-init
RUN chmod a+x /usr/local/bin/dumb-init

#ENV PKG_CONFIG_PATH /usr/lib/pkgconfig


# Put nginx default
ADD config/default /etc/nginx/sites-available/
# Put Web
ADD "./Nuget.Server.Web/" $APP_WORKDIR

# Define fastcgi_params
RUN sed -i '$a fastcgi_param  PATH_INFO   \"\";' /etc/nginx/fastcgi_params
RUN sed -i '$a fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;' /etc/nginx/fastcgi_params

# Define using port 
EXPOSE 80

# change to work directory
WORKDIR $APP_WORKDIR

# Define Volume
VOLUME $APP_WORKDIR

#CMD ["ls", "-ll /usr/local/bin"]
ENTRYPOINT ["/usr/local/bin/init.sh"] 