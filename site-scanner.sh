#!/bin/bash

#this is supposed to be a timer but it is not currently working
start=$SECONDS

#presentation spacing and color variables
THT='                              '
TEN='          '
TAB='     '
TRE='   '
SP=' '
RED='\033[1;31m'
CYN='\033[1;36m'
NC='\033[0m' # No Color

#Clear screen for splash page
clear


#Splash user interface page
echo
echo -e "${THT}"${RED}777777777777777
echo "${THT}""${SP}"7777777777777
echo "${THT}""${TEN}"777
echo "${THT}""${TAB}""${TRE}""${SP}"777
echo "${THT}""${TAB}""${TRE}"777
echo "${THT}""${TAB}""${SP}""${SP}"777
echo -e "${THT}""${TAB}""${SP}"777
echo -e "${THT}""${TAB}""${SP}"77${NC}
echo -e "${TEN}""${TAB}""${SP}""${CYN}Welcome to the Team"${NC} ${RED}7${NC} ${CYN}Web Vulnerability Scanner
echo
echo
echo "${THT}" "Team 7 Members:"
echo "${TEN}""${TEN}""${SP}""${SP}"Michael O\'Hagan"${TAB}"Agustin Grube
echo
echo
echo "${TEN}""${TRE}"This is a combination website vulnerability scanner.
echo
echo
echo -e "${TEN}""${TRE}"${RED}"*Be patient, some portions of the scan take a while!"${CYN}
echo
echo
echo
echo
echo
echo "${TEN}""${TAB}""${TRE}""${SP}"Please enter the IP Address of the target:
echo "${TEN}""${TAB}""${SP}""${SP}"\(In the following example format: 123.45.67.8\)

# create a prompt and an editable bash variable from the IP address
echo
read -e -p "IP:${SP}" URL


#Remove old files to avoid file naming conflicts
rm -vf dirb7.txt
rm -vf dirb7temp.txt
rm -vf nmap7.txt
rm -vf nikto7.txt
rm -vf nikto7temp.txt
rm -vf whatweb7.txt
rm -vf team7scan.txt
rm -vf $URL.txt


# run each script

#whatweb tool
echo -e ${RED}"now running step #1 WhatWeb Tool Scan"${CYN}
whatweb -v -a 3 "$URL" --log-verbose=whatweb7.txt


#dirb tool
echo -e ${RED}"now running step #2 Dir Buster Scan"${CYN}
dirb http://"$URL" -w -f -N 404 -o dirb7.txt


#nikto tool
echo -e ${RED}"now running step #3 Nikto Scan"${CYN}
nikto -h "$URL" -Display 3 -output nikto7.txt


#nmap tool
echo -e ${RED}"nowrunning step #4 Nmap Scan"${CYN}
nmap -n -v -A -T4 -p- "$URL" -o nmap7.txt


echo -e ${NC}

#Scan complete message
echo -e ${RED}"SCAN COMPLETE!"

echo
echo


#Editing individual reports.

#Dir Buster results processing
echo -e "Processing Report"${CYN}
tail -n +19 dirb7.txt | grep -v CODE:303 | grep -v CODE:403 | grep -v CODE:500 | grep -v 'Use mode' | grep -v 'WARNING' |grep -v OPTION: > dirb7temp.txt
sed -i 's|+ http://192.168.77.129||g' dirb7temp.txt
sed -i 's|==> DIRECTORY: http://192.168.77.129||g' dirb7temp.txt
sed -i 's|[(].*||g' dirb7temp.txt
sed -i 's|---- Entering directory: http://192.168.77.129||g' dirb7temp.txt

#Nikto results processing
tail -n +3 nikto7.txt > nikto7temp.txt


#Consolidating logs into final report
touch $URL.txt
cat nmap7.txt >> $URL.txt
cat dirb7temp.txt >> $URL.txt
cat whatweb7.txt >> $URL.txt
cat nikto7temp.txt >> $URL.txt


#File clean up
rm -vf dirb7.txt
rm -vf dirb7temp.txt
rm -vf nmap7.txt
rm -vf nikto7.txt
rm -vf nikto7temp.txt
rm -vf whatweb7.txt

#Completion message and final report name
echo -e ${RED}"All processing is done."
echo "Report Completed!"
echo -e "Filename: $URL.txt"${NC}
#Completion timer message but not currently working
duration=$(( SECONDS - start ))





# Need more tools.

