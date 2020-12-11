#!/bin/bash

#Script initiation timer
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
echo "${TEN}""${SP}"Please enter the domain name or IP address of the target:
#echo "${TEN}""${TAB}""${SP}""${SP}"\(In the following example format: 123.45.67.8\)

# create a prompt and an editable bash variable from the IP address
echo
read -e -p "Address:${SP}" ANY
URL=$(fping -A -d $ANY | awk '{print $1}')
echo $URL

#Remove old files to avoid file naming conflicts
rm -vf dirb7.txt
rm -vf dirb7temp.txt
rm -vf nmap7.txt
rm -vf nikto7.txt
rm -vf nikto7temp.txt
rm -vf whatweb7.txt
rm -vf wpscan7.txt
rm -vf wpscan7temp.txt
rm -vf $URL.txt



#run each script

#whatweb tool
echo -e ${RED}"Now running step #1 WhatWeb Tool Scan"${CYN}
whatweb -v -a 3 "$URL" --log-verbose=whatweb7.txt
echo -e ${CYN}"Total time from start: $SECONDS" seconds
echo

#dirb tool
echo -e ${RED}"Now running step #2 Dir Buster Scan"${CYN}
dirb http://"$URL" -w -f -N 404 -o dirb7.txt
echo -e ${CYN}"Total time from start: $SECONDS" seconds
echo

#nikto tool
echo -e ${RED}"Now running step #3 Nikto Scan"${CYN}
nikto -h "$URL" -Display 3 -output nikto7.txt
echo -e ${CYN}"Total time from start: $SECONDS" seconds
echo

#nmap tool
echo -e ${RED}"Now running step #4 Nmap Scan"${CYN}
nmap -n -v -A -T4 -p- "$URL" -o nmap7.txt
echo -e ${CYN}"Total time from start: $SECONDS" seconds
echo

#wpscan tool
echo -e ${RED}"Now running step #5 WPScan"${CYN}
wpscan --url http://"$URL" -v --detection-mode aggressive --rua --ignore-main-redirect -o wpscan7.txt
echo -e ${CYN}"Total time from start: $SECONDS" seconds
echo

#Scan complete message
echo -e ${RED}"SCAN COMPLETE!"
echo

#Editing individual reports.

#Dir Buster results processing
echo -e "Processing Report"${CYN}
tail -n +19 dirb7.txt | grep -v CODE:303 | grep -v CODE:403 | grep -v CODE:500 | grep -v 'Use mode' | grep -v 'WARNING' |grep -v OPTION: > dirb7temp.txt
sed -i 's|+ http://'"$URL"'||g' dirb7temp.txt
sed -i 's|==> DIRECTORY: http://'"$URL"'||g' dirb7temp.txt
sed -i 's|[(].*||g' dirb7temp.txt
sed -i 's|---- Entering directory: http://'"$URL"'||g' dirb7temp.txt

#Nikto results processing
tail -n +3 nikto7.txt > nikto7temp.txt

#WPScan results processing
tail -n +14 wpscan7.txt > wpscan7temp.txt


#Consolidating logs into final report
touch $URL.txt
echo  >> $URL.txt
echo "Nmap Report *********************************" >> $URL.txt
echo  >> $URL.txt
echo  >> $URL.txt
cat nmap7.txt >> $URL.txt
echo  >> $URL.txt
echo  >> $URL.txt
echo  >> $URL.txt
echo "Dir Buster Report *********************************" >> $URL.txt
echo  >> $URL.txt
echo  >> $URL.txt
cat dirb7temp.txt >> $URL.txt
echo  >> $URL.txt
echo  >> $URL.txt
echo  >> $URL.txt
echo "WhatWeb Report *********************************" >> $URL.txt
echo  >> $URL.txt
echo  >> $URL.txt
cat whatweb7.txt >> $URL.txt
echo  >> $URL.txt
echo  >> $URL.txt
echo "Nikto Report *********************************" >> $URL.txt
echo  >> $URL.txt
echo  >> $URL.txt
cat nikto7temp.txt >> $URL.txt
echo  >> $URL.txt
echo  >> $URL.txt
echo  >> $URL.txt
echo "WPScan Report *********************************" >> $URL.txt
cat wpscan7temp.txt >> $URL.txt
echo  >> $URL.txt



echo "End of Report *********************************" >> $URL.txt

#additional formatting lines
echo

#File clean up
rm -vf dirb7.txt
rm -vf dirb7temp.txt
rm -vf nmap7.txt
rm -vf nikto7.txt
rm -vf nikto7temp.txt
rm -vf whatweb7.txt
rm -vf wpscan7.txt
rm -vf wpscan7temp.txt

#additional formatting lines
echo
echo

#Completion message and final report name
echo -e ${RED}"All processing is done."
echo "Report Completed!"
echo
echo -e "Filename: $URL.txt"${NC}
echo
#Completion timer message but not currently working
#duration=$(( SECONDS - start ))
#Duration timer
echo -e ${CYN}"Total run time: $SECONDS" seconds${NC} 
echo



# Need more tools.  2 more



