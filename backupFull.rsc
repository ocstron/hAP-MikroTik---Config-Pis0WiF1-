# apr/14/2021 23:22:29 by RouterOS 6.48
# software id = V01Z-BWZ6
#
# model = RB941-2nD
# serial number = A1C30AD58222
/interface bridge
add admin-mac=74:4D:28:0B:1A:CB arp=reply-only auto-mac=no comment=defconf \
    name=bridge
/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN
/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk eap-methods="" mode=\
    dynamic-keys supplicant-identity=MikroTik wpa2-pre-shared-key=password
add authentication-types=wpa2-psk eap-methods="" management-protection=\
    allowed mode=dynamic-keys name=pongking supplicant-identity="" \
    wpa-pre-shared-key=password wpa2-pre-shared-key=password
add authentication-types=wpa2-psk eap-methods="" management-protection=\
    allowed mode=dynamic-keys name=ipCAM-06 supplicant-identity="" \
    wpa-pre-shared-key=password wpa2-pre-shared-key=password
add authentication-types=wpa2-psk eap-methods="" management-protection=\
    allowed mode=dynamic-keys name=guest supplicant-identity="" \
    wpa2-pre-shared-key=password
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-onlyn channel-width=20/40mhz-XX \
    country=philippines disabled=no distance=indoors frequency=auto \
    installation=indoor mode=ap-bridge security-profile=ipCAM-06 ssid=\
    ipCAM-06 wireless-protocol=802.11 wmm-support=enabled wps-mode=disabled
add disabled=no keepalive-frames=disabled mac-address=76:4D:28:0B:1A:D0 \
    master-interface=wlan1 multicast-buffering=disabled name=wlan2 \
    security-profile=pongking ssid=Pongking wds-cost-range=0 \
    wds-default-cost=0 wmm-support=enabled wps-mode=disabled
add keepalive-frames=disabled mac-address=76:4D:28:0B:1A:D1 master-interface=\
    wlan1 multicast-buffering=disabled name=wlan3 security-profile=guest \
    ssid=guest wds-cost-range=0 wds-default-cost=0 wmm-support=enabled \
    wps-mode=disabled
/ip pool
add name=default-dhcp ranges=192.168.88.64/26
/queue simple
add comment=<Total> max-limit=5M/10M name=LAN target=192.168.88.0/24
add comment=<Home> max-limit=5M/10M name=LAN1 parent=LAN target=\
    192.168.88.0/26
add comment=<Guest> max-limit=1M/3M name=LAN2 parent=LAN target=\
    192.168.88.64/26
add comment=admin max-limit=5M/5M name=admin parent=LAN1 target=\
    192.168.88.10/32
add comment=lgG7 max-limit=2M/5M name=lgG7 parent=LAN1 target=\
    192.168.88.11/32
add comment=y6Pro max-limit=1M/1M name=y6Pro parent=LAN1 target=\
    192.168.88.14/32
add comment=y6Pro2 max-limit=1M/2M name=y6Pro2 parent=LAN1 target=\
    192.168.88.15/32
add comment=vivo max-limit=1M/1M name=vivo parent=LAN1 target=\
    192.168.88.16/32
add comment=7i-Mam max-limit=1M/5M name=7i-Mam parent=LAN1 target=\
    192.168.88.17/32
add comment=6i-Sir max-limit=1M/5M name=6i-Sir parent=LAN1 target=\
    192.168.88.18/32
add comment=hisenseTV max-limit=128k/2M name=hisenseTV parent=LAN1 target=\
    192.168.88.19/32
add comment=homePC max-limit=256k/2M name=homePC parent=LAN1 target=\
    192.168.88.20/32
/ip dhcp-server
add add-arp=yes address-pool=default-dhcp disabled=no insert-queue-before=\
    bottom interface=bridge lease-script=":local queueName \"<client-\$leaseAc\
    tMAC>\";\r\
    \n:if ((\$leaseBound=1) && (\$leaseActIP>=\"192.168.88.77\")) do {\r\
    \n    /queue simple add name=\$queueName target=(\$leaseActIP . \"/32\") p\
    arent=LAN2 max-limit=128k/1M comment=[/ip dhcp-server lease get [find wher\
    e active-mac-address=\$leaseActMAC && active-address=\$leaseActIP] host-na\
    me];\r\
    \n}\r\
    \n:if ((\$leaseBound=1) && (\$leaseActIP>=\"192.168.88.64\")) do {\r\
    \n    /queue simple add name=\$queueName target=(\$leaseActIP . \"/32\") p\
    arent=LAN2 max-limit=256k/2M comment=[/ip dhcp-server lease get [find wher\
    e active-mac-address=\$leaseActMAC && active-address=\$leaseActIP] comment\
    ];\r\
    \n}\r\
    \n:if ((\$leaseBound=1) && (\$leaseActIP>=\"192.168.88.50\")) do {\r\
    \n    /queue simple add name=\$queueName target=(\$leaseActIP . \"/32\") p\
    arent=LAN1 max-limit=512k/3M comment=[/ip dhcp-server lease get [find wher\
    e active-mac-address=\$leaseActMAC && active-address=\$leaseActIP] comment\
    ];\r\
    \n}\r\
    \n:if ((\$leaseBound=1) && (\$leaseActIP>=\"192.168.88.32\")) do {\r\
    \n    /queue simple add name=\$queueName target=(\$leaseActIP . \"/32\") p\
    arent=LAN1 max-limit=1M/5M comment=[/ip dhcp-server lease get [find where \
    active-mac-address=\$leaseActMAC && active-address=\$leaseActIP] comment];\
    \r\
    \n}\r\
    \n:if ((\$leaseBound=0) && (\$leaseActIP>=\"192.168.88.32\")) do {\r\
    \n    /queue simple remove \$queueName\r\
    \n}" lease-time=1h name=defconf parent-queue=LAN
/queue tree
add bucket-size=0.05 max-limit=10M name="Total Downloads" parent=bridge
add bucket-size=0.025 max-limit=5M name="Total Uploads" parent=ether1
add bucket-size=0.025 max-limit=3M name=Other-Up parent="Total Uploads"
add bucket-size=0.05 max-limit=8M name=Other parent="Total Downloads"
/queue type
add kind=pcq name=PCQ2M pcq-classifier=dst-address pcq-limit=25KiB pcq-rate=\
    2M pcq-total-limit=1000KiB
add kind=pcq name=PCQ pcq-classifier=dst-address pcq-limit=25KiB \
    pcq-total-limit=1000KiB
add kind=pcq name=PCQUp3M pcq-classifier=src-address pcq-limit=15KiB \
    pcq-rate=3M pcq-total-limit=500KiB
add kind=pcq name=PCQ1M pcq-classifier=dst-address pcq-limit=25KiB pcq-rate=\
    1M pcq-total-limit=1000KiB
add kind=pcq name=PCQ5M pcq-classifier=dst-address pcq-limit=25KiB pcq-rate=\
    5M pcq-total-limit=1000KiB
add kind=pcq name=PCQup1M pcq-classifier=src-address pcq-limit=15KiB \
    pcq-rate=1M pcq-total-limit=500KiB
/queue tree
add bucket-size=0.05 name=Youtube packet-mark=yt parent=Other queue=PCQ2M
add bucket-size=0.05 name=Downloads packet-mark=down parent=Other queue=PCQ5M
add bucket-size=0.05 name=Games packet-mark=games parent="Total Downloads" \
    queue=PCQ1M
add bucket-size=0.025 name=Games-Up packet-mark=games-up parent=\
    "Total Uploads" queue=PCQup1M
add bucket-size=0.025 name=Uploads packet-mark=up parent=Other-Up queue=\
    PCQUp3M
add bucket-size=0.025 name=Youtube-Up packet-mark=yt-up parent=Other-Up \
    queue=PCQUp3M
/interface bridge port
add bridge=bridge comment=defconf interface=ether2
add bridge=bridge comment=defconf interface=ether3
add bridge=bridge comment=defconf interface=ether4
add bridge=bridge comment=defconf interface=pwr-line1
add bridge=bridge comment=defconf interface=wlan1
add bridge=bridge comment=defconf interface=wlan2
add bridge=bridge comment=defconf interface=wlan3
/ip neighbor discovery-settings
set discover-interface-list=LAN
/interface list member
add comment=defconf interface=bridge list=LAN
add comment=defconf interface=ether1 list=WAN
/ip address
add address=192.168.88.1/24 comment=defconf interface=bridge network=\
    192.168.88.0
/ip dhcp-client
add comment=defconf disabled=no interface=ether1
/ip dhcp-server network
add address=192.168.88.0/24 comment=defconf dns-server=8.8.8.8,8.8.4.4 \
    gateway=192.168.88.1
/ip dns static
add address=192.168.88.1 comment=defconf name=router.lan
/ip firewall filter
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=accept chain=input comment=\
    "defconf: accept to local loopback (for CAPsMAN)" dst-address=127.0.0.1
add action=drop chain=input comment="defconf: drop all not coming from LAN" \
    in-interface-list=!LAN
add action=accept chain=forward comment="defconf: accept in ipsec policy" \
    ipsec-policy=in,ipsec
add action=accept chain=forward comment="defconf: accept out ipsec policy" \
    ipsec-policy=out,ipsec
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" \
    connection-state=established,related disabled=yes
add action=accept chain=forward comment=\
    "defconf: accept established,related, untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=forward comment=\
    "defconf: drop all from WAN not DSTNATed" connection-nat-state=!dstnat \
    connection-state=new in-interface-list=WAN
/ip firewall mangle
add action=mark-connection chain=postrouting comment=down \
    new-connection-mark=down out-interface=bridge passthrough=yes protocol=\
    tcp src-port=80,443
add action=mark-packet chain=postrouting connection-mark=down \
    new-packet-mark=down out-interface=bridge passthrough=no
add action=mark-connection chain=postrouting comment=yt new-connection-mark=\
    yt out-interface=bridge passthrough=yes protocol=udp src-port=443
add action=mark-packet chain=postrouting connection-mark=yt new-packet-mark=\
    yt out-interface=bridge passthrough=no
add action=mark-connection chain=postrouting comment=games \
    new-connection-mark=games out-interface=bridge passthrough=yes
add action=mark-packet chain=postrouting connection-mark=games \
    new-packet-mark=games out-interface=bridge passthrough=no
add action=mark-connection chain=postrouting comment=up dst-port=80,443 \
    new-connection-mark=up out-interface=ether1 passthrough=yes protocol=tcp
add action=mark-packet chain=postrouting connection-mark=up new-packet-mark=\
    up out-interface=ether1 passthrough=no
add action=mark-connection chain=postrouting comment=yt-up dst-port=443 \
    new-connection-mark=yt-up out-interface=ether1 passthrough=yes protocol=\
    udp
add action=mark-packet chain=postrouting connection-mark=yt-up \
    new-packet-mark=yt-up out-interface=ether1 passthrough=no
add action=mark-connection chain=postrouting comment=games-up \
    new-connection-mark=games-up out-interface=ether1 passthrough=yes
add action=mark-packet chain=postrouting connection-mark=games-up \
    new-packet-mark=games-up out-interface=ether1 passthrough=no
/ip firewall nat
add action=masquerade chain=srcnat comment="defconf: masquerade" \
    ipsec-policy=out,none out-interface-list=WAN
/ip service
set telnet disabled=yes
set ftp disabled=yes
set ssh disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/system clock
set time-zone-name=Asia/Manila
/system logging
set 0 disabled=yes
set 1 disabled=yes
set 2 disabled=yes
set 3 disabled=yes
/system scheduler
add interval=1d name=reboot on-event="system reboot" policy=reboot \
    start-date=feb/13/2021 start-time=00:00:00
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
