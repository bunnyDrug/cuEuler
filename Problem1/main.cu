#include <iostream>
#include <cuda_runtime.h>
#include <numeric>

using namespace std;

#define LIMIT 1000

__global__ void gpuFactor(int *x) {
    int tid = threadIdx.x + blockIdx.x * blockDim.x;

    if (tid == 0 || tid > LIMIT) { return; }

    if (tid % 3 == 0 || tid % 5 == 0) {
        x[tid] = tid;
    }
}

int main() {

    // allocate memory on the GPU
    int *device_a;
    cudaMalloc((void **) &device_a, LIMIT * sizeof(int));

    // run kernel
    gpuFactor<<<5, 256>>>(device_a);

    // Copy memory from GPU back to CPU and store it in host_a
    int host_a[LIMIT];
    cudaMemcpy(host_a, device_a, LIMIT * sizeof(int), cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();
    cudaFree(device_a);

    // Run accumulate sum on CPU
    cout << accumulate(host_a, host_a + LIMIT, 0) << endl;

    // TODO parallel reduce on GPU.
}
