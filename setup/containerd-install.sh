ARCH=arm
OS=linux
CONTAINERD=1.7.5
RUNC=1.1.9
CNI=1.3.0

wget https://github.com/containerd/containerd/releases/download/v${CONTAINERD}/containerd-${CONTAINERD}-${OS}-${ARCH}64.tar.gz
sudo tar Cxzvf /usr/local containerd-${CONTAINERD}-${OS}-${ARCH}64.tar.gz
rm containerd-${CONTAINERD}-${OS}-${ARCH}64.tar.gz

wget https://github.com/opencontainers/runc/releases/download/v${RUNC}/runc.${ARCH}64
sudo install -m 755 runc.${ARCH}64 /usr/local/sbin/runc
rm runc.${ARCH}64

wget https://github.com/containernetworking/plugins/releases/download/v${CNI}/cni-plugins-${OS}-${ARCH}64-v${CNI}.tgz
sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-${OS}-${ARCH}64-v${CNI}.tgz
rm cni-plugins-${OS}-${ARCH}64-v${CNI}.tgz

sudo mkdir /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
sudo curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service

sudo systemctl daemon-reload
sudo systemctl enable --now containerd
sudo systemctl status containerd