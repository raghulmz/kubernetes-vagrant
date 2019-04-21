# Kubernetes on Vagrant

* Clone the repo
* Create a token
* Run `vagrant up` to create a kubernetes cluster with one master node and three workers.

```bash
git clone git@github.com:raghulmz/kubernetes-vagrant.git
cd kubernetes-vagrant
echo "abcdef.0123456789abcdef" >> token
vagrant up
```


## Cluster info and configuration

The existing config creates the following cluster.

```bash
[vagrant@kube-master ~]$ kubectl get no
NAME            STATUS   ROLES    AGE   VERSION
kube-master     Ready    master   66m   v1.14.1
kube-worker-1   Ready    <none>   63m   v1.14.1
kube-worker-2   Ready    <none>   48m   v1.14.1
kube-worker-3   Ready    <none>   45m   v1.14.1
```

Edit the hashes at the top of the vagrant file to change the configuration for the machines.

```ruby
kube_master = {
        :name => "kube-master",
        :box => "bento/centos-7.4",
        :box_version => "201803.24.0 ",
        :mem => "2048",
        :cpu => "2"
    }

kube_worker = {
        :name => "kube-worker",
        :count => 3,
        :box => "bento/centos-7.4",
        :box_version => "201803.24.0 ",
        :mem => "4096",
        :cpu => "2",
    }
```

## Add extra nodes

To add a new node, increase kube_worker[:count] and vagrant up the worker. It will automatically join the cluster.

```bash
# Change kube_worker[:count] from 3 to 5
vagrant up kube-worker-4 kube-worker-5
```

## Remove nodes

* Drain the node.
```bash
[vagrant@kube-master ~]$ kubectl drain kube-worker-5 --ignore-daemonsets
node/kube-worker-5 already cordoned
WARNING: ignoring DaemonSet-managed Pods: kube-system/calico-node-cjcr8, kube-system/kube-proxy-qxvnn
evicting pod "coredns-fb8b8dccf-ztg9l"
evicting pod "nginx-7db9fccd9b-hzgl6"
evicting pod "nginx-7db9fccd9b-5x9sf"
evicting pod "calico-kube-controllers-5cbcccc885-5bc5l"
evicting pod "coredns-fb8b8dccf-h6fxn"
pod/coredns-fb8b8dccf-ztg9l evicted
pod/calico-kube-controllers-5cbcccc885-5bc5l evicted
pod/coredns-fb8b8dccf-h6fxn evicted
pod/nginx-7db9fccd9b-hzgl6 evicted
pod/nginx-7db9fccd9b-5x9sf evicted
node/kube-worker-5 evicted
```

* Halt or Destroy the node using vagrant.
```bash
vagrant halt kube-worker-5
vagrant destroy kube-worker-5
```


## Issues

If you don't like something or would like to have something more please raise an issue or send a pull request.
