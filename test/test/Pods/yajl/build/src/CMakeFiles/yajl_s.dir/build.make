# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.3

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
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.3.2/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.3.2/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build

# Include any dependencies generated for this target.
include src/CMakeFiles/yajl_s.dir/depend.make

# Include the progress variables for this target.
include src/CMakeFiles/yajl_s.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/yajl_s.dir/flags.make

src/CMakeFiles/yajl_s.dir/yajl.c.o: src/CMakeFiles/yajl_s.dir/flags.make
src/CMakeFiles/yajl_s.dir/yajl.c.o: ../src/yajl.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/CMakeFiles/yajl_s.dir/yajl.c.o"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/yajl_s.dir/yajl.c.o   -c /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl.c

src/CMakeFiles/yajl_s.dir/yajl.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/yajl_s.dir/yajl.c.i"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl.c > CMakeFiles/yajl_s.dir/yajl.c.i

src/CMakeFiles/yajl_s.dir/yajl.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/yajl_s.dir/yajl.c.s"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl.c -o CMakeFiles/yajl_s.dir/yajl.c.s

src/CMakeFiles/yajl_s.dir/yajl.c.o.requires:

.PHONY : src/CMakeFiles/yajl_s.dir/yajl.c.o.requires

src/CMakeFiles/yajl_s.dir/yajl.c.o.provides: src/CMakeFiles/yajl_s.dir/yajl.c.o.requires
	$(MAKE) -f src/CMakeFiles/yajl_s.dir/build.make src/CMakeFiles/yajl_s.dir/yajl.c.o.provides.build
.PHONY : src/CMakeFiles/yajl_s.dir/yajl.c.o.provides

src/CMakeFiles/yajl_s.dir/yajl.c.o.provides.build: src/CMakeFiles/yajl_s.dir/yajl.c.o


src/CMakeFiles/yajl_s.dir/yajl_lex.c.o: src/CMakeFiles/yajl_s.dir/flags.make
src/CMakeFiles/yajl_s.dir/yajl_lex.c.o: ../src/yajl_lex.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object src/CMakeFiles/yajl_s.dir/yajl_lex.c.o"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/yajl_s.dir/yajl_lex.c.o   -c /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_lex.c

src/CMakeFiles/yajl_s.dir/yajl_lex.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/yajl_s.dir/yajl_lex.c.i"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_lex.c > CMakeFiles/yajl_s.dir/yajl_lex.c.i

src/CMakeFiles/yajl_s.dir/yajl_lex.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/yajl_s.dir/yajl_lex.c.s"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_lex.c -o CMakeFiles/yajl_s.dir/yajl_lex.c.s

src/CMakeFiles/yajl_s.dir/yajl_lex.c.o.requires:

.PHONY : src/CMakeFiles/yajl_s.dir/yajl_lex.c.o.requires

src/CMakeFiles/yajl_s.dir/yajl_lex.c.o.provides: src/CMakeFiles/yajl_s.dir/yajl_lex.c.o.requires
	$(MAKE) -f src/CMakeFiles/yajl_s.dir/build.make src/CMakeFiles/yajl_s.dir/yajl_lex.c.o.provides.build
.PHONY : src/CMakeFiles/yajl_s.dir/yajl_lex.c.o.provides

src/CMakeFiles/yajl_s.dir/yajl_lex.c.o.provides.build: src/CMakeFiles/yajl_s.dir/yajl_lex.c.o


src/CMakeFiles/yajl_s.dir/yajl_parser.c.o: src/CMakeFiles/yajl_s.dir/flags.make
src/CMakeFiles/yajl_s.dir/yajl_parser.c.o: ../src/yajl_parser.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object src/CMakeFiles/yajl_s.dir/yajl_parser.c.o"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/yajl_s.dir/yajl_parser.c.o   -c /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_parser.c

src/CMakeFiles/yajl_s.dir/yajl_parser.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/yajl_s.dir/yajl_parser.c.i"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_parser.c > CMakeFiles/yajl_s.dir/yajl_parser.c.i

src/CMakeFiles/yajl_s.dir/yajl_parser.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/yajl_s.dir/yajl_parser.c.s"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_parser.c -o CMakeFiles/yajl_s.dir/yajl_parser.c.s

src/CMakeFiles/yajl_s.dir/yajl_parser.c.o.requires:

.PHONY : src/CMakeFiles/yajl_s.dir/yajl_parser.c.o.requires

src/CMakeFiles/yajl_s.dir/yajl_parser.c.o.provides: src/CMakeFiles/yajl_s.dir/yajl_parser.c.o.requires
	$(MAKE) -f src/CMakeFiles/yajl_s.dir/build.make src/CMakeFiles/yajl_s.dir/yajl_parser.c.o.provides.build
.PHONY : src/CMakeFiles/yajl_s.dir/yajl_parser.c.o.provides

src/CMakeFiles/yajl_s.dir/yajl_parser.c.o.provides.build: src/CMakeFiles/yajl_s.dir/yajl_parser.c.o


src/CMakeFiles/yajl_s.dir/yajl_buf.c.o: src/CMakeFiles/yajl_s.dir/flags.make
src/CMakeFiles/yajl_s.dir/yajl_buf.c.o: ../src/yajl_buf.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object src/CMakeFiles/yajl_s.dir/yajl_buf.c.o"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/yajl_s.dir/yajl_buf.c.o   -c /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_buf.c

src/CMakeFiles/yajl_s.dir/yajl_buf.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/yajl_s.dir/yajl_buf.c.i"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_buf.c > CMakeFiles/yajl_s.dir/yajl_buf.c.i

src/CMakeFiles/yajl_s.dir/yajl_buf.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/yajl_s.dir/yajl_buf.c.s"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_buf.c -o CMakeFiles/yajl_s.dir/yajl_buf.c.s

src/CMakeFiles/yajl_s.dir/yajl_buf.c.o.requires:

.PHONY : src/CMakeFiles/yajl_s.dir/yajl_buf.c.o.requires

src/CMakeFiles/yajl_s.dir/yajl_buf.c.o.provides: src/CMakeFiles/yajl_s.dir/yajl_buf.c.o.requires
	$(MAKE) -f src/CMakeFiles/yajl_s.dir/build.make src/CMakeFiles/yajl_s.dir/yajl_buf.c.o.provides.build
.PHONY : src/CMakeFiles/yajl_s.dir/yajl_buf.c.o.provides

src/CMakeFiles/yajl_s.dir/yajl_buf.c.o.provides.build: src/CMakeFiles/yajl_s.dir/yajl_buf.c.o


src/CMakeFiles/yajl_s.dir/yajl_encode.c.o: src/CMakeFiles/yajl_s.dir/flags.make
src/CMakeFiles/yajl_s.dir/yajl_encode.c.o: ../src/yajl_encode.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object src/CMakeFiles/yajl_s.dir/yajl_encode.c.o"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/yajl_s.dir/yajl_encode.c.o   -c /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_encode.c

src/CMakeFiles/yajl_s.dir/yajl_encode.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/yajl_s.dir/yajl_encode.c.i"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_encode.c > CMakeFiles/yajl_s.dir/yajl_encode.c.i

src/CMakeFiles/yajl_s.dir/yajl_encode.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/yajl_s.dir/yajl_encode.c.s"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_encode.c -o CMakeFiles/yajl_s.dir/yajl_encode.c.s

src/CMakeFiles/yajl_s.dir/yajl_encode.c.o.requires:

.PHONY : src/CMakeFiles/yajl_s.dir/yajl_encode.c.o.requires

src/CMakeFiles/yajl_s.dir/yajl_encode.c.o.provides: src/CMakeFiles/yajl_s.dir/yajl_encode.c.o.requires
	$(MAKE) -f src/CMakeFiles/yajl_s.dir/build.make src/CMakeFiles/yajl_s.dir/yajl_encode.c.o.provides.build
.PHONY : src/CMakeFiles/yajl_s.dir/yajl_encode.c.o.provides

src/CMakeFiles/yajl_s.dir/yajl_encode.c.o.provides.build: src/CMakeFiles/yajl_s.dir/yajl_encode.c.o


src/CMakeFiles/yajl_s.dir/yajl_gen.c.o: src/CMakeFiles/yajl_s.dir/flags.make
src/CMakeFiles/yajl_s.dir/yajl_gen.c.o: ../src/yajl_gen.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object src/CMakeFiles/yajl_s.dir/yajl_gen.c.o"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/yajl_s.dir/yajl_gen.c.o   -c /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_gen.c

src/CMakeFiles/yajl_s.dir/yajl_gen.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/yajl_s.dir/yajl_gen.c.i"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_gen.c > CMakeFiles/yajl_s.dir/yajl_gen.c.i

src/CMakeFiles/yajl_s.dir/yajl_gen.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/yajl_s.dir/yajl_gen.c.s"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_gen.c -o CMakeFiles/yajl_s.dir/yajl_gen.c.s

src/CMakeFiles/yajl_s.dir/yajl_gen.c.o.requires:

.PHONY : src/CMakeFiles/yajl_s.dir/yajl_gen.c.o.requires

src/CMakeFiles/yajl_s.dir/yajl_gen.c.o.provides: src/CMakeFiles/yajl_s.dir/yajl_gen.c.o.requires
	$(MAKE) -f src/CMakeFiles/yajl_s.dir/build.make src/CMakeFiles/yajl_s.dir/yajl_gen.c.o.provides.build
.PHONY : src/CMakeFiles/yajl_s.dir/yajl_gen.c.o.provides

src/CMakeFiles/yajl_s.dir/yajl_gen.c.o.provides.build: src/CMakeFiles/yajl_s.dir/yajl_gen.c.o


src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o: src/CMakeFiles/yajl_s.dir/flags.make
src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o: ../src/yajl_alloc.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/yajl_s.dir/yajl_alloc.c.o   -c /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_alloc.c

src/CMakeFiles/yajl_s.dir/yajl_alloc.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/yajl_s.dir/yajl_alloc.c.i"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_alloc.c > CMakeFiles/yajl_s.dir/yajl_alloc.c.i

src/CMakeFiles/yajl_s.dir/yajl_alloc.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/yajl_s.dir/yajl_alloc.c.s"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_alloc.c -o CMakeFiles/yajl_s.dir/yajl_alloc.c.s

src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o.requires:

.PHONY : src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o.requires

src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o.provides: src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o.requires
	$(MAKE) -f src/CMakeFiles/yajl_s.dir/build.make src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o.provides.build
.PHONY : src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o.provides

src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o.provides.build: src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o


src/CMakeFiles/yajl_s.dir/yajl_version.c.o: src/CMakeFiles/yajl_s.dir/flags.make
src/CMakeFiles/yajl_s.dir/yajl_version.c.o: ../src/yajl_version.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building C object src/CMakeFiles/yajl_s.dir/yajl_version.c.o"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/yajl_s.dir/yajl_version.c.o   -c /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_version.c

src/CMakeFiles/yajl_s.dir/yajl_version.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/yajl_s.dir/yajl_version.c.i"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_version.c > CMakeFiles/yajl_s.dir/yajl_version.c.i

src/CMakeFiles/yajl_s.dir/yajl_version.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/yajl_s.dir/yajl_version.c.s"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/yajl_version.c -o CMakeFiles/yajl_s.dir/yajl_version.c.s

src/CMakeFiles/yajl_s.dir/yajl_version.c.o.requires:

.PHONY : src/CMakeFiles/yajl_s.dir/yajl_version.c.o.requires

src/CMakeFiles/yajl_s.dir/yajl_version.c.o.provides: src/CMakeFiles/yajl_s.dir/yajl_version.c.o.requires
	$(MAKE) -f src/CMakeFiles/yajl_s.dir/build.make src/CMakeFiles/yajl_s.dir/yajl_version.c.o.provides.build
.PHONY : src/CMakeFiles/yajl_s.dir/yajl_version.c.o.provides

src/CMakeFiles/yajl_s.dir/yajl_version.c.o.provides.build: src/CMakeFiles/yajl_s.dir/yajl_version.c.o


# Object files for target yajl_s
yajl_s_OBJECTS = \
"CMakeFiles/yajl_s.dir/yajl.c.o" \
"CMakeFiles/yajl_s.dir/yajl_lex.c.o" \
"CMakeFiles/yajl_s.dir/yajl_parser.c.o" \
"CMakeFiles/yajl_s.dir/yajl_buf.c.o" \
"CMakeFiles/yajl_s.dir/yajl_encode.c.o" \
"CMakeFiles/yajl_s.dir/yajl_gen.c.o" \
"CMakeFiles/yajl_s.dir/yajl_alloc.c.o" \
"CMakeFiles/yajl_s.dir/yajl_version.c.o"

# External object files for target yajl_s
yajl_s_EXTERNAL_OBJECTS =

yajl-1.0.12/lib/libyajl_s.a: src/CMakeFiles/yajl_s.dir/yajl.c.o
yajl-1.0.12/lib/libyajl_s.a: src/CMakeFiles/yajl_s.dir/yajl_lex.c.o
yajl-1.0.12/lib/libyajl_s.a: src/CMakeFiles/yajl_s.dir/yajl_parser.c.o
yajl-1.0.12/lib/libyajl_s.a: src/CMakeFiles/yajl_s.dir/yajl_buf.c.o
yajl-1.0.12/lib/libyajl_s.a: src/CMakeFiles/yajl_s.dir/yajl_encode.c.o
yajl-1.0.12/lib/libyajl_s.a: src/CMakeFiles/yajl_s.dir/yajl_gen.c.o
yajl-1.0.12/lib/libyajl_s.a: src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o
yajl-1.0.12/lib/libyajl_s.a: src/CMakeFiles/yajl_s.dir/yajl_version.c.o
yajl-1.0.12/lib/libyajl_s.a: src/CMakeFiles/yajl_s.dir/build.make
yajl-1.0.12/lib/libyajl_s.a: src/CMakeFiles/yajl_s.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Linking C static library ../yajl-1.0.12/lib/libyajl_s.a"
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && $(CMAKE_COMMAND) -P CMakeFiles/yajl_s.dir/cmake_clean_target.cmake
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/yajl_s.dir/link.txt --verbose=$(VERBOSE)
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /usr/local/Cellar/cmake/3.3.2/bin/cmake -E copy_if_different /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/api/yajl_parse.h /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src/../yajl-1.0.12/include/yajl
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /usr/local/Cellar/cmake/3.3.2/bin/cmake -E copy_if_different /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/api/yajl_gen.h /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src/../yajl-1.0.12/include/yajl
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && /usr/local/Cellar/cmake/3.3.2/bin/cmake -E copy_if_different /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/api/yajl_common.h /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src/../yajl-1.0.12/include/yajl

# Rule to build all files generated by this target.
src/CMakeFiles/yajl_s.dir/build: yajl-1.0.12/lib/libyajl_s.a

.PHONY : src/CMakeFiles/yajl_s.dir/build

src/CMakeFiles/yajl_s.dir/requires: src/CMakeFiles/yajl_s.dir/yajl.c.o.requires
src/CMakeFiles/yajl_s.dir/requires: src/CMakeFiles/yajl_s.dir/yajl_lex.c.o.requires
src/CMakeFiles/yajl_s.dir/requires: src/CMakeFiles/yajl_s.dir/yajl_parser.c.o.requires
src/CMakeFiles/yajl_s.dir/requires: src/CMakeFiles/yajl_s.dir/yajl_buf.c.o.requires
src/CMakeFiles/yajl_s.dir/requires: src/CMakeFiles/yajl_s.dir/yajl_encode.c.o.requires
src/CMakeFiles/yajl_s.dir/requires: src/CMakeFiles/yajl_s.dir/yajl_gen.c.o.requires
src/CMakeFiles/yajl_s.dir/requires: src/CMakeFiles/yajl_s.dir/yajl_alloc.c.o.requires
src/CMakeFiles/yajl_s.dir/requires: src/CMakeFiles/yajl_s.dir/yajl_version.c.o.requires

.PHONY : src/CMakeFiles/yajl_s.dir/requires

src/CMakeFiles/yajl_s.dir/clean:
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src && $(CMAKE_COMMAND) -P CMakeFiles/yajl_s.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/yajl_s.dir/clean

src/CMakeFiles/yajl_s.dir/depend:
	cd /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src/CMakeFiles/yajl_s.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/yajl_s.dir/depend

