#include <iostream>
#include <cuda_runtime.h>

using namespace std;

#define N 10

__global__ void createSieve(int* x) {
    int tid = threadIdx.x;

    int start = 2;

sieve:
    if (x[tid] != 0 && x[tid] % start == 0) {
        x[tid] = 0;
    }
    cudaDeviceSynchronize();
    for (int i = 0; i < N; i ++) {
        if (x[i] > start && x[i] != 0) {
            start = x[i];
            goto sieve;
        }
    }
}

int main() {
    // allocate memory on the GPU
    int *device_a;
    cudaMalloc((void **) &device_a, N * sizeof(int));

    // run kernel
    createSieve<<<1, 10>>>(device_a);

    // Copy memory from GPU back to CPU and store it in host_a
    int host_a[N];
    cudaMemcpy(host_a, device_a, N * sizeof(int), cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();
    cudaFree(device_a);

    cout << host_a << endl;
}
