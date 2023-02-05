#include <iostream>
#include <cuda_runtime.h>
#include <numeric>

using namespace std;

__global__
void gpuFactor(uint *x) {
    uint tid = threadIdx.x + blockIdx.x * blockDim.x;
    if (tid == 0) { return; }

    if (tid % 3 == 0 || tid % 5 == 0) {
        x[tid] = tid;
    }
}

int main() {

    int LIMIT = 1000;

    // allocate memory on the GPU
    uint *device_a;
    cudaMalloc((void **) &device_a, LIMIT * sizeof(int));

    // run kernel
    gpuFactor<<<5, 200>>>(device_a);

    // Copy memory from GPU back to CPU and store it in host_a
    int host_a[LIMIT];
    cudaMemcpy(host_a, device_a, LIMIT * sizeof(int), cudaMemcpyDeviceToHost);

    // Run accumulate sum on CPU
    // TODO parallel reduce on GPU.
    cout << accumulate(host_a, host_a + LIMIT, 0) << endl;

}
