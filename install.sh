#!/bin/bash

# Set SELinux in permissive mode (effectively disabling it)
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF
yum install -y epel-release
yum install -y yum-utils device-mapper-persistent-data   lvm2
yum install  -y vim nmap-ncat tcpdump bind-utils

yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
yum updateinfo -y

yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
yum install -y docker-ce docker-ce-cli containerd.io


systemctl enable docker.service
systemctl start docker.service

systemctl enable kubelet.service

echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables

swapoff --all
sed '/centos-swap/d' /etc/fstab -i

usermod -aG docker vagrant
