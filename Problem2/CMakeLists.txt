cmake_minimum_required(VERSION 3.22)
project(Problem2 CUDA)

set(CMAKE_CUDA_STANDARD 20)

add_executable(cuEulerProblem2 main.cu)

set_target_properties(cuEulerProblem2 PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
