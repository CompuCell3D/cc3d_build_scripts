cmake_minimum_required(VERSION 3.23)
project(min_example_auto)
##APPLE CHECK
IF (APPLE)
    # note: added -Wno-implicit-function-declaration -Wno-implicit-int to handle implicit function declarations in flex/bison generated code
    # this is stop gap measure and we need to either fix Units module or remove it since it is not used almost at all
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}  -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64 -Wno-implicit-function-declaration -Wno-implicit-int" CACHE STRING "flags used during compilation by C++ compiler" FORCE)
    SET(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS} -mmacosx-version-min=10.6 -O3 -g -fpermissive -m64 -Wno-implicit-function-declaration -Wno-implicit-int" CACHE STRING "flags used during compilation by C compiler" FORCE)
    SET(CMAKE_OSX_DEPLOYMENT_TARGET "10.9" CACHE STRING "OSX deployment target" FORCE)

    MESSAGE ("GOT APPLE")
ENDIF (APPLE)

set(CMAKE_CXX_STANDARD 11)


#FIND_PACKAGE(OpenMP REQUIRED)
#IF(OPENMP_FOUND)
#    message ("openmp c flags " "${OpenMP_C_FLAGS}")
#    message ("openmp cxx flags " "${OpenMP_CXX_FLAGS}")
#    SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS} ")
#    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
#    IF((APPLE) AND (CMAKE_CXX_COMPILER_ID STREQUAL "Clang"))
#        SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++")
#    ENDIF()
#ENDIF()






#set(CMAKE_CXX_STANDARD 14)

add_executable(min_example_auto main.cpp)

add_subdirectory(lib)