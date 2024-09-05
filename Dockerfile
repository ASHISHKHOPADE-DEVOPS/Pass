# Use CentOS latest image from Docker Hub
FROM centos:latest

# Maintainer information
LABEL maintainer="sanjay.dahiya332@gmail.com"

RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-*.repo \
    && sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo

# Install necessary packages: httpd, zip, unzip
RUN yum install -y epel-release \
                   httpd \
                   zip \
                   unzip \
                   wget  
# Set the working directory
WORKDIR /var/www/html

# Download and extract the zip file from the provided URL
RUN wget  https://www.free-css.com/assets/files/free-css-templates/download/page247/kindle.zip    


# Unzip the downloaded zip file
RUN unzip kindle.zip \
    && rm kindle.zip

# Copy the contents of extracted directory to current directory
RUN cp -rvf markups-kindle/* . \
    && rm -rf markups-kindle _MACOSX

# Expose port 80 for Apache HTTP server
EXPOSE 80

# Start Apache HTTP server in foreground when container starts
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
