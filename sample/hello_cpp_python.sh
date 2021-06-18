#!/bin/bash +x

# Execute the sample program to Helloworld.
# --- Server side c++, Client side python ---
/grpc/examples/cpp/helloworld/cmake/build/greeter_server &
sleep 2
python3 /grpc/examples/python/helloworld/greeter_client.py

# Kill the server process you started.
ps aux | grep greeter_server | grep -v grep | awk '{ print "kill -9", $2 }' | sh