lang en_US.utf8
keyboard us
timezone --utc UTC
auth --useshadow --enablemd5
selinux --disabled
firewall --disabled
# TODO: the sizing of the image needs to be more dynamic
part / --size 2048 --fstype ext2

# additional default boot parameters
# Need to use deadline Scheduler for performance, rhbz#647301
# VM timekeeping: Do not allow C2 state, rhbz#647300
bootloader --timeout=30 --append="elevator=deadline max_loop=256"

# not included by default in Fedora 10 livecd initramfs
device virtio_blk
device virtio_pci
device scsi_wait_scan

# multipath kmods
device dm-multipath
device dm-round-robin
device dm-emc
device dm-rdac
device dm-hp-sw
device scsi_dh_rdac

# add missing scsi modules to initramfs
device 3w-9xxx
device 3w-sas
device 3w-xxxx
device a100u2w
device aacraid
device xhci-hcd
device aic79xx
device aic94xx
device arcmsr
device atp870u
device be2iscsi
device bfa
device broadcom
device BusLogic
device cciss
device cxgb3i
device dc395x
device fnic
device gdth
device hpsa
device hptiop
device imm
device initio
device ips
device isci
device libosd
device libsas
device libsrp
device lpfc
device megaraid
device megaraid_mbox
device megaraid_mm
device megaraid_sas
device mpt2sas
device mvsas
device osd
device osst
device pm8001
device pmcraid
device qla1280
device qla2xxx
device qla4xxx
device qlogicfas408
device stex
device tmscsim
#usb mass storage devices / blade cd devices / similar
device ums-sddr09
device ums-realtek
device ums-sddr55
device ums-isd200
device ums-alauda
device ums-freecom
device ums-cypress
device ums-jumpshot
device ums-onetouch
device ums-karma
device ums-usbat
device ums-datafab
device ums-eneub6250
