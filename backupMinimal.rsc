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
