echo "Start the installation"
./start_virsh.sh
sleep 300

echo "Start testing if the vm is shutdown"



#Run untill vm is shut down
COUNTER=0
while [  $COUNTER -lt 10 ]; do

	tmp=$(virsh list --all | grep "imagecreater.ops.fareoffice.com" | awk '{ print $3}')
	if ([ "x$tmp" == "x" ] || [ "x$tmp" != "xrunning" ])
	then
    		echo "VM does not exist or is shut down!"
    		# Try additional commands here...
		let COUNTER=COUNTER+1
	else
    		echo "VM is running!"
                sleep 30
	fi
done



echo "Clean up"
./clean_vm.sh
echo "Upload image to openstack"
echo "Remove image"

#sudo rm -rf /var/lib/libvirt/images/imagecreator.qcow2
echo "All Done"
