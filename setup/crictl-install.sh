CRICTL=1.29.0
ARCH=amd
OS=linux

wget https://github.com/kubernetes-sigs/cri-tools/releases/download/v${CRICTL}/crictl-v${CRICTL}-${OS}-${ARCH}64.tar.gz
sudo tar zxvf crictl-v${CRICTL}-${OS}-${ARCH}64.tar.gz -C /usr/local/bin
rm -f crictl-v${CRICTL}-${OS}-${ARCH}64.tar.gz

sudo crictl config \
	--set runtime-endpoint=unix:///run/containerd/containerd.sock \
	--set image-endpoint=unix:///run/containerd/containerd.sock
