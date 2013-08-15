#!/bin/bash
#made by Pranjal tiwari
#email id pranjaltiwariit@gmail.com,cristiano00717@gmail.com
#can use the code modify it and distribute to others freely,
#output generated file
output="network.$(date +'%d-%m-%y').info.txt"

#HWINF=/usr/sbin/hwinfo
IFCFG=/sbin/ifconfig
IP4FW=/sbin/iptables
IP6FW=/sbin/ip6tables
LSPCI=/usr/bin/lspci
ROUTE=/sbin/route
NETSTAT=/bin/netstat
LSB=/usr/bin/lsb_release
W=/usr/bin/w
FREE=/usr/bin/free
PS=/bin/ps
NMAP=/usr/bin/nmap
FDISK=/sbin/fdisk 
IWCONFIG=/sbin/iwconfig
DMIDECODE=/usr/sbin/dmidecode

HOSTS="/etc/hosts"
RESOLVE="/etc/resolve.conf"


#check whether root or not
check_root(){
	local meid=$(id -u)
	if [ $meid -ne 0 ];
	then
	echo "##########You must be root user to run this tool########"
		exit 1
	fi
}

touch network.$(date +'%d-%m-%y').info.txt

#directing the output
write_header(){
echo "-------------------------------------------------">>$output
echo "-------------------------------------------------">>$output
echo "$@" >> $output
echo "-------------------------------------------------">>$output
echo "-------------------------------------------------">>$output
}

network_system_dump_info(){
write_header "############################################# SYSTEM SCANING #############################################"
echo ">>>>>>>>>>>Hostname:$(hostname)">>$output
echo ">>>>>>>>>>>Run date and time: $(date)" >>$output

echo -n "Check the System Distro version [y:n] :"
read input
if [ $input == "y" -o $input == "Y" ];
then
write_header "Linux Distro"
echo "Linux kernal:$(uname -mrs)">>$output
$LSB -a >>$output
fi


echo -n "Check the BOIS info of your PC [y:n] :"
read input
if [ $input == "y" -o $input == "Y" ];
then
write_header "BIOS Configuration are directed to BIOS_info file"
$DMIDECODE  >>BIOS_info
fi

echo -n "See the current login users [y:n] :"
read input
if [ $input == "y" -o $input == "Y" ];
then
write_header "Current Login Users"
$W >>$output
fi

echo -n "Check the Network adaptors in use [y:n] :"
read input
if [ $input == "y" -o $input == "Y" ];
then
write_header "current Network Adaptors in use"
$IFCFG >>$output
fi

echo -n "Check the Kernel's Routing table [y:n] :"
read input
if [ $input == "y" -o $input == "Y" ];
then
write_header "Kernel Routing table"
$ROUTE >>$output
fi

echo -n "Check the System's memory [y:n] :"
read input
if [ $input == "y" -o $input == "Y" ];
then
write_header "System Memory in use"
$FREE >>$output
fi

echo -n "Check the Hard drives currently mounted on PC [y:n] :"
read input
if [ $input == "y" -o $input == "Y" ];
then
write_header "Mounted drives are "
$FDISK -l >>$output
fi

echo -n "Check the Nameserver [y:n] :"
read input
if [ $input == "y" -o $input == "Y" ];
then
write_header "Domain Name Server in use"
[ -f $HOSTS ] && cat $HOSTS >>$output || echo "error! hosts file do not exist"
fi


echo -n "Check The Wireless network interfaces [y:n] :"
read input
if [ $input == "y" -o $input == "Y" ];
then
write_header "Wireless interfaces are "
$IWCONFIG >>$output
fi

echo -n "check netstat [y:n] :"
read input
if [ $input == "y" -o $input == "Y" ];
then
write_header "Check status of tcp[process id/which program uses it] local-addr:port <connect> foreign-addr:port"
$NETSTAT --tcp --programs --numeric>>$output
fi

echo -n "You want to scan network like 192.168.1.* || 192.168.1.10-30 [y:n] :"
read input
write_header "############################################# NETWORK SCANING #############################################"
if [ $input == "y" -o $input == "Y" ];
then
echo -n "Network port scan and service running on it :"
read host1
write_header "Port Scan"
$NMAP  -sV $host1 >>$output
echo -n "Enter the network for OS Fingerprinting :"
read host2
write_header "OS Fingerprinting"
$NMAP -O -T insane $host2 >>$output
echo -n "Enter the network for stateful and state-less firewalls :"
read host3
write_header "Firewall Status"
$NMAP -sA $host3 >>$output
else
echo "You refuse to scan network"
fi

echo -n "You want to check the currently running processes [y:n] :"
read input
if [ $input == "y" -o $input == "Y" ];
then
write_header "Current Running Process >directed to processes_info file"
$PS -aux >>processes_info
fi

echo -n "You want to Check the h/w devices connected to your system [y:n] :"
read input
if [ $input == "y" -o $input == "Y" ];
then
write_header "PCI devices >directed to hardware_info file"
$LSPCI -v >>hardware_info
fi
}
check_root
network_system_dump_info













