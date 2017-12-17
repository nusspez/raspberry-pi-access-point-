#!/bin/bash
#esto es un ejecutable para crear automaticamente un access point en raspberry pi 3
clear
echo "-----------------------------------------------------------------------------"
echo "x x   x x   x x   x x x x x    x x x x x    x x x x x x x     x x   x x   x x"
echo "x x   x x   x x   x x x x x    x x x x x    x x x x x x x     x x   x x   x x"
echo "x x   x x   x x   x x   x x    x x                  x x       x x   x x   x x"
echo "x x   x x   x x   x x x x x    x x x x x          x x         x x   x x   x x"
echo "x x   x x   x x   x x x x x    x x x x x        x x           x x   x x   x x"
echo "                  x x          x x            x x"
echo "x x   x x   x x   x x          x x x x x    x x x x x x x     x x   x x   x x"
echo "x x   x x   x x   x x          x x x x x    x x x x x x x     x x   x x   x x"
echo "-----------------------------------------------------------------------------"
echo "esto es un ejecutable para crear automaticamente un access point en la raspberry pi 3"
echo
echo
echo "===menu del instalador==="
PS3='sleccione que quiere hacer:'
opciones=("opcion1 instalar access point." "opcion2 desinstalar access point." "opcion 3 acerca de." "opcion 4 salir.")
select pez in "${opciones[@]}"
do
    case $pez in
    "opcion1 instalar access point." )
      echo "elegiste la opcion 1"
      sudo apt-get update #hacemos un update a nuestra raspberry verificando que todo este actualizado
      sudo apt-get upgrade #hacemos un upgrade para actulizar los paquetes que nececiten actualizacion
      sudo apt-get install hostapd #instalamos hostapd
      sudo apt-get install dnsmasq #instalamos dnsmasq
      cat /dev/null > /etc/dhcpcd.conf
      echo " # A sample configuration for dhcpcd.
      # See dhcpcd.conf(5) for details.

      # Allow users of this group to interact with dhcpcd via the control socket.
      #controlgroup wheel

      # Inform the DHCP server of our hostname for DDNS.
      hostname

      # Use the hardware address of the interface for the Client ID.
      clientid
      # or
      # Use the same DUID + IAID as set in DHCPv6 for DHCPv4 ClientID as per RFC4361.
      #duid

      # Persist interface configuration when dhcpcd exits.
      persistent

      # Rapid commit support.
      # Safe to enable by default because it requires the equivalent option set
      # on the server to actually work.
      option rapid_commit

      # A list of options to request from the DHCP server.
      option domain_name_servers, domain_name, domain_search, host_name
      option classless_static_routes
      # Most distributions have NTP support.
      option ntp_servers
      # Respect the network MTU.
      # Some interface drivers reset when changing the MTU so disabled by default.
      #option interface_mtu

      # A ServerID is required by RFC2131.
      require dhcp_server_identifier

      # Generate Stable Private IPv6 Addresses instead of hardware based ones
      slaac private

      # A hook script is provided to lookup the hostname if not set by the DHCP
      # server, but it should not be run by default.
      nohook lookup-hostname
      denyinterfaces wlan0 ">>/etc/dhcpcd.conf
      cat /dev/null > /etc/network/interfaces
      echo "# interfaces(5) file used by ifup(8) and ifdown(8)

      # Please note that this file is written to be used with dhcpcd
      # For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf'

      # Include files from /etc/network/interfaces.d:
      source-directory /etc/network/interfaces.d

      auto lo
      iface lo inet loopback

      iface eth0 inet manual

      allow-hotplug wlan0
      iface wlan0 inet static
          address 172.24.1.1
          netmask 255.255.255.0
          network 172.24.1.0
          broadcast 172.24.1.255

      allow-hotplug wlan1
      iface wlan1 inet manual
          wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf">>/etc/network/interfaces
      sudo service dhcpcd restart
      sudo ifdown wlan0
      sudo ifup wlan0
      cat /etc/hostapd/hostapd.conf
      echo "interface=wlan0
driver=nl80211
ssid=PI
hw_mode=g
channel=6
ieee80211n=1
wmm_enabled=1
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_key_mgmt=WPA-PSK
wpa_passphrase=conferencia
rsn_pairwise=CCMP">>/etc/hostapd/hostapd.conf
      cat /dev/null > /etc/default/hostapd
      echo '# Defaults for hostapd initscript
      #
      # See /usr/share/doc/hostapd/README.Debian for information about alternative
      # methods of managing hostapd.
      #
      # Uncomment and set DAEMON_CONF to the absolute path of a hostapd configuration
      # file and hostapd will be started during system boot. An example configuration
      # file can be found at /usr/share/doc/hostapd/examples/hostapd.conf.gz
      #
      DAEMON_CONF="/etc/hostapd/hostapd.conf"

      # Additional daemon options to be appended to hostapd command:-
      # 	-d   show more debug messages (-dd for even more)
      # 	-K   include key data in debug messages
      # 	-t   include timestamps in some debug messages
      #
      # Note that -B (daemon mode) and -P (pidfile) options are automatically
      # configured by the init.d script and must not be added to DAEMON_OPTS.
      #
      #DAEMON_OPTS=""" '>>/etc/default/hostapd
      sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
      touch /etc/dnsmasq.conf
      echo "interface=wlan0
      listen-address=172.24.1.1
      bind-interfaces
      server=8.8.8.8
      domain-needed
      bogus-priv
      dhcp-range=172.24.1.50,172.24.1.150,12h ">>/etc/dnsmasq.conf
      cat /dev/null > /etc/sysctl.conf
      echo "#
      # /etc/sysctl.conf - Configuration file for setting system variables
      # See /etc/sysctl.d/ for additional system variables.
      # See sysctl.conf (5) for information.
      #

      #kernel.domainname = example.com

      # Uncomment the following to stop low-level messages on console
      #kernel.printk = 3 4 1 3

      ##############################################################3
      # Functions previously found in netbase
      #

      # Uncomment the next two lines to enable Spoof protection (reverse-path filter)
      # Turn on Source Address Verification in all interfaces to
      # prevent some spoofing attacks
      #net.ipv4.conf.default.rp_filter=1
      #net.ipv4.conf.all.rp_filter=1

      # Uncomment the next line to enable TCP/IP SYN cookies
      # See http://lwn.net/Articles/277146/
      # Note: This may impact IPv6 TCP sessions too
      #net.ipv4.tcp_syncookies=1

      # Uncomment the next line to enable packet forwarding for IPv4
      net.ipv4.ip_forward=1

      # Uncomment the next line to enable packet forwarding for IPv6
      #  Enabling this option disables Stateless Address Autoconfiguration
      #  based on Router Advertisements for this host
      #net.ipv6.conf.all.forwarding=1


      ###################################################################
      # Additional settings - these settings can improve the network
      # security of the host and prevent against some network attacks
      # including spoofing attacks and man in the middle attacks through
      # redirection. Some network environments, however, require that these
      # settings are disabled so review and enable them as needed.
      #
      # Do not accept ICMP redirects (prevent MITM attacks)
      #net.ipv4.conf.all.accept_redirects = 0
      #net.ipv6.conf.all.accept_redirects = 0
      # _or_
      # Accept ICMP redirects only for gateways listed in our default
      # gateway list (enabled by default)
      # net.ipv4.conf.all.secure_redirects = 1
      #
      # Do not send ICMP redirects (we are not a router)
      #net.ipv4.conf.all.send_redirects = 0
      #
      # Do not accept IP source route packets (we are not a router)
      #net.ipv4.conf.all.accept_source_route = 0
      #net.ipv6.conf.all.accept_source_route = 0
      #
      # Log Martian Packets
      #net.ipv4.conf.all.log_martians = 1
      #">>/etc/sysctl.conf
      sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
      sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
      sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
      sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
      sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
      cat /dev/null > /etc/rc.local
      echo "#!/bin/sh -e
      #
      # rc.local
      #
      # This script is executed at the end of each multiuser runlevel.
      # Make sure that the script will "exit 0" on success or any other
      # value on error.
      #
      # In order to enable or disable this script just change the execution
      # bits.
      #
      # By default this script does nothing.

      # Print the IP address
      _IP=$(hostname -I) || true
      if [ "$_IP" ]; then
        printf "My IP address is %s\n" "$_IP"
      fi
      iptables-restore < /etc/iptables.ipv4.nat
      exit 0">>/etc/rc.local
      sudo service hostapd start
      sudo service dnsmasq start
      echo "access point listo"
      sudo reboot
      ;;
    "opcion2 desinstalar access point." )
    echo "elegiste la opcion 2"
    #!/bin/bash
    #desinstalar access point
    clear
    sudo apt-get remove hostapd
    sudo apt-get remove dnsmasq
    cat /dev/null > /etc/dhcpcd.conf
    echo"# A sample configuration for dhcpcd.
    # See dhcpcd.conf(5) for details.

    # Allow users of this group to interact with dhcpcd via the control socket.
    #controlgroup wheel

    # Inform the DHCP server of our hostname for DDNS.
    hostname

    # Use the hardware address of the interface for the Client ID.
    clientid
    # or
    # Use the same DUID + IAID as set in DHCPv6 for DHCPv4 ClientID as per RFC4361.
    #duid

    # Persist interface configuration when dhcpcd exits.
    persistent

    # Rapid commit support.
    # Safe to enable by default because it requires the equivalent option set
    # on the server to actually work.
    option rapid_commit

    # A list of options to request from the DHCP server.
    option domain_name_servers, domain_name, domain_search, host_name
    option classless_static_routes
    # Most distributions have NTP support.
    option ntp_servers
    # Respect the network MTU.
    # Some interface drivers reset when changing the MTU so disabled by default.
    #option interface_mtu

    # A ServerID is required by RFC2131.
    require dhcp_server_identifier

    # Generate Stable Private IPv6 Addresses instead of hardware based ones
    slaac private

    # A hook script is provided to lookup the hostname if not set by the DHCP
    # server, but it should not be run by default.
    nohook lookup-hostname">>/etc/dhcpcd.conf
    cat /dev/null > /etc/network/interfaces
    echo "# interfaces(5) file used by ifup(8) and ifdown(8)

    # Please note that this file is written to be used with dhcpcd
    # For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf'

    # Include files from /etc/network/interfaces.d:
    source-directory /etc/network/interfaces.d

    auto lo
    iface lo inet loopback

    iface eth0 inet manual

    allow-hotplug wlan0
    iface wlan0 inet manual
        wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

    allow-hotplug wlan1
    iface wlan1 inet manual
        wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf">>/etc/network/interfaces
    sudo service dhcpcd restart
    sudo ifdown wlan0
    sudo ifup wlan0
    cat /dev/null > /etc/hostapd/hostapd.conf
    cat /dev/null > /etc/default/hostapd
    echo '# Defaults for hostapd initscript
    #
    # See /usr/share/doc/hostapd/README.Debian for information about alternative
    # methods of managing hostapd.
    #
    # Uncomment and set DAEMON_CONF to the absolute path of a hostapd configuration
    # file and hostapd will be started during system boot. An example configuration
    # file can be found at /usr/share/doc/hostapd/examples/hostapd.conf.gz
    #
    #DAEMON_CONF=""

    # Additional daemon options to be appended to hostapd command:-
    # 	-d   show more debug messages (-dd for even more)
    # 	-K   include key data in debug messages
    # 	-t   include timestamps in some debug messages
    #
    # Note that -B (daemon mode) and -P (pidfile) options are automatically
    # configured by the init.d script and must not be added to DAEMON_OPTS.
    #
    #DAEMON_OPTS=""" '>>/etc/default/hostapd
    sudo rm /etc/dnsmasq.conf
    sudo mv /etc/dnsmasq.conf.orig /etc/dnsmasq.conf
    cat /dev/null > /etc/sysctl.conf
    echo "#
    # /etc/sysctl.conf - Configuration file for setting system variables
    # See /etc/sysctl.d/ for additional system variables.
    # See sysctl.conf (5) for information.
    #

    #kernel.domainname = example.com

    # Uncomment the following to stop low-level messages on console
    #kernel.printk = 3 4 1 3

    ##############################################################3
    # Functions previously found in netbase
    #

    # Uncomment the next two lines to enable Spoof protection (reverse-path filter)
    # Turn on Source Address Verification in all interfaces to
    # prevent some spoofing attacks
    #net.ipv4.conf.default.rp_filter=1
    #net.ipv4.conf.all.rp_filter=1

    # Uncomment the next line to enable TCP/IP SYN cookies
    # See http://lwn.net/Articles/277146/
    # Note: This may impact IPv6 TCP sessions too
    #net.ipv4.tcp_syncookies=1

    # Uncomment the next line to enable packet forwarding for IPv4
    #net.ipv4.ip_forward=1

    # Uncomment the next line to enable packet forwarding for IPv6
    #  Enabling this option disables Stateless Address Autoconfiguration
    #  based on Router Advertisements for this host
    #net.ipv6.conf.all.forwarding=1


    ###################################################################
    # Additional settings - these settings can improve the network
    # security of the host and prevent against some network attacks
    # including spoofing attacks and man in the middle attacks through
    # redirection. Some network environments, however, require that these
    # settings are disabled so review and enable them as needed.
    #
    # Do not accept ICMP redirects (prevent MITM attacks)
    #net.ipv4.conf.all.accept_redirects = 0
    #net.ipv6.conf.all.accept_redirects = 0
    # _or_
    # Accept ICMP redirects only for gateways listed in our default
    # gateway list (enabled by default)
    # net.ipv4.conf.all.secure_redirects = 1
    #
    # Do not send ICMP redirects (we are not a router)
    #net.ipv4.conf.all.send_redirects = 0
    #
    # Do not accept IP source route packets (we are not a router)
    #net.ipv4.conf.all.accept_source_route = 0
    #net.ipv6.conf.all.accept_source_route = 0
    #
    # Log Martian Packets
    #net.ipv4.conf.all.log_martians = 1
    #">>/etc/sysctl.conf
    sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
    sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
    sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
    cat /dev/null > /etc/rc.local
    echo "#!/bin/sh -e
    #
    # rc.local
    #
    # This script is executed at the end of each multiuser runlevel.
    # Make sure that the script will "exit 0" on success or any other
    # value on error.
    #
    # In order to enable or disable this script just change the execution
    # bits.
    #
    # By default this script does nothing.

    # Print the IP address
    _IP=$(hostname -I) || true
    if [ "$_IP" ]; then
      printf "My IP address is %s\n" "$_IP"
    fi
    exit 0">>/etc/rc.local
    sudo reboot
    ;;
    "opcion 3 acerca de." )
    echo "elegiste la opcion 3"
    echo "Copyright (C) 2017  pez

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>"
  echo "puedes invitarme un cafe aqui:"
  echo "paypal: https://www.paypal.me/PezNuss"
    ;;
    "opcion 4 salir." )
    echo "elegiste la opcion 4"
    break
    ;;
    *) echo opcion invalida;;
  esac
done
