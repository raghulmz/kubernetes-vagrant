#!/bin/bash
kubeadm join $(cat /vagrant/master_ip):6443 --token $(cat /vagrant/token) --discovery-token-unsafe-skip-ca-verification
