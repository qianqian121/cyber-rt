cmake_minimum_required(VERSION 3.5)

project(protos)
## TODO: make this with protoc
#file(GLOB CYBER_PROTO_SRCS *.proto)
set(PROTOS choreography_conf.proto
           classic_conf.proto
           component_conf.proto
           cyber_conf.proto
           dag_conf.proto
           parameter.proto
           perception.proto
           perf_conf.proto
           proto_desc.proto
           qos_profile.proto
           record.proto
           role_attributes.proto
           run_mode_conf.proto
           scheduler_conf.proto
           topology_change.proto
           transport_conf.proto
           unit_test.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})
SET_SOURCE_FILES_PROPERTIES(${PROTO_SRCS} ${PROTO_HDRS} PROPERTIES GENERATED TRUE)

include_directories(${Cyber_BINARY_DIR})
include_directories(${PROTOBUF_INCLUDE_DIRS})
#message(FATAL_ERROR ${Cyber_BINARY_DIR})
add_library(cyber_proto SHARED ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(cyber_proto Protobuf::libprotobuf cyber::examples_proto)

add_library(Cyber::dag_conf ALIAS cyber_proto)
add_library(Cyber::component_conf ALIAS cyber_proto)
add_library(Cyber::choreography_conf ALIAS cyber_proto)
add_library(Cyber::classic_conf ALIAS cyber_proto)
add_library(Cyber::cyber_conf ALIAS cyber_proto)
add_library(Cyber::qos_profile ALIAS cyber_proto)
add_library(Cyber::role_attributes ALIAS cyber_proto)
add_library(Cyber::pb_parameter ALIAS cyber_proto)
add_library(Cyber::run_mode_conf ALIAS cyber_proto)
add_library(Cyber::scheduler_conf ALIAS cyber_proto)
add_library(Cyber::perception  ALIAS cyber_proto)
add_library(Cyber::proto_desc ALIAS cyber_proto)
add_library(Cyber::pb_record ALIAS cyber_proto)
add_library(Cyber::topology_change ALIAS cyber_proto)
add_library(Cyber::transport_conf ALIAS cyber_proto)
add_library(Cyber::unit_test ALIAS cyber_proto)
add_library(Cyber::perf_conf ALIAS cyber_proto)

file(GLOB HEADERS *.pb.h)

install(FILES ${HEADERS}
    DESTINATION ${CYBER_INSTALL_INCLUDE_DIR}/cyber/proto/
    )

install(TARGETS
    cyber_proto
    DESTINATION  ${CYBER_INSTALL_LIB_DIR}
    )
