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
include CMakeFiles/cpposxhelper.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/cpposxhelper.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/cpposxhelper.dir/flags.make

CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o: CMakeFiles/cpposxhelper.dir/flags.make
CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o: /Users/m/src/vtk_qt5/cpp/cpp_osx_helper.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/m/src/vtk_qt5/cpp_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o -c /Users/m/src/vtk_qt5/cpp/cpp_osx_helper.cpp

CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/m/src/vtk_qt5/cpp/cpp_osx_helper.cpp > CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.i

CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/m/src/vtk_qt5/cpp/cpp_osx_helper.cpp -o CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.s

CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o.requires:

.PHONY : CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o.requires

CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o.provides: CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o.requires
	$(MAKE) -f CMakeFiles/cpposxhelper.dir/build.make CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o.provides.build
.PHONY : CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o.provides

CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o.provides.build: CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o


CMakeFiles/cpposxhelper.dir/osxHelper.mm.o: CMakeFiles/cpposxhelper.dir/flags.make
CMakeFiles/cpposxhelper.dir/osxHelper.mm.o: /Users/m/src/vtk_qt5/cpp/osxHelper.mm
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/m/src/vtk_qt5/cpp_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/cpposxhelper.dir/osxHelper.mm.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cpposxhelper.dir/osxHelper.mm.o -c /Users/m/src/vtk_qt5/cpp/osxHelper.mm

CMakeFiles/cpposxhelper.dir/osxHelper.mm.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cpposxhelper.dir/osxHelper.mm.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/m/src/vtk_qt5/cpp/osxHelper.mm > CMakeFiles/cpposxhelper.dir/osxHelper.mm.i

CMakeFiles/cpposxhelper.dir/osxHelper.mm.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cpposxhelper.dir/osxHelper.mm.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/m/src/vtk_qt5/cpp/osxHelper.mm -o CMakeFiles/cpposxhelper.dir/osxHelper.mm.s

CMakeFiles/cpposxhelper.dir/osxHelper.mm.o.requires:

.PHONY : CMakeFiles/cpposxhelper.dir/osxHelper.mm.o.requires

CMakeFiles/cpposxhelper.dir/osxHelper.mm.o.provides: CMakeFiles/cpposxhelper.dir/osxHelper.mm.o.requires
	$(MAKE) -f CMakeFiles/cpposxhelper.dir/build.make CMakeFiles/cpposxhelper.dir/osxHelper.mm.o.provides.build
.PHONY : CMakeFiles/cpposxhelper.dir/osxHelper.mm.o.provides

CMakeFiles/cpposxhelper.dir/osxHelper.mm.o.provides.build: CMakeFiles/cpposxhelper.dir/osxHelper.mm.o


# Object files for target cpposxhelper
cpposxhelper_OBJECTS = \
"CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o" \
"CMakeFiles/cpposxhelper.dir/osxHelper.mm.o"

# External object files for target cpposxhelper
cpposxhelper_EXTERNAL_OBJECTS =

libcpposxhelper.dylib: CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o
libcpposxhelper.dylib: CMakeFiles/cpposxhelper.dir/osxHelper.mm.o
libcpposxhelper.dylib: CMakeFiles/cpposxhelper.dir/build.make
libcpposxhelper.dylib: CMakeFiles/cpposxhelper.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/m/src/vtk_qt5/cpp_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX shared library libcpposxhelper.dylib"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/cpposxhelper.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/cpposxhelper.dir/build: libcpposxhelper.dylib

.PHONY : CMakeFiles/cpposxhelper.dir/build

CMakeFiles/cpposxhelper.dir/requires: CMakeFiles/cpposxhelper.dir/cpp_osx_helper.cpp.o.requires
CMakeFiles/cpposxhelper.dir/requires: CMakeFiles/cpposxhelper.dir/osxHelper.mm.o.requires

.PHONY : CMakeFiles/cpposxhelper.dir/requires

CMakeFiles/cpposxhelper.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/cpposxhelper.dir/cmake_clean.cmake
.PHONY : CMakeFiles/cpposxhelper.dir/clean

CMakeFiles/cpposxhelper.dir/depend:
	cd /Users/m/src/vtk_qt5/cpp_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/m/src/vtk_qt5/cpp /Users/m/src/vtk_qt5/cpp /Users/m/src/vtk_qt5/cpp_build /Users/m/src/vtk_qt5/cpp_build /Users/m/src/vtk_qt5/cpp_build/CMakeFiles/cpposxhelper.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/cpposxhelper.dir/depend
