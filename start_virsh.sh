virt-install --name=imagecreater.ops.fareoffice.com \
 --ram=2048 \
--vcpus=2 \
--os-type=linux \
--extra-args='ks=https://raw.githubusercontent.com/mattiashem/cloud-image/master/ks.cfg ksdevice=ens3 ip=192.168.122.90 netmask=255.255.255.0 gateway=192.168.122.1 dns=8.8.8.8' \
--disk path=/var/lib/libvirt/images/imagecreator.img,size=50 \
--location=http://mirror.centos.org/centos/7/os/x86_64/ \
--network bridge=virbr0

