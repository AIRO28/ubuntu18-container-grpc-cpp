#!/bin/bash +x

# Execute the sample program to Helloworld.
# --- Server side python, Client side c++ ---
python3 /grpc/examples/python/helloworld/greeter_server.py &
sleep 2
/grpc/examples/cpp/helloworld/cmake/build/greeter_client

# Kill the server process you started.
ps aux | grep greeter_server | grep -v grep | awk '{ print "kill -9", $2 }' | sh