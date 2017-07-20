#!/bin/bash

help_message() {
  echo
  echo 'looks like you need some help using this tool.'
  echo
  echo 'usage:  "launchnodes.sh port1 port2 port3 port4 ..."'
  echo
  echo "For each port number, a k-node will be launched with a Sinatra webserver running on that port"
  echo "The process will be backgrounded, and the PID written to pids.txt"
  echo
  echo "You can quit the processes in bulk using kill_nodes.sh, which iterates through pids.txt,"
  echo "kills each process, then overwrites the file"
  echo
  echo "Alternatively you can locate each pid using" 
  echo "lsof -i \$port_number" 
  echo "and kill it manually:"
  echo "kill \$pid"
  echo "however this could result in inconsistencies with your pids.txt file."
  echo
}

launch_nodes() {
  for port in $@
  do
    launch_node $port
  done
}

launch_node() {
  nohup ruby app.rb -p $1 >> tmp/nohup.out &
  echo $! >> tmp/pids.txt
}

if [[ $# == 0 ]] || [[ $1 == '-h' ]]; then
  help_message
  exit 0
fi

launch_nodes $@