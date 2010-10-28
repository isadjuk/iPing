#!/bin/bash
# ================================================================================================
#      iPing.sh 1.0
#      
#      Copyright 2010 iSadjuk <isadjuk@gmail.com>
#      
#      This program is free software; you can redistribute it and/or modify
#      it under the terms of the GNU General Public License as published by
#      the Free Software Foundation; either version 2 of the License, or
#      (at your option) any later version.
#      
#      This program is distributed in the hope that it will be useful,
#      but WITHOUT ANY WARRANTY; without even the implied warranty of
#      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#      GNU General Public License for more details.
#      
#      You should have received a copy of the GNU General Public License
#      along with this program; if not, write to the Free Software
#      Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#      MA 02110-1301, USA.
# ================================================================================================

# VARIABLES
IP="192.168.1.";
IP_START=2;
IP_END=10;

# ================================================================================================
# MAIN PROGRAM
echo -e "\n========================================================================"
echo -e "MAC ADDRESS \t\t IP ADDRESS \t NETBIOS NAME";
x=$IP_START;
while [ $x -le $IP_END ]; 
	do
	IP_CURRENT="${IP}${x}";
	ping -c 1 -W 1 $IP_CURRENT > /dev/null
	
	# IF ping received OK
	if [ "$?" = "0" ]; then
		IP_NAME="`nmblookup -A $IP_CURRENT | grep '<00> - ' | cut -f2 | awk -F' ' '{print $1}' | head -n 1`";
		IP_MAC="`arp -a $IP_CURRENT | awk -F' ' '{print $4}'`";
		
		# checking corrected name
		if [ "$IP_NAME" = "" ]; then
			IP_NAME="\t";
			fi

		# checking corrected mac address	
		if [ "$IP_MAC" = "entries" ]; then
			IP_MAC="==:==:==:==:==:==";
			fi
			
		echo -e "$IP_MAC \t $IP_CURRENT \t $IP_NAME";
		fi
		
	x=$[x + 1]
	done
echo -e "========================================================================\n"
# ================================================================================================
