###
#Driver injection post installation into CoreOS nodes with converged network and storage adapters - Manual method
This is a readme on how to apply the package for QLogic CNA QL4x0000 (from Dell, v 8.59) on CoreOS4.7+ kernels (4.18.0-305**)
#If there is a kernel version change, you may need a newly compiled and packaged driver version. reach out to Red Hat Support to get it.
apply driver via running: 
# make sure you are root.  don't run sudo rpm-ostree...
1) sudo -i
# inject driver in "pending deployment" that is applied during reboot
2) rpm-ostree install kmod....rpm
# next blacklist the driver module from loading in-tree driver in initramfs
3) bash blacklist-kernelargs.sh
the later optional-modprobe-blacklist.sh is for disabling loading of the qedf FC driver during OS boot in case current driver is blocking due to errors. This is not needed for general deployment.
in case this is deployed check if you are blacklisting the qede (network) as that renders ssh access inaccessible. you will need console access with local user with password.
if this is run, once booted you will need to execute modprobe qede  and modprobe qedf to load the respective network and storage drivers.
