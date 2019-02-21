Dell IPMI Fan Control
====

Simple ruby script to install on a linux-based (w/ systemd) Dell hypervison, with IPMI / iDRAC6 enabled.
Tested on a Dell R710.

## Install
Install the required packages:
```
apt install lm-sensors ipmitool ruby
```

Clone the repository, and run `ruby install.rb`

The service name is `fanctrl`, and can be managed through the usual suspects of systemctl, journalctl and the like.