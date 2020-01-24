cmake_minimum_required(VERSION 3.13)

project(hello)
enable_language(Fortran)

if(FC MATCHES "pgf90")
    set(FFLAGS "-g -traceback -O -Mpreprocess -Mrecursive -Mallocatable=03 -acc=verystrict -ta=nvidia:cc60,cuda10.1 -Minfo=all -Mcuda")
    set(LDFLAGS "-ta=nvidia:cc60,cuda10.1 -Mcuda -Mnorpath")
endif()

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${FFLAGS}")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${LDFLAGS}")

file(GLOB_RECURSE sources  src/*.f90)
add_executable(prog ${sources})

