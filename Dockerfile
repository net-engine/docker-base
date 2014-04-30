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

# Add NetEngine team's public keys
ADD https://gist.githubusercontent.com/dansowter/7e04518c0e1dedc85e78/raw/a0449efefba2ebd539b158b13a3b17931b0b1a2a/ne_team_public_keys /tmp/ne_keys
RUN cat /tmp/ne_keys >> /root/.ssh/authorized_keys && rm -f /tmp/ne_keys

# Start Runit
CMD ["/sbin/my_init"]

