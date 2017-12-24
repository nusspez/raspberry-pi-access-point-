# raspberry-pi-access-point-
video of install https://www.youtube.com/watch?v=cPRM5EOJk6c&feature=youtu.be
a raspberry pi access point from raspbian jessie

step 1 preparing the raspberry pi
put raspbian jessie in a sd card

step 2 conect your raspberry pi to the current and the ethernet cable 

step 3 conect via ssh or display

step 4 open terminal an download the repository
$ git clone git://github.com/nusspez/raspberry-pi-access-point-

step 5 Give permissions
$ cd raspberry-pi-access-point-
$ chmod +x "access point.sh" 
$ chmod 0755 "access point.sh"

step 6 install the access point
$ sudo ./"access point.sh"

select 1 from install 

select 2 from remove

select 3 from info

select 4 from exit

enjoy the access point

note: include quotation marks

      ip:172.24.1.1
      ssid es:PI
      contraseña raspberry
      
     change ssid in line 102 of code change ssid=NEWSSID
     change pasword in code line 113 change to wpa_passphrase=NEWPASWORD

give me a coffee https://www.paypal.me/PezNuss

español

access point para raspberry pi

IMPORTANTE:si estas usando vnc es importante  tener conectada la raspberry pi con un cable ethernet 

puedes ver el video en youtube de la instalación https://www.youtube.com/watch?v=cPRM5EOJk6c&feature=youtu.be

para instalar el access point son necesarios los siguiente pasos

1 bajar el repositorio
$ git clone git://github.com/nusspez/raspberry-pi-access-point-
2 darle permisos con los siguientes comandos
$ cd raspberry-pi-access-point-
$ chmod +x "access point.sh" 
$ chmod 0755 "access point.sh"
3 instalar el acces point
$ sudo ./"access point.sh"   //  recuerda ejecutar con sudo el script de lo contrario no funciona 

disfruta tu access point

ip:172.24.1.1

ssid es:PI

contraseña raspberry

para cambiar la ssid en la línea 102 del codigo tienes que cambiar ssid=nombre_que_quieras

para cambiar la contraseña en la linea 113 del codigo cámbiala a wpa_passphrase=TU_NUEVA_CONTRASEÑA

recuerda puedes invitarme un café aquí https://www.paypal.me/PezNuss
