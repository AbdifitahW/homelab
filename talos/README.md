# TALOS HARDWARE
 
| Device | OS Disk   | Data Disk | RAM |
| --------------- | --------------- | --------------- | --------------- |
| 1x HP Elitedesk Mini (Control Plane) | 256 GB  | N/a | 8 GB |
| 1x Lenovo T480 (Worker) | 256 GB  | 512 GB | 16 GB | 

# sops issues

GPG_TTY needs to set to current TTY or you won't be able to decrypt secret.yaml 

``` bash
export GPG_TTY=$(tty)
