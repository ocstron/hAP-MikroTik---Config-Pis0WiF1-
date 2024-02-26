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
    dynamic-keys supplicant-identity=MikroTik wpa2-pre-shared-key=@12345!!
add authentication-types=wpa2-psk eap-methods="" management-protection=\
    allowed mode=dynamic-keys name=pongking supplicant-identity="" \
    wpa-pre-shared-key=arnel_g@buya wpa2-pre-shared-key=arnel_g@buya
add authentication-types=wpa2-psk eap-methods="" management-protection=\
    allowed mode=dynamic-keys name=ipCAM-06 supplicant-identity="" \
    wpa-pre-shared-key=idontknowwhy wpa2-pre-shared-key=idontknowwhy
add authentication-types=wpa2-psk eap-methods="" management-protection=\
    allowed mode=dynamic-keys name=guest supplicant-identity="" \
    wpa2-pre-shared-key=@12345!!
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
add comment=7i-SirEf max-limit=256k/2M name=<client-12:E5:1E:40:F1:48> \
    parent=LAN2 target=192.168.88.74/32
add comment=f7-Sir max-limit=1M/5M name=<client-44:66:FC:BF:22:F3> parent=\
    LAN1 target=192.168.88.44/32
add comment=asus-Beyot max-limit=512k/3M name=<client-2C:4D:54:90:AC:40> \
    parent=LAN1 target=192.168.88.53/32
add comment=android-8f8dbe1b7640f099 max-limit=128k/1M name=\
    <client-FC:6C:53:54:F9:C0> parent=LAN2 target=192.168.88.80/32
add comment=laptop3-Hp max-limit=1M/5M name=<client-54:13:79:78:1F:E9> \
    parent=LAN1 target=192.168.88.38/32
add comment=redmiS2.1 max-limit=256k/2M name=<client-0C:98:38:C1:47:0F> \
    parent=LAN2 target=192.168.88.68/32
add comment=realme-C3 max-limit=128k/1M name=<client-02:5C:65:CF:04:E6> \
    parent=LAN2 target=192.168.88.77/32
add comment=5i-Hariel max-limit=256k/2M name=<client-BC:2D:EF:F0:9D:09> \
    parent=LAN2 target=192.168.88.65/32
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
/ip dhcp-server lease
add address=192.168.88.20 comment=homePC mac-address=50:3E:AA:0D:5D:0B \
    server=defconf
add address=192.168.88.44 comment=f7-Sir mac-address=44:66:FC:BF:22:F3 \
    server=defconf
add address=192.168.88.16 comment=vivo mac-address=C4:AB:B2:A0:FC:A7 server=\
    defconf
add address=192.168.88.36 client-id=1:b0:10:41:f5:c1:b1 comment=laptop1 \
    mac-address=B0:10:41:F5:C1:B1 server=defconf
add address=192.168.88.37 client-id=1:60:f6:77:72:e:a2 comment=laptop2 \
    mac-address=60:F6:77:72:0E:A2 server=defconf
add address=192.168.88.10 client-id=1:b4:2e:99:e1:f1:b5 comment=admin \
    mac-address=B4:2E:99:E1:F1:B5 server=defconf
add address=192.168.88.15 client-id=1:ac:bd:70:2c:90:63 comment=y6pro2 \
    mac-address=AC:BD:70:2C:90:63 server=defconf
add address=192.168.88.14 client-id=1:ac:bd:70:9:a0:27 comment=y6pro \
    mac-address=AC:BD:70:09:A0:27 server=defconf
add address=192.168.88.43 comment=vivo1901 mac-address=18:E7:77:FA:8A:E3 \
    server=defconf
add address=192.168.88.38 client-id=1:54:13:79:78:1f:e9 comment=laptop3-Hp \
    mac-address=54:13:79:78:1F:E9 server=defconf
add address=192.168.88.32 client-id=1:c8:9:a8:ab:4a:91 comment=deped1 \
    mac-address=C8:09:A8:AB:4A:91 server=defconf
add address=192.168.88.69 client-id=1:0:ae:fa:51:c6:6d comment=s5-Beyot \
    mac-address=00:AE:FA:51:C6:6D server=defconf
add address=192.168.88.19 client-id=1:8c:9f:3b:42:18:b7 comment=hisenseTV \
    mac-address=8C:9F:3B:42:18:B7 server=defconf
add address=192.168.88.68 client-id=1:c:98:38:c1:47:f comment=redmiS2.1 \
    mac-address=0C:98:38:C1:47:0F server=defconf
add address=192.168.88.73 comment=oppo-Miyay mac-address=2C:5B:B8:3B:49:8A \
    server=defconf
add address=192.168.88.70 comment=tctmobile mac-address=94:D8:59:FA:BB:F2 \
    server=defconf
add address=192.168.88.67 client-id=1:20:47:da:46:cd:a3 comment=redmiS2 \
    mac-address=20:47:DA:46:CD:A3 server=defconf
add address=192.168.88.33 client-id=1:28:7f:cf:cb:98:f comment=deped2 \
    mac-address=28:7F:CF:CB:98:0F server=defconf
add address=192.168.88.53 client-id=1:2c:4d:54:90:ac:40 comment=asus-Beyot \
    mac-address=2C:4D:54:90:AC:40 server=defconf
add address=192.168.88.34 client-id=1:be:85:27:df:a0:b9 comment=deped3 \
    mac-address=BE:85:27:DF:A0:B9 server=defconf
add address=192.168.88.65 client-id=1:bc:2d:ef:f0:9d:9 comment=5i-Hariel \
    mac-address=BC:2D:EF:F0:9D:09 server=defconf
add address=192.168.88.40 client-id=1:b4:cb:57:58:10:63 mac-address=\
    B4:CB:57:58:10:63 server=defconf
add address=192.168.88.39 client-id=1:dc:37:14:d0:75:60 mac-address=\
    DC:37:14:D0:75:60 server=defconf
add address=192.168.88.35 client-id=1:60:f2:62:69:a8:6b comment=deped4 \
    mac-address=60:F2:62:69:A8:6B server=defconf
add address=192.168.88.18 client-id=1:1e:71:a3:dd:18:58 comment=6i-Sir \
    mac-address=1E:71:A3:DD:18:58 server=defconf
add address=192.168.88.17 client-id=1:76:ce:b9:8a:7c:1f comment=7i-Mam \
    mac-address=76:CE:B9:8A:7C:1F server=defconf
add address=192.168.88.45 client-id=1:60:f2:62:cb:d1:17 comment=deped5 \
    mac-address=60:F2:62:CB:D1:17 server=defconf
add address=192.168.88.71 client-id=1:e0:b9:4d:b6:f:4f comment=pc-SirEf \
    mac-address=E0:B9:4D:B6:0F:4F server=defconf
add address=192.168.88.11 client-id=1:48:60:5f:6c:e1:26 comment=g7 \
    mac-address=48:60:5F:6C:E1:26 server=defconf
add address=192.168.88.5 client-id=1:c:80:63:ea:a6:5c mac-address=\
    0C:80:63:EA:A6:5C server=defconf
add address=192.168.88.74 client-id=1:12:e5:1e:40:f1:48 comment=7i-SirEf \
    mac-address=12:E5:1E:40:F1:48 server=defconf
add address=192.168.88.72 client-id=1:a8:a7:95:ce:4a:75 comment=lapLenovo \
    mac-address=A8:A7:95:CE:4A:75 server=defconf
add address=192.168.88.66 client-id=1:58:c6:f0:52:8:a9 comment=a3s-Paem \
    mac-address=58:C6:F0:52:08:A9 server=defconf
add address=192.168.88.64 client-id=1:84:b8:b8:ab:4f:4b comment=tabLenovo \
    mac-address=84:B8:B8:AB:4F:4B server=defconf
add address=192.168.88.77 client-id=1:2:5c:65:cf:4:e6 comment=c3-Seb \
    mac-address=02:5C:65:CF:04:E6 server=defconf
add address=192.168.88.46 client-id=1:aa:d5:3:15:2b:91 comment=fatherB \
    mac-address=AA:D5:03:15:2B:91 server=defconf
add address=192.168.88.76 client-id=1:d0:7f:a0:b3:76:fd comment=manaSalbing \
    mac-address=D0:7F:A0:B3:76:FD server=defconf
add address=192.168.88.75 client-id=1:32:1b:d1:f7:bc:c8 comment=manaOndit \
    mac-address=32:1B:D1:F7:BC:C8 server=defconf
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
