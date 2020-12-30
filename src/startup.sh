#! /bin/bash -f
# Written by Furey.
# With additions from Tony.
# With changes from Kahn.

# Set the port number.
port=4000
if [ "$1" != "" ]; then
    port="$1"
fi

# Change to area directory.
cd ../area

# Set limits.
# nohup
# limit stack 1024k
if [ -f SHUTDOWN.TXT ]; then
    rm -f SHUTDOWN.TXT
fi

while true; do
    # If you want to have logs in a different directory,
    #   change the 'set logfile' line to reflect the directory name.
    index=1000
    while true; do
        logfile=../log/$index.log
        if [ ! -f $logfile ]; then
            break
        fi
	    index=$index+1
    done

    # Update to new code if possible.
    if [ -e ../src/envy.new ]; then
	   mv ../src/envy2 ../src/envy.old
	   mv ../src/envy.new ../src/envy2
    fi

    # Run envy.
    # Check if already running
    matches=$(netstat -a | grep ":$port " | grep -c LISTEN)
    if (( $matches >= 1 )); then
        # Already running
        echo MUD Already running.
        exit 0
    fi
    ../src/envy $port >&! $logfile

    if [ -f core ]; then
	   mv core ../src/
    fi

    # Restart, giving old connections a chance to die.
    if [ -f SHUTDOWN.TXT ]; then
	   rm -f SHUTDOWN.TXT
	   #exit 0
    fi

    sleep 5
done
