CALICO=3.26.1

curl https://raw.githubusercontent.com/projectcalico/calico/v${CALICO}/manifests/calico.yaml -O
kubectl apply -f calico.yaml