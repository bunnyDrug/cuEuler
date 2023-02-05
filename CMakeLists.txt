cmake_minimum_required(VERSION 3.22)
project(cuEuler CUDA)

set(CMAKE_CUDA_STANDARD 20)

add_executable(cuEuler main.cu)

set_target_properties(cuEuler PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
