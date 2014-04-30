# http://phusion.github.io/baseimage-docker/
FROM phusion/baseimage:0.9.9
MAINTAINER team@netengine.com.au

ENV HOME /root

# Install Ansible
RUN apt-get update
RUN apt-get install -y ansible
ADD provision /provision
RUN cp /provision/local /etc/ansible/hosts

# Configure netengine user
RUN ansible-playbook /provision/netengine.yml

# Start Runit
CMD ["/sbin/my_init"]

