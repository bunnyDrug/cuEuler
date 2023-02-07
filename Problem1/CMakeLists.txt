cmake_minimum_required(VERSION 3.22)
project(Problem1 CUDA)

set(CMAKE_CUDA_STANDARD 20)

add_executable(cuEulerProblem1 main.cu)

set_target_properties(cuEulerProblem1 PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
