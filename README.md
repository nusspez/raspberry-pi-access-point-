# Accces point raspberry pi 
this projet make raspberry pi 3 or zero to acccess point whit only install a shell script

[video of install](https://www.youtube.com/watch?v=cPRM5EOJk6c&feature=youtu.be)

## Getting Started
this raspberry pi accces point its works in raspbian jessie i test in raspberry pi zero y raspberry pi 3
in raspberry pi zero first i install the acccess point first in pi 3an then put the SD card in raspberry pi zero

- default settings

       ip:172.24.1.1
       ssid es:PI
       password raspberry

- notes

      change ssid in line 102 of code change ssid=NEWSSID
      change pasword in code line 113 change to wpa_passphrase=NEWPASWORD
  
## Prerequisites


- rapsberry pi 3

- ethernet cable

## Install

### Step 1


conect your raspberry pi to the current and the ethernet cable 

### Step 2

download the repository

        git clone git://github.com/nusspez/raspberry-pi-access-point-
  
### Step 3

Give permissions

        cd raspberry-pi-access-point-
        chmod +x "access point.sh" 
        chmod 0755 "access point.sh"

*note: include quotation marks*

### Step 4

install the access point

       sudo ./"access point.sh"

*note: include quotation marks*

### Final step

- install the acccess point 1

- remove 2

- info 3

- exit 4

## Test

conect the raspberry pi and then take your movil and in wifi setings search pi this is ypur access point

## Built With


- shell script

## Authors


- nusspez

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Acknowledgments

give me a coffee https://www.paypal.me/PezNuss

