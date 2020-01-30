#!/bin/bash
rm /home/ubuntu/report-`date +%F`.doc
report=/home/ubuntu/report-`date +%F`.doc
# bersihkan layar
clear

unset os architecture kernelrelease internalip externalip nameserver loadaverage


# cek koneksi
ping -c 1 google.com &> /dev/null && echo -e "Internet: $tecreset Connected" >> $report || echo -e "Internet: Disconnected" >> $report

# cek tipe OS
os=$(uname -o)
echo -e "Operating System Type :" $os >> $report

# cek versi OS
cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' > /tmp/osrelease
echo -n -e "OS Name :" >> $report && cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\" >> $report
echo -n -e "OS Version :" >> $report && cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\" >> $report

# cek arsitektur
architecture=$(uname -m)
echo -e "Architecture :" $architecture >> $report

# cek kernel
kernelrelease=$(uname -r)
echo -e "Kernel Release :" $kernelrelease >> $report

# cek hostname
echo -e "Hostname :" $HOSTNAME >> $report

# Cek Internal IP
internalip=$(hostname -I) >> $report
echo -e "Internal IP :" $internalip >> $report

# cek DNS
nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}') >> $report
echo -e "Name Servers :" $nameservers >> $report

# cek login user
who>/tmp/who
echo -e "Logged In users :" >> $report && cat /tmp/who >> $report

# cek RAM dan SWAP Usages
free -h | grep -v + > /tmp/ramcache
echo -e "Ram Usages :" >> $report
cat /tmp/ramcache | grep -v "Swap" >> $report
echo -e "Swap Usages :" >> $report
cat /tmp/ramcache | grep -v "Mem" >> $report

# cek disk usages
#df -h| grep 'Filesystem\|/dev/sda*' > /tmp/diskusage
df -h > /tmp/diskusage
echo -e "Disk Usages :" >> $report
cat /tmp/diskusage >> $report

# cek load average
loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo -e "Load Average :" $loadaverage >> $report

# cek uptime
tecuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e "System Uptime Days/(HH:MM) :" $tecuptime >> $report

# Unset Variables
unset tecreset os architecture kernelrelease internalip externalip nameserver loadaverage

# hapus temporary files
rm /tmp/osrelease /tmp/who /tmp/ramcache /tmp/diskusage

cat=$(cat /home/ubuntu/report-`date +%F`.doc)
echo "$cat" | mailx -s "Report Server $(hostname)" faisal@paques.id mfaisal0411@gmail.com
