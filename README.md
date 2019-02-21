Dell IPMI Fan Control
====

Simple ruby script / systemd service for controlling fans with a fan profile on Dell servers.

Requires a linux host OS / hypervisor (such as proxmox or debian) with IPMI / iDRAC6 enabled.
Tested on a Dell R710.

## Install (with systemd)
Install the required packages:
```
apt install lm-sensors ipmitool ruby
```

Clone the repository, and run `ruby install.rb`

The service name is `fanctrl`, and can be managed through the usual suspects of systemctl, journalctl and the like.

## Run (without systemd)
You will have to run the script manually. You can run `ruby fanctrl.rb` in a cron-job or something similar.