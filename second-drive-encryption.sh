# WARNING - this script will wipe any data on the device being encrypted being destroyed
# BACK UP YOUR DEVICE BEFORE USING THIS SCRIPT

# To undo the below (if part of it has gone wrong) do:
# sudo cryptsetup close ${DEVICE}${PARTITION}_crypt
# Then remove the relevant lines from /etc/crypttab and /etc/fstab
# THIS WILL RESULT IN THE DRIVE BEING INACCESSIBLE UNTIL IT IS FORMATTED AND ALL DATA WILL BE LOST

DEVICE=$(whiptail --inputbox "What is the device to encrypt?" 8 78 sdb --title "Choose device to encrypt" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    echo "Encryption cancelled. Device is unchanged."
    exit
fi
PARTITION=1
MNT_PNT=$(whiptail --inputbox "What should the mount point of the partition be?" 8 78 /media/drive2 --title "Choose partition mount point" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    echo "Encryption cancelled. Device is unchanged."
    exit
fi
whiptail --title "Warning, all data on device will be lost." --yesno "About to encrypt device /dev/$DEVICE, creating partition /dev/${DEVICE}${PARTITION} and mounting to $MNT_PNT. \
	All data on the device will be lost, do you wish to proceed?" 9 78
exitstatus=$?
if [ $exitstatus != 0 ]; then
    echo "Encryption cancelled. Device is unchanged."
    exit
fi
echo "Encrypting device /dev/$DEVICE, creating partition /dev/${DEVICE}${PARTITION} and mounting to $MNT_PNT."
# Encrypting second drive (https://davidyat.es/2015/04/03/encrypting-a-second-hard-drive-on-ubuntu-14-10-post-install/)
# Delete existing partitions
sudo sfdisk --delete /dev/$DEVICE
# Create new empty partition table
echo 'label: gpt' | sudo sfdisk /dev/$DEVICE
# Create a new partition that fills the entire disk
echo ',,,' | sudo sfdisk /dev/$DEVICE
# Start encryption process
sudo cryptsetup -y -v luksFormat --batch-mode /dev/${DEVICE}${PARTITION}
sudo cryptsetup luksOpen /dev/$DEVICE ${DEVICE}${PARTITION}_crypt
sudo mkfs.ext4 /dev/mapper/${DEVICE}${PARTITION}_crypt
# Mount
sudo mkdir -p $MNT_PNT
sudo mount /dev/mapper/${DEVICE}${PARTITION}_crypt $MNT_PNT
# Mount on startup
# Store encryption key
sudo dd if=/dev/urandom of=/root/.keyfile bs=1024 count=4
sudo chmod 0400 /root/.keyfile
sudo cryptsetup luksAddKey /dev/${DEVICE}${PARTITION} /root/.keyfile
# Get UUID for /dev/sdb1
UUID=$(sudo lsblk -sno UUID /dev/${DEVICE}${PARTITION})
# add the below to /etc/crypttab
echo "${DEVICE}${PARTITION}_crypt UUID=$UUID /root/.keyfile luks,discard" | sudo tee -a /etc/crypttab 
# add the below to /etc/fstab to mount the drive on boot
echo "/dev/mapper/${DEVICE}${PARTITION}_crypt  ${MNT_PNT}   ext4    defaults        0       2" | sudo tee -a /etc/fstab
# Make sure the user has permissions on th drive
sudo chown $USER:$USER /media/drive2 -R
# Restart to make sure it automatically mounts
echo "Done."
echo "Restart the machine to make sure the drive automatically mounts on start."
