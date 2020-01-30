#!/bin/bash
report=/home/ubuntu/report-`date +%F`
echo -e "**************************************************************************************************" >> $report
echo -e "******************************************* SYSTEM INFO ******************************************" >> $report
echo -e "**************************************************************************************************\n" >> $report
 
echo -e "\n\n========================================= HOST INFO ==========================================\n" >> $report
echo -e "\tHostname:\t"`hostname` >> $report
 
#echo -e "\n\n========================================== OS INFO ===========================================\n" >> $report
#echo -e "\tOS Info:\t"`cat /etc/system-release` >> $report
 
echo -e "\n\n======================================== KERNEL INFO =========================================\n" >> $report
echo -e "\tKernel Version:\t"`uname -r` >> $report
 
echo -e "\n\n========================================= CPU INFO ===========================================\n" >> $report
echo -e "\tTotal Processor:\t"`grep -c 'processor' /proc/cpuinfo` >> $report
echo -e "\tCPU Processor Model:\t"`awk -F':' '/^model name/ { print $2 }' /proc/cpuinfo` >> $report
echo -e "\tCPU Processor Speed:\t"`awk -F':' '/^cpu MHz/ { print $2 }' /proc/cpuinfo` >> $report
echo -e "\tCPU Cache Size:\t"`awk -F':' '/^cache size/ { print $2 }' /proc/cpuinfo`  >> $report
 
echo -e "\n\n========================================== RAM INFO ==========================================\n" >> $report
echo -e "\tMemory(RAM) Info:\t"`free -mht| awk '/Mem/{print " \tTotal: " $2 "\tUsed: " $3 "\tFree: " $4}'`  >> $report
echo -e "\tSwap Memory Info:\t"`free -mht| awk '/Swap/{print " \t\tTotal: " $2 "\tUsed: " $3 "\tFree: " $4}'` >> $report
 
echo -e "\n\n========================================== IP INFO ===========================================\n" >> $report
ifconfig >> $report
 
echo -e "\n\n====================================== ROUTE TABLE INFO ======================================\n" >> $report
route -n >> $report
 
echo -e "\n\n==================================== DISK PARTATION INFO =====================================\n" >> $report
df -h >> $report

echo -e "\n\n==================================== RUNNING SERVICE INFO ====================================\n" >> $report
systemctl list-units | grep running|sort >> $report
 
echo -e "\n\n==================================== TOTAL RUNNING SERVICE ===================================\n" >> $report
echo -e "\tTotal Running service:\t"`systemctl list-units | grep running|sort| wc -l` >> $report
 
echo -e "\n\n====================================== ACTIVE USER INFO ======================================\n" >> $report
echo -e "\tCurrent Active User:\t"`w | cut -d ' ' -f 1 | grep -v USER | sort -u` >> $report
