cat <<EOF > /etc/modprobe.d/qldevice-blacklist.conf
blacklist qed
blacklist qede
blacklist qedf
blacklist qedr
blacklist qedi
EOF
