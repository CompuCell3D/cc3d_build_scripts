find_package(Python3 REQUIRED COMPONENTS Interpreter Development NumPy)


message("Python3_FOUND: ${Python3_FOUND}")
message("Python3_Interpreter_FOUND: ${Python3_Interpreter_FOUND}")
message("Python3_VERSION: ${Python3_VERSION}")
message("Python3_Development_FOUND: ${Python3_Development_FOUND}")
message("Python3_EXECUTABLE: ${Python3_EXECUTABLE}")

message("Python3_Development_FOUND: ${Python3_Development_FOUND}")
message("Python3_INCLUDE_DIRS: ${Python3_INCLUDE_DIRS}")
message("Python3_LIBRARIES: ${Python3_LIBRARIES}")
message("Python3_LIBRARY_RELEASE: ${Python3_LIBRARY_RELEASE}")
message("Python3_LIBRARY_DIRS: ${Python3_LIBRARY_DIRS}")
message("Python3_RUNTIME_LIBRARY_DIRS: ${Python3_RUNTIME_LIBRARY_DIRS}")
message("Python3_NumPy_INCLUDE_DIRS: ${Python3_NumPy_INCLUDE_DIRS}")

# SWIG bit.
find_package(SWIG REQUIRED)
include(${SWIG_USE_FILE})

set(PYTHON_DIRS_TO_INCLUDE
        ${Python3_INCLUDE_DIRS}
        ${Python3_NumPy_INCLUDE_DIRS}
        )

set(PYTHON_LIBRARY_TO_LINK ${Python3_LIBRARY_RELEASE})

SET(SRCS
        foo.cpp
        )

include_directories(foolib ${CMAKE_CURRENT_SOURCE_DIR})

if(APPLE)
    ADD_LIBRARY(foolib SHARED ${SRCS})
#    set_target_properties(foolib PROPERTIES LINK_FLAGS "-undefined dynamic_lookup")
else()
    ADD_LIBRARY(foolib SHARED ${SRCS})
endif()

install(TARGETS foolib
        EXPORT foolib
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib

        )

SET_SOURCE_FILES_PROPERTIES(example.i PROPERTIES CPLUSPLUS ON)
set_source_files_properties(example.i PROPERTIES SWIG_FLAGS "-includeall")

SWIG_ADD_LIBRARY(example LANGUAGE python SOURCES example.i)

set(undefined_link_flags "-undefined dynamic_lookup")

SET_TARGET_PROPERTIES(example PROPERTIES
        OUTPUT_NAME "example"
        LINK_FLAGS ${undefined_link_flags}
        SWIG_USE_TARGET_INCLUDE_DIRECTORIES TRUE
        )


#SWIG_LINK_LIBRARIES(example foolib ${PYTHON_LIBRARY_TO_LINK})
# do not link python lib here - you will end up with duplicated symbols that will cause segfault
SWIG_LINK_LIBRARIES(example foolib)

target_include_directories(example PUBLIC
        ${PYTHON_DIRS_TO_INCLUDE}
        ${CMAKE_CURRENT_SOURCE_DIR}
#        ${PYTHON_DIRS_TO_INCLUDE}
#        ${VTK_INCLUDE_DIRS}
#        $<TARGET_PROPERTY:FieldExtractor,INCLUDE_DIRECTORIES>
        )
#target_include_directories(example ${PYTHON3_INCLUDE_PATH} ${CMAKE_CURRENT_SOURCE_DIR})
target_link_directories(example PUBLIC ${Python3_LIBRARY_DIRS})

if (APPLE)

    # interesting reading: https://blog.kitware.com/upcoming-in-cmake-2-8-12-osx-rpath-support/

    # INSTALL_NAME_DIR overrides MACOSX_RPATH.  Try not to do that.

    # Use rpath for PlayerPythonNew.so
    SET_TARGET_PROPERTIES(example PROPERTIES MACOSX_RPATH TRUE)

    # append directories in the linker search path and outside the project to the INSTALL_RPATH
    SET_TARGET_PROPERTIES(example PROPERTIES CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)


    # this is where libraries on which PlayerPythonNew.so depends on are
    # installed relative to where PlayerPythonNew.py is installed
    SET_TARGET_PROPERTIES(example PROPERTIES INSTALL_RPATH "@loader_path/lib;@loader_path/../../../")


endif()


install(TARGETS example DESTINATION ${CMAKE_INSTALL_PREFIX})

#set(python_files_path ${CMAKE_INSTALL_PREFIX}/core/pyinterface/PlayerPythonNew)
#
#INSTALL(FILES ${python_files_path}/PlayerPython.py
#        DESTINATION ${COMPUCELL3D_INSTALL_SWIG_MODULES_DIR}
#        )
#



#include_directories(example ${PYTHON3_INCLUDE_PATH} ${CMAKE_CURRENT_SOURCE_DIR})
#
#
#
#
#
#
#set_property(SOURCE example.i PROPERTY CPLUSPLUS ON)
#swig_add_library(example TYPE SHARED LANGUAGE python SOURCES example.i foo.cpp)
#SWIG_LINK_LIBRARIES(example ${PYTHON3_LIBRARIES})