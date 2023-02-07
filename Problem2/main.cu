#include <iostream>
#include <cuda_runtime.h>

using namespace std;

#define phi 1.61803398

// I do not think this solution can be done more efficiently on the GPU
int main() {

    // Calculate golden ratio to the power of three
    double phi3 = pow(phi, 3);

    int accumulator = 0;
    // every third number in the sequence is even.
    // we calculate the new sequence number and set it as the index (rounding to the nearest whole number)
    for (int i = 2; i < 4000000; i = round(i * phi3)) {
        accumulator += i;
    }

    cout << "Sum of all even Fibonacci values under 4 million = " << accumulator << endl;
}
