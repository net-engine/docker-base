# http://phusion.github.io/baseimage-docker/
FROM phusion/baseimage:0.9.10
MAINTAINER team@netengine.com.au

ENV HOME /root

# Install Ansible
RUN echo "deb http://ppa.launchpad.net/rquillo/ansible/ubuntu trusty main" >> /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/rquillo/ansible/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 5504681D
RUN apt-get update
RUN apt-get install -y python-apt
RUN apt-get install -y ansible

# Configure the base
ADD provision /provision
RUN cp /provision/local /etc/ansible/hosts
RUN ansible-playbook /provision/netengine.yml
RUN ansible-playbook /provision/consul.yml

# Clean up
RUN rm -rf /provision
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Start Runit
CMD ["/sbin/my_init"]
