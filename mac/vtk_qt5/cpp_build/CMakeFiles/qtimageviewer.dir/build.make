# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.4

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Applications/CMake.app/Contents/bin/cmake

# The command to remove a file.
RM = /Applications/CMake.app/Contents/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/m/src/vtk_qt5/cpp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/m/src/vtk_qt5/cpp_build

# Include any dependencies generated for this target.
include CMakeFiles/qtimageviewer.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/qtimageviewer.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/qtimageviewer.dir/flags.make

CMakeFiles/qtimageviewer.dir/main.cpp.o: CMakeFiles/qtimageviewer.dir/flags.make
CMakeFiles/qtimageviewer.dir/main.cpp.o: /Users/m/src/vtk_qt5/cpp/main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/m/src/vtk_qt5/cpp_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/qtimageviewer.dir/main.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/qtimageviewer.dir/main.cpp.o -c /Users/m/src/vtk_qt5/cpp/main.cpp

CMakeFiles/qtimageviewer.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/qtimageviewer.dir/main.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/m/src/vtk_qt5/cpp/main.cpp > CMakeFiles/qtimageviewer.dir/main.cpp.i

CMakeFiles/qtimageviewer.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/qtimageviewer.dir/main.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/m/src/vtk_qt5/cpp/main.cpp -o CMakeFiles/qtimageviewer.dir/main.cpp.s

CMakeFiles/qtimageviewer.dir/main.cpp.o.requires:

.PHONY : CMakeFiles/qtimageviewer.dir/main.cpp.o.requires

CMakeFiles/qtimageviewer.dir/main.cpp.o.provides: CMakeFiles/qtimageviewer.dir/main.cpp.o.requires
	$(MAKE) -f CMakeFiles/qtimageviewer.dir/build.make CMakeFiles/qtimageviewer.dir/main.cpp.o.provides.build
.PHONY : CMakeFiles/qtimageviewer.dir/main.cpp.o.provides

CMakeFiles/qtimageviewer.dir/main.cpp.o.provides.build: CMakeFiles/qtimageviewer.dir/main.cpp.o


CMakeFiles/qtimageviewer.dir/osxHelper.mm.o: CMakeFiles/qtimageviewer.dir/flags.make
CMakeFiles/qtimageviewer.dir/osxHelper.mm.o: /Users/m/src/vtk_qt5/cpp/osxHelper.mm
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/m/src/vtk_qt5/cpp_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/qtimageviewer.dir/osxHelper.mm.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/qtimageviewer.dir/osxHelper.mm.o -c /Users/m/src/vtk_qt5/cpp/osxHelper.mm

CMakeFiles/qtimageviewer.dir/osxHelper.mm.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/qtimageviewer.dir/osxHelper.mm.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/m/src/vtk_qt5/cpp/osxHelper.mm > CMakeFiles/qtimageviewer.dir/osxHelper.mm.i

CMakeFiles/qtimageviewer.dir/osxHelper.mm.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/qtimageviewer.dir/osxHelper.mm.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/m/src/vtk_qt5/cpp/osxHelper.mm -o CMakeFiles/qtimageviewer.dir/osxHelper.mm.s

CMakeFiles/qtimageviewer.dir/osxHelper.mm.o.requires:

.PHONY : CMakeFiles/qtimageviewer.dir/osxHelper.mm.o.requires

CMakeFiles/qtimageviewer.dir/osxHelper.mm.o.provides: CMakeFiles/qtimageviewer.dir/osxHelper.mm.o.requires
	$(MAKE) -f CMakeFiles/qtimageviewer.dir/build.make CMakeFiles/qtimageviewer.dir/osxHelper.mm.o.provides.build
.PHONY : CMakeFiles/qtimageviewer.dir/osxHelper.mm.o.provides

CMakeFiles/qtimageviewer.dir/osxHelper.mm.o.provides.build: CMakeFiles/qtimageviewer.dir/osxHelper.mm.o


# Object files for target qtimageviewer
qtimageviewer_OBJECTS = \
"CMakeFiles/qtimageviewer.dir/main.cpp.o" \
"CMakeFiles/qtimageviewer.dir/osxHelper.mm.o"

# External object files for target qtimageviewer
qtimageviewer_EXTERNAL_OBJECTS =

qtimageviewer: CMakeFiles/qtimageviewer.dir/main.cpp.o
qtimageviewer: CMakeFiles/qtimageviewer.dir/osxHelper.mm.o
qtimageviewer: CMakeFiles/qtimageviewer.dir/build.make
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkGUISupportQt-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkInteractionStyle-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkRenderingOpenGL2-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkIOImage-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkDICOMParser-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkmetaio-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkpng-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtktiff-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkglew-7.1.1.dylib
qtimageviewer: /Users/m/Qt5.7.1/5.7/clang_64/lib/QtWidgets.framework/QtWidgets
qtimageviewer: /Users/m/Qt5.7.1/5.7/clang_64/lib/QtGui.framework/QtGui
qtimageviewer: /Users/m/Qt5.7.1/5.7/clang_64/lib/QtCore.framework/QtCore
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkFiltersExtraction-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkFiltersStatistics-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkImagingFourier-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkalglib-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkImagingCore-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkRenderingCore-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkFiltersSources-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkFiltersGeneral-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkCommonComputationalGeometry-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkCommonColor-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkFiltersGeometry-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkFiltersCore-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkCommonExecutionModel-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkCommonDataModel-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkCommonTransforms-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkCommonMisc-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkCommonMath-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkCommonSystem-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkCommonCore-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtksys-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkzlib-7.1.1.dylib
qtimageviewer: /Users/m/Downloads/VTK-7.1.0_install_qt5/lib/libvtkjpeg-7.1.1.dylib
qtimageviewer: /usr/lib/libm.dylib
qtimageviewer: CMakeFiles/qtimageviewer.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/m/src/vtk_qt5/cpp_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable qtimageviewer"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/qtimageviewer.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/qtimageviewer.dir/build: qtimageviewer

.PHONY : CMakeFiles/qtimageviewer.dir/build

CMakeFiles/qtimageviewer.dir/requires: CMakeFiles/qtimageviewer.dir/main.cpp.o.requires
CMakeFiles/qtimageviewer.dir/requires: CMakeFiles/qtimageviewer.dir/osxHelper.mm.o.requires

.PHONY : CMakeFiles/qtimageviewer.dir/requires

CMakeFiles/qtimageviewer.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/qtimageviewer.dir/cmake_clean.cmake
.PHONY : CMakeFiles/qtimageviewer.dir/clean

CMakeFiles/qtimageviewer.dir/depend:
	cd /Users/m/src/vtk_qt5/cpp_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/m/src/vtk_qt5/cpp /Users/m/src/vtk_qt5/cpp /Users/m/src/vtk_qt5/cpp_build /Users/m/src/vtk_qt5/cpp_build /Users/m/src/vtk_qt5/cpp_build/CMakeFiles/qtimageviewer.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/qtimageviewer.dir/depend

