DEVICE=$(whiptail --inputbox "What is the path to the device to encrypt?" 8 78 /dev/sdb --title "Choose device to encrypt" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    echo "Encryption cancelled. Device is unchanged."
    exit
fi
PARTITION=$(whiptail --inputbox "What should the path to the partition be?" 8 78 /dev/sdb1 --title "Choose partition to create" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    echo "Encryption cancelled. Device is unchanged."
    exit
fi
MNT_PNT=$(whiptail --inputbox "What should the mount point of the partition be?" 8 78 /media/drive2 --title "Choose partition mount point" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    echo "Encryption cancelled. Device is unchanged."
    exit
fi
whiptail --title "Warning, all data on device will be lost." --yesno "About to encrypt device $DEVICE, creating partition $PARTITION and mounting to $MNT_PNT. \
	All data on the device will be lost, do you wish to proceed?" 9 78
exitstatus=$?
if [ $exitstatus != 0 ]; then
    echo "Encryption cancelled. Device is unchanged."
    exit
fi
echo "Encrypting device $DEVICE, creating partition $PARTITION and mounting to $MNT_PNT."
# Encrypting second drive (https://davidyat.es/2015/04/03/encrypting-a-second-hard-drive-on-ubuntu-14-10-post-install/)
# delete existing partitions
sudo sfdisk --delete $DEVICE
# List existing partitions
#sudo fdisk /dev/sdb
# Create new disk label
#g
# Create new partition - use suggested defaults
#n
# Start encryption process
#sudo cryptsetup -y -v luksFormat /dev/sdb1
#sudo cryptsetup luksOpen /dev/sdb1 sdb1_crypt
#sudo mkfs.ext4 /dev/mapper/sdb1_crypt
# Mount
#sudo mkdir /media/drive2
#sudo mount /dev/mapper/sdb1_crypt /media/drive2
# Mount on startup
# Store encryption key
#sudo dd if=/dev/urandom of=/root/.keyfile bs=1024 count=4
#sudo chmod 0400 /root/.keyfile
#sudo cryptsetup luksAddKey /dev/sdb1 /root/.keyfile
# Get UUID for /dev/sdb1
#sudo blkid
# 5461b2ab-b2b2-45cd-ac7d-cb110621ec75
# add the below to /etc/crypttab
# sdb1_crypt UUID=<device UUID> /root/.keyfile luks,discard
# add the below to /etc/fstab to mount the drive on boot
# /dev/mapper/sd?X_crypt  /<mount-point>   ext4    defaults        0       2
# Restart to make sure it automatically mounts
# Make sure the user has permissions on th drive
#sudo chown $USER:$USER /media/drive2 -R