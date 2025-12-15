# TALOS HARDWARE
 
Currently running a Single node cluster spun up with a bare metal image. The hardware is just a ***HP ELITEDESK MINI 800 G3*** 

Specs (Control Plane Node)
- 8GB DDR4
- 256 SSD
- i5 6600T

# sops issues

GPG_TTY needs to set to current TTY or you won't be able to decrypt secret.yaml 

``` bash
export GPG_TTY=$(tty)
