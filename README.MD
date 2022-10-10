# Kernel driver injection into immutable CoreOS
###
Driver injection post installation into CoreOS nodes with converged network and storage adapters - Manual method
This is a readme on how to apply the package for QLogic CNA QL4x000 (from Dell, v 8.59) on CoreOS4.7+ kernels (4.18.0-305**)
If there is a kernel version change, you may need a newly compiled and packaged driver version. reach out to Red Hat Support to get it.
The flow is the following:
- check the current driver version for records keeping. 
> uname lists the current kernel version that needs to be aligned with the driver you are trying to load, Modinfo for checking what is installed, and cat /sys/module/qedf to check what version is actually loaded

    uname -a 
    modinfo | grep qedf
    cat /sys/module/qedf/version
    
- next blacklist the driver module from loading in-tree driver in initramfs. This ensures that the in-tree driver is not preloaded
- inject driver into ostree staging (ie: pending deployment) that is applied after a reboot
> make sure you are root (sudo -i).  don't run sudo rpm-ostree

    sudo -i
    rpm-ostree install kmod....rpm
    bash blacklist-kernelargs.sh
    
> the kernel boot blacklist args are needed to ensure the old drivers are not preloaded with initramfs

> if the node already has FC volumes attached, you may need to blacklist the FC driver from OS boot as well to avoid the blocking of boot by driver errors.  This is achieved by deploying the optional /etc/modprobe.d/  files.
> also make sure that you don't loose network connectivity to OS by **not** including the qede network driver in the blacklist.

    bash optional-modprobe-blacklist.sh
  - in all cases the above settings will take effect after a reboot only
  - once rebooted, check the kernel driver versions as done in the beginning and compare
  > connect back to node and check driver versions
  > Modinfo for checking what is installed, and cat /sys/module/qedf to check what version is actually loaded
  
    modinfo | grep qedf
    cat /sys/module/qedf/version
  - if you deployed the optional modprobe configuration as well, you will need to load the driver first:    
  > modprobe will attempt to load the kernel driver on the go:
    
    modprobe qede
    modprobe qedf
  > if all worked fine and the version loaded is what was intended, you can remove the /etc/modprobe.d/qlogic-blacklist.conf file deployed as part of the optional task.
