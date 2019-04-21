#!/bin/bash
kubeadm join $(cat /vagrant/master_ip):6443 --token abcdef.0123456789abcdef --discovery-token-unsafe-skip-ca-verification
