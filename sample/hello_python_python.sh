#!/bin/bash +x

# Execute the sample program to Helloworld.
# --- Server side python, Client side python ---
python3 /grpc/examples/python/helloworld/greeter_server.py &
sleep 2
python3 /grpc/examples/python/helloworld/greeter_client.py

# Kill the server process you started.
ps aux | grep greeter_server | grep -v grep | awk '{ print "kill -9", $2 }' | sh