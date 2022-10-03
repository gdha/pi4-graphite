$ kubectl apply -f ./graphite-namespace.yaml 
namespace/graphite created

$ kubectl apply -f ./graphite-secret.yaml
secret/graphite created

$ kubectl apply -f ./ghcr-secret.yaml 
secret/dockerconfigjson-github-com created

$ kubectl apply -f ./persistentvolumeclaim-graphite.yaml
persistentvolumeclaim/graphite created

$ kubectl apply -f ./statefulset_graphite.yaml 
statefulset.apps/graphite created

$ kubectl apply -f ./service_graphite.yaml 
service/graphite-svc created


# info about secrets:
https://stackoverflow.com/questions/61912589/how-can-i-use-github-packages-docker-registry-in-kubernetes-dockerconfigjson

