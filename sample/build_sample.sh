cd sample

# Create a gRPC definition file from protocolBuffer
protoc -I proto --cpp_out=./server ./proto/sample.proto
protoc -I proto --grpc_out=./server --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` ./proto/sample.proto
python3 -m grpc_tools.protoc -I proto --python_out=./client --grpc_python_out=./client ./proto/sample.proto

# Execute the compilation of the c++ source code.
rm -rf server/objects/
mkdir -p server/objects
g++ -std=c++11 `pkg-config --cflags protobuf grpc` -c -o ./server/objects/sample.pb.o ./server/sample.pb.cc
g++ -std=c++11 `pkg-config --cflags protobuf grpc` -c -o ./server/objects/sample.grpc.pb.o ./server/sample.grpc.pb.cc
g++ -std=c++11 `pkg-config --cflags protobuf grpc` -I ./server -c -o ./server/objects/server_sample.o ./server/server_sample.cpp

# Build the executable.
rm -rf server/bin/
mkdir -p server/bin
cd server/objects/
g++ sample.grpc.pb.o sample.pb.o server_sample.o -L/usr/local/lib `pkg-config --libs protobuf grpc++` -lgrpc++_reflection -ldl -o ../bin/server_sample