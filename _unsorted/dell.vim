

c:\windows\system3w\logfiles\srt\srttrail.txt

2017_10_24
oprava potom co uz se ani na dualbootu nedostanu do grubu
chcu opravit windows aj fedoru a pak nainstalovat ubuntu k fedore!

https://www.howtogeek.com/forum/topic/system-recovery-options-help


X:\windows\system32> diskpart

DISKPART> list disk
DISKPART> select disk 0
DISKPART> list partition

select partition 3
detail partition
== C 84GB healthy

select partition 9
detail partition
== C 153GB


chkdsk C: /f /r /v

not helpfull still no change


from fedora reload grub2 mkconfig
sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg

though still runs into the windows.


needed to check the bios settings for UEFI booting options - add new
FS1:
EFI/fedora/shim.efi
add it
and name it fedora
then make it to the top

changed to xfce
sudo dnf install @xfce-desktop-environment
restarted

but xfce when log with xfce some error 
pcibus whatever
https://askubuntu.com/questions/771899/pcie-bus-error-severity-corrected

pci=nomsi
added into grub line
grub update
reboot

did not start - lag on the fedora logo in the half of its progress
reboot
edit line of fedora 
change 
pci=nomsi
to
pci=noaer
login into wayland (gnome)
change it in the grub
reload grub - forget so goto edit line of "reboot"
restart
edit change grub on boot =e change, CTRL+X
login wayland
add grub line
RELOAD GRUB FUCKER 
then RESTART



https://hastebin.com/foxutucece.go
 D2 ~ ▶ sudo blkid
 /dev/nvme0n1: PTUUID="7f8daa44-df58-4b9f-9242-addbd504bf85" PTTYPE="gpt"
 /dev/nvme0n1p1: LABEL="ESP" UUID="0623-79FA" TYPE="vfat" PARTLABEL="EFI System Partition" PARTUUID="987e56d1-be8a-48ac-b3f1-b97c622e6aff"
 p1=fat32 = EFI PARTITION
 /dev/nvme0n1p2: PARTLABEL="Microsoft reserved partition" PARTUUID="2d51b2a9-651b-46f1-a671-ae1cfc46f52a"
 p2=win boot reserved partition
 /dev/nvme0n1p3: LABEL="cOSi" UUID="C65A38B05A389EDD" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="834a8e42-fab2-4870-930e-a9ba494bc084"
 p3=COSI
 /dev/nvme0n1p4: UUID="4693a7d4-d60c-40bc-b5ba-96f7fa944994" TYPE="ext4" PARTUUID="b1f16815-2dd2-4e49-8532-d48f0d8b94dd"
 p4=boot??
 /dev/nvme0n1p5: UUID="5eb972d6-7217-4187-aa3e-fd9297377602" TYPE="crypto_LUKS" PARTUUID="34acbb22-aab5-44cb-aa76-e6064f6de2a5"
 p5=fedora
 /dev/nvme0n1p6: UUID="5ef6d864-9ab0-4ad1-87f0-6d291a53d8c6" TYPE="crypto_LUKS" PARTUUID="e755e447-e156-440e-8fdd-7b1ba5cd2255"
 p6=srv
 /dev/nvme0n1p7: UUID="b1e251d2-ca84-474b-ac84-9b67de5fa7e9" TYPE="crypto_LUKS" PARTUUID="727cec02-d4b6-4ada-b467-f6f8beddf064"
 p7=home
 /dev/nvme0n1p8: UUID="bdc4ad37-700e-4083-85e0-7a1503504205" TYPE="crypto_LUKS" PARTUUID="5f617914-db73-44bd-8b18-cc6fc047260d"
 p8=swap
 /dev/nvme0n1p9: LABEL="DaTa" UUID="F2D291F5D291BDF3" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="37c4d3fb-cbe6-43c4-aca0-5c4aa6beacfb"
 p9=DATA
 /dev/nvme0n1p10: LABEL="WINRETOOLS" UUID="ACE0390BE038DCF0" TYPE="ntfs" PARTUUID="2914ebaa-9d1c-4e5c-a488-8f4581229d0b"
 p10=win restoration tools
 /dev/nvme0n1p11: LABEL="Image" UUID="0C7E39A07E39840C" TYPE="ntfs" PARTUUID="5ca84501-75c3-41de-b4d7-f7393ddf69b3"
 p11=win recovery image
 /dev/nvme0n1p12: UUID="ecdfbc6a-d474-4a54-8a04-1b4e0328b8b3" TYPE="crypto_LUKS" PARTLABEL="devos" PARTUUID="12440f4d-05c9-4789-847e-61a606a3d6e4"
 p12=gonna be ubuntu
 /dev/sda1: LABEL="UBUNTU 16_0" UUID="083C-4F4B" TYPE="vfat" PARTUUID="00250b65-01"
 /dev/mapper/luks-5eb972d6-7217-4187-aa3e-fd9297377602: LABEL="fedora" UUID="8b19427c-e00a-4bc2-8c72-31104246b1d9" TYPE="ext4"
 /dev/mapper/luks-bdc4ad37-700e-4083-85e0-7a1503504205: UUID="742bde34-6d93-4a85-a397-807a7cb76df9" TYPE="swap"
 /dev/mapper/luks-b1e251d2-ca84-474b-ac84-9b67de5fa7e9: LABEL="home" UUID="67809fc3-96d4-427a-b17a-bc53e0966578" TYPE="ext4"
 /dev/mapper/luks-5ef6d864-9ab0-4ad1-87f0-6d291a53d8c6: LABEL="srv" UUID="b4023c4f-cd69-4bf6-ab19-97b552254967" TYPE="ext4"

  D2 ~ ▶ sudo lsblk
  [sudo] password for D2: 
  NAME                                          MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
  sda                                             8:0    1   7.4G  0 disk  
  └─sda1                                          8:1    1   7.4G  0 part  /run/media/D2/UBUNTU 16_0
  nvme0n1                                       259:0    0   477G  0 disk  
  ├─nvme0n1p5                                   259:5    0    91G  0 part  
  │ └─luks-5eb972d6-7217-4187-aa3e-fd9297377602 253:0    0    91G  0 crypt /
  ├─nvme0n1p11                                  259:11   0    11G  0 part  
  ├─nvme0n1p3                                   259:3    0  84.5G  0 part  /hdd/win
  ├─nvme0n1p1                                   259:1    0   200M  0 part  /boot/efi
  ├─nvme0n1p8                                   259:8    0   7.8G  0 part  
  │ └─luks-bdc4ad37-700e-4083-85e0-7a1503504205 253:1    0   7.8G  0 crypt [SWAP]
  ├─nvme0n1p6                                   259:6    0    66G  0 part  
  │ └─luks-5ef6d864-9ab0-4ad1-87f0-6d291a53d8c6 253:3    0    66G  0 crypt /srv
  ├─nvme0n1p12                                  259:12   0  29.3G  0 part  
  ├─nvme0n1p4                                   259:4    0     1G  0 part  /boot
  ├─nvme0n1p10                                  259:10   0   450M  0 part  
  ├─nvme0n1p2                                   259:2    0    16M  0 part  
  ├─nvme0n1p9                                   259:9    0 143.7G  0 part  
  └─nvme0n1p7                                   259:7    0    42G  0 part  
    └─luks-b1e251d2-ca84-474b-ac84-9b67de5fa7e9 253:2    0    42G  0 crypt /home
     D2 ~ ▶ 



     IDIOT
     no change - still lag after login with xfce

     first login way normal
     then it laged on fedora logo
     then ok
     then lagged on fedora logo

     - delete the option?? 
     pci=noaer

     JUST FUCKOF

     removed pci=whatever from grub
     reloaded

     GPARTED Now works in wayland
     https://bugzilla.redhat.com/show_bug.cgi?id=1266771
     need to 
     xhost +local:

     then 
     sudo gparted
     NICE

     though i dont want to resize partition of fedora while running the fedora
     booted from flash drive fedora 25 live
     sudo dnf install gparted
     sudo gparted

     the partition is encrpyted tho.
     what to do? idk

     should be possible
     https://help.ubuntu.com/community/ResizeEncryptedPartitions
     tutor for ubunutu (apt..)

     xubuntu live flash 
     its not uefi, tho 
     bios <F2>
     advanced boot
     --> disable uefi
     = ENABLE LEGACY in BIOS
     boot sequence
     - legacy on
     - usb storage top
     apply
     restart
     flash loads (pendrivelinux - xubuntu - CEZ flash)
     when loading xubuntu 11.10
     it cannot load

     try to create latest xubuntu on the flash from win7 with 
	         multiboot - YUMI

		 xubuntu 17.04
		 on load - 
		 Missing parameter in configuration file. Keyword: path
		 gfxboot.c32: not a COM32R image
		 boot :
		 https://askubuntu.com/questions/760406/ubuntu-16-04-final-not-booting-from-stick-gfxboot-c32-not-a-com32r-image

		 press tab
		 write live
		 boot : live
		 enter

		 - seems loading - xubuntu logo pulsing
		 loong wait and?
		 loong loading of desktop
		 wifi t4chion

		 OK now for the encrypted resizing again
		 https://help.ubuntu.com/community/ResizeEncryptedPartitions

		 resized ntfs Data partition - reduce ntfs partition to make room
		 toook incredibly long!
		 like 2h
		 and only squezed 10GB

		 format the newly created partition to ext4 - 30GB

		 isnstall uefi-flash xubuntu 17.04?
		 runit live from flash
		 install it on the 30GB partition

		 rufus got
		 https://rufus.akeo.ie/
		 install 
		 ubuntu 16.04.1
		 to flash drive
		 boot flash - install ubuntu
		 on 30GB ext4 partition nothing else

		 did not checked boot dir for install
		 on boot of ubuntu only:
		 grub > 
		 shown

		 boot into fedora
		 grub2-config reload found ubuntu
		 booted into ubuntu! finally!

		 now for the encrypted resizing again
		 https://help.ubuntu.com/community/ResizeEncryptedPartitions


		 sudo modprobe dm-crypt
		 sudo cryptsetup luksOpen /dev/nvme0n1p5 crypt1
		 = fedora
		 sudo vgscan --mknodes
		 sudo vgchange -ay

		 now blkid gives me mapped fedora crypt1 partition! yay!
		 sudo blkid
		 /dev/mapper/crypt1: LABEL="fedora" UUID=".." TYPE="ext4"

		 i can mount it yay!

		 sudo mount /dev/mapper/crypt1 /mnt/fedora_map
		 du -csh /mnt/fedora_map
		 noo
		 i want
		 sudo df -h
		 /dev/mapper/crypt1 90G size, 35G used, 51G avail



		 ihad the legacy all the time on
		 killed the legacy in bios
		 only uefi now - flash boot ubuntu 16.04

		 now 
		 boot separate partition


		 copy of 
		 added to /etc/crypttab
		 added to /etc/fstab

		 copied the /ubuhome/dd to /fedorahome/dd
		 changed chown 1000:sudoers -R /fedorahome/dd
		 mv /ubuhome/ to /ubuhome_old

		 restarted
		 (reinstalled ubuntu-
		 gnome-session-flashback installed
		 also:
		 https://seravo.fi/2015/fixing-black-screen-after-login-in-ubuntu-14-04
		 but i think these things does not matter
		 )


