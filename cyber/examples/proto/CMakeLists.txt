cmake_minimum_required(VERSION 3.5.1)

set(PROTOS examples.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})
SET_SOURCE_FILES_PROPERTIES(${PROTO_SRCS} ${PROTO_HDRS} PROPERTIES GENERATED TRUE)

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(cyber_examples_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(cyber_examples_proto ${PROTOBUF_LIBRARIES})
add_library(cyber::examples_proto ALIAS cyber_examples_proto)


install(TARGETS cyber_examples_proto
        DESTINATION  ${CYBER_INSTALL_LIB_DIR}
        )
