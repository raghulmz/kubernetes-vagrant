#!/bin/bash
ip -4 address show dev enp0s8 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' > /vagrant/master_ip

cp /vagrant/kubeadm-init.yaml /root/kubeadm-init.yaml
sed -i "s/{advertise-address}/$(cat /vagrant/master_ip)" /root/kubeadm-init.yaml
sed -i "s/{advertise-address}/$(cat /vagrant/token)" /root/kubeadm-init.yaml

kubeadm init --config /root/kubeadm-init.yaml

mkdir /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant: /home/vagrant/.kube

sudo -u vagrant kubectl apply -f \
https://docs.projectcalico.org/v3.6/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml
