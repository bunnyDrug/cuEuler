#include <iostream>
#include <cuda_runtime.h>
#include <math.h>


void printPrimes(double *host_a, double size);

using namespace std;

__global__ void createSieve(double *x, double N) {
    for (int tid = blockIdx.x * blockDim.x + threadIdx.x; tid < N; tid += blockDim.x * gridDim.x) {


        // we are not interested in the 0 and 1 as they are not prime
        if (tid == 1 || tid == 0) {
            continue;
        } else {

            // let's begin at 2
            double sieve = 2;

            x[tid] = tid;

            // Sieve all 2's
            if (x[tid] != 0 && fmod(x[tid], sieve) == 0 && x[tid] != sieve) {
                x[tid] = 0;
            }

            while (true) {
                if (tid > sieve && x[tid] != 0) {
                    sieve++;

                    if (x[tid] != 0 && fmod(x[tid], sieve) == 0 && x[tid] != sieve) {
                        x[tid] = 0;
                        break;
                    }
                } else {
                    break;
                }

            }
        }
    }
}

int main() {
    double limit = 600851475143;

    // allocate memory on the GPU
    double *device_a;
    cudaMalloc((void **) &device_a, limit * sizeof(double));

    // run kernel
    createSieve<<<1, 1>>>(device_a, limit);

    // Copy memory from GPU back to CPU and store it in host_a
    double *host_a;
    cudaMemcpy(host_a, device_a, limit * sizeof(double), cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();
    cudaFree(device_a);


    double halfwayPoint = sqrt(limit);

    cout << "sqrt was: " << halfwayPoint << endl;
    cout << "There can be at most one other prime factor greater than " << halfwayPoint << endl;

    bool neverFound = true;
    for (int i = ceil(halfwayPoint); i < limit; i++) {
        if (host_a[i] != 0 && fmod(limit, host_a[i]) == 0) {
            cout << "Highest Prime is " << i << endl;
            neverFound = false;
            break;
        }
    }
    if (neverFound) {
        for (int i = ceil(halfwayPoint); i < limit; i--) {
            if (host_a[i] != 0 && fmod(limit, host_a[i]) == 0) {
                cout << "Highest Prime is " << i << endl;
                break;
            }
        }
    }
}

