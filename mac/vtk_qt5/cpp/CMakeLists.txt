cmake_minimum_required(VERSION 3.1)
if(POLICY CMP0053)
  cmake_policy(SET CMP0053 NEW)
endif()
project(QtImageViewer)

find_package(VTK COMPONENTS vtkGUISupportQt )
# find_package(VTK)
message ("use_files" ${VTK_USE_FILE})
include(${VTK_USE_FILE})
find_package(Qt5Core REQUIRED QUIET)
find_library( LIB_COCOA cocoa )

add_library(osxhelper SHARED osxHelper.mm)
target_link_libraries(osxhelper ${LIB_COCOA})

# add_library(cpposxhelper SHARED cpp_osx_helper.cpp osxHelper.mm)
# target_link_libraries(cpposxhelper ${osxhelper} ${LIB_COCOA})
add_library(cpposxhelper SHARED cpp_osx_helper.cpp osxHelper.mm)
target_link_libraries(cpposxhelper ${osxhelper} ${LIB_COCOA})


add_executable(qtimageviewer main.cpp osxHelper.mm)
qt5_use_modules(qtimageviewer Core Gui Widgets)
target_link_libraries(qtimageviewer ${VTK_LIBRARIES} ${LIB_COCOA})
