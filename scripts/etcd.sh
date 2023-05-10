#!/usr/bin/env bash

echo "installing etcd operator"
# kubectl  create -f https://raw.githubusercontent.com/coreos/etcd-operator/master/example/deployment.yaml
# kubectl  rollout status -f https://raw.githubusercontent.com/coreos/etcd-operator/master/example/deployment.yaml
kubectl apply -f scripts/etcd/deployment.yaml --force
kubectl rollout status -f scripts/etcd/deployment.yaml

kubectl apply -f scripts/etcd/crd.yaml --force
kubectl rollout status -f scripts/etcd/crd.yaml

# until kubectl get thirdpartyresource cluster.etcd.coreos.com
# # until kubectl get crd cluster.etcd.coreos.com
# do
#     echo "waiting for operator"
#     sleep 2
# done

echo "pausing for 10 seconds for operator to settle"
sleep 10

# kubectl  create -f https://raw.githubusercontent.com/coreos/etcd-operator/master/example/example-etcd-cluster.yaml
kubectl  create -f scripts/etcd/example-etcd-cluster.yaml

echo "installing etcd cluster service"
# kubectl  create -f https://raw.githubusercontent.com/coreos/etcd-operator/master/example/example-etcd-cluster-nodeport-service.json
kubectl  create -f scripts/etcd/example-etcd-cluster-nodeport-service.json

echo "waiting for etcd cluster to turnup"

until kubectl  get pod example-etcd-cluster-0002
do
    echo "waiting for etcd cluster to turnup"
    sleep 2
done
