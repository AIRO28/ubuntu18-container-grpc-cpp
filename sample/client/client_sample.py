import sys

import grpc

import sample_pb2
import sample_pb2_grpc

def run(x1, x2):
    with grpc.insecure_channel("localhost:55555") as channel:
        # Initialize an instance of the SampleStub class.
        stub = sample_pb2_grpc.SampleStub(channel)

        # Request processing from the server side.
        responce = stub.Calc_add(sample_pb2.CalcNumber(x1=x1, x2=x2))
        print("Add Result: {}".format(responce),end="")
        responce = stub.Calc_sub(sample_pb2.CalcNumber(x1=x1, x2=x2))
        print("Sub Result: {}".format(responce),end="")
        responce = stub.Calc_mul(sample_pb2.CalcNumber(x1=x1, x2=x2))
        print("Mul Result: {}".format(responce),end="")
        responce = stub.Calc_div(sample_pb2.CalcNumber(x1=x1, x2=x2))
        print("Div Result: {}".format(responce))

def main():
    run(int(sys.argv[1]), int(sys.argv[2]))

# main function
if __name__ == "__main__":
    main()