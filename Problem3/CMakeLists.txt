cmake_minimum_required(VERSION 3.22)
project(Problem3 CUDA)

set(CMAKE_CUDA_STANDARD 20)
set(CMAKE_CUDA_FLAGS ${CMAKE_CUDA_FLAGS} "-g -G")  # enable cuda-gdb

add_executable(cuEulerProblem3 main.cu)

set_target_properties(
        cuEulerProblem3
        PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON
        COMPILE_OPTIONS -G)
