#include <iostream>

#include <grpc++/grpc++.h>

#include "sample.grpc.pb.h"

using namespace std;

using grpc::Server;
using grpc::ServerBuilder;
using grpc::ServerContext;
using grpc::Status;

using sample::CalcNumber;
using sample::CalcResult;
using sample::Sample;

// SampleServiceImpl
class SampleServiceImpl final : public Sample::Service  {
    public:
    Status Calc_add(ServerContext* context, const CalcNumber* request, CalcResult* responce) {
        int32_t x1 = request->x1();
        int32_t x2 = request->x2();
        int32_t y = 0;

        y = x1 + x2;
        responce->set_y(y);
        return Status::OK;
    }

    Status Calc_sub(ServerContext* context, const CalcNumber* request, CalcResult* responce) {
        int32_t x1 = request->x1();
        int32_t x2 = request->x2();
        int32_t y = 0;

        y = x1 - x2;
        responce->set_y(y);
        return Status::OK;
    }

    Status Calc_mul(ServerContext* context, const CalcNumber* request, CalcResult* responce) {
        int32_t x1 = request->x1();
        int32_t x2 = request->x2();
        int32_t y = 0;

        y = x1 * x2;
        responce->set_y(y);
        return Status::OK;
    }

    Status Calc_div(ServerContext* context, const CalcNumber* request, CalcResult* responce) {
        int32_t x1 = request->x1();
        int32_t x2 = request->x2();
        int32_t y = 0;

        if(x2 == 0) {
            cout << "It cannot be divided by zero." << endl;
            y = 0;
            return Status::OK;
        }
        y = int32_t(x1 / x2);
        responce->set_y(y);
        return Status::OK;
    }
};


// RunServer function
void RunServer() {
    // Define the address of the server
    string server_address("0.0.0.0:55555");
    // Define the server object.
    SampleServiceImpl service;

    // Configure the port settings and register the service for the server.
    ServerBuilder builder;
    builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
    builder.RegisterService(&service);

    // Start the server
    unique_ptr<Server> server(builder.BuildAndStart());
    cout << "Server listening on " << server_address << endl;

    // Server-side standby processing.
    server->Wait();
}

// main function
int main(int args, char** argv) {
    // Server start processing call.
    RunServer();

    return 0;
}