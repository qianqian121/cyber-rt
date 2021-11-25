cmake_minimum_required(VERSION 3.5)

set(CMAKE_ASM_CREATE_SHARED_LIBRARY "ld <CMAKE_SHARED_LIBRARY_CREATE_ASM_FLAGS>
<CMAKE_SHARED_LIBRARY_SONAME_ASM_FLAG><TARGET_SONAME> <LINK_FLAGS> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")

set(CMAKE_CXX_STANDARD 11)
option(BUILD_SHARED_LIBS "build as shared library" ON)

set(CYBER_ROOT ${PROJECT_SOURCE_DIR})
set(CYBER_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/opt/CyberRT/)
set(CYBER_INSTALL_BIN_DIR ${CMAKE_INSTALL_PREFIX}/opt/CyberRT/bin)
set(CYBER_INSTALL_LIB_DIR ${CMAKE_INSTALL_PREFIX}/opt/CyberRT/lib)
set(CYBER_INSTALL_INCLUDE_DIR ${CMAKE_INSTALL_PREFIX}/opt/CyberRT/include)
#set(LOCAL_DEPENDS_INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/local_depends )
set(LOCAL_DEPENDS_INSTALL_DIR /usr/local/fast-rtps)

#set(CMAKE_PREFIX_PATH ${CMAKE_CURRENT_BINARY_DIR}/local_depends)
set(CMAKE_PREFIX_PATH /usr/local/fast-rtps "${CMAKE_PREFIX_PATH}")

if (${CMAKE_VERSION} VERSION_LESS "3.15.0")
  set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake "${CMAKE_MODULE_PATH}")
else (${CMAKE_VERSION} VERSION_LESS "3.15.0")
  list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
endif()

message(STATUS "CMake Prefix Path: ${CMAKE_PREFIX_PATH}")
message(STATUS "CMake Module Path: ${CMAKE_MODULE_PATH}")

#include(cmake/external/glog-0.3.5.cmake)
#include(cmake/external/gflags-2.2.0.cmake)
#include(cmake/external/Fast-RTSP-1.5.0.cmake)
#include(cmake/external/protobuf-3.3.0.cmake)

project(Cyber VERSION 1.0.0 LANGUAGES C CXX ASM)

#if (EXISTS "${CMAKE_CURRENT_BINARY_DIR}/local_depends/lib")

  message(STATUS "Build cyber")
#include dependencies

find_package(Protobuf REQUIRED)

IF(Protobuf_FOUND)
    MESSAGE("Protobuf_VERSION:${Protobuf_VERSION}")
    MESSAGE("PROTOBUF_LIBRARIES:${PROTOBUF_LIBRARIES}")
    MESSAGE("Protobuf_INCLUDE_DIRS:${Protobuf_INCLUDE_DIRS}")
  message(STATUS "Found Protobuf ${PROTOBUF_INCLUDE_DIR} ${PROTOBUF_LIBRARIES}")

include_directories(${PROTOBUF_INCLUDE_DIR})
link_directories(${PROTOBUF_LIB_DIR})

message(STATUS "Protobuf inc: ${Protobuf_INCLUDE_DIR} lib : ${Protobuf_LIBRARY}")


    if (NOT TARGET Protobuf::libprotobuf)
        add_library(Protobuf::libprotobuf INTERFACE IMPORTED)
        target_link_libraries(Protobuf::libprotobuf INTERFACE ${Protobuf_LIBRARY})
        target_include_directories(Protobuf::libprotobuf INTERFACE ${Protobuf_INCLUDE_DIR})
    endif()

ENDIF()

#message(FATAL_ERROR "dddddddddddddddd")

find_package(FastRTPS REQUIRED)
message(STATUS "Found FastRTPS ${fastrtps_FIND_VERSION}")
message(STATUS "${fastrtps_LIB_DIR}, ${fastrtps_INCLUDE_DIR}")
include_directories(${fastrtps_INCLUDE_DIR})
link_directories(${fastrtps_LIB_DIR})

#message(FATAL_ERROR "dddddddddddddddd")

#add_library(FastRTPS::fastrtps INTERFACE IMPORTED)
#target_link_libraries(FastRTPS::fastrtps INTERFACE ${FastRTPS_LIBRARY})
#target_include_directories(FastRTPS::fastrtps INTERFACE ${FastRTPS_INCLUDE_DIR})
#message(FATAL_ERROR "dddddddddddddddd")
find_package(Poco REQUIRED COMPONENTS Foundation CONFIG)
message(STATUS "Found Poco: ${Poco_LIBRARIES}")

  find_package(Glog REQUIRED)
  find_package(Gflags REQUIRED)

  include_directories(
    PUBLIC
    ${PROJECT_SOURCE_DIR}/
#    ${CMAKE_CURRENT_BINARY_DIR}/local_depends/include/
  )

add_subdirectory(cyber/base)
add_subdirectory(cyber/blocker)
add_subdirectory(cyber/class_loader)
add_subdirectory(cyber/common)
add_subdirectory(cyber/component)
add_subdirectory(cyber/croutine)
add_subdirectory(cyber/event)
add_subdirectory(cyber/io)
add_subdirectory(cyber/logger)
add_subdirectory(cyber/message)
add_subdirectory(cyber/node)
add_subdirectory(cyber/parameter)
add_subdirectory(cyber/record)
add_subdirectory(cyber/proto)
add_subdirectory(cyber/scheduler)
add_subdirectory(cyber/sysmo)
add_subdirectory(cyber/service_discovery)
add_subdirectory(cyber/task)
add_subdirectory(cyber/time)
add_subdirectory(cyber/timer)
add_subdirectory(cyber/transport)
add_subdirectory(cyber)
add_subdirectory(cyber/py_wrapper)

add_subdirectory(cyber/mainboard)
add_subdirectory(cyber/examples)
add_subdirectory(cyber/tools/cyber_monitor)
add_subdirectory(cyber/tools/cyber_recorder)


#endif()

configure_file(CyberConfig.cmake.in
    "${PROJECT_BINARY_DIR}/CyberConfig.cmake" @ONLY)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    "${PROJECT_BINARY_DIR}/CyberConfig-version.cmake"
  COMPATIBILITY AnyNewerVersion)

install(FILES
    "${PROJECT_BINARY_DIR}/CyberConfig.cmake"
    "${PROJECT_BINARY_DIR}/CyberConfig-version.cmake"
  DESTINATION share/${PROJECT_NAME}/cmake)
install(DIRECTORY cyber/python DESTINATION ${CYBER_INSTALL_DIR}/bin)
install(DIRECTORY cyber/tools DESTINATION ${CYBER_INSTALL_DIR}/bin)
install(DIRECTORY cyber/examples DESTINATION ${CYBER_INSTALL_DIR}/bin)
install(DIRECTORY py_proto DESTINATION ${CYBER_INSTALL_DIR})
install(DIRECTORY log DESTINATION ${CYBER_INSTALL_DIR})
