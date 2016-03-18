# Install script for directory: /Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES
    "/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/yajl-1.0.12/lib/libyajl.1.0.12.dylib"
    "/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/yajl-1.0.12/lib/libyajl.1.dylib"
    "/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/yajl-1.0.12/lib/libyajl.dylib"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libyajl.1.0.12.dylib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libyajl.1.dylib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libyajl.dylib"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      execute_process(COMMAND "/usr/bin/install_name_tool"
        -id "/usr/local/lib/libyajl.1.dylib"
        "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/yajl-1.0.12/lib/libyajl_s.a")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libyajl_s.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libyajl_s.a")
    execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libyajl_s.a")
  endif()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/yajl" TYPE FILE FILES
    "/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/api/yajl_parse.h"
    "/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/api/yajl_gen.h"
    "/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/src/api/yajl_common.h"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/yajl" TYPE FILE FILES "/Users/star/Library/Caches/CocoaPods/Pods/Release/yajl/1.0.12-e435f/build/src/../yajl-1.0.12/include/yajl/yajl_version.h")
endif()

