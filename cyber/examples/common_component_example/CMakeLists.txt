cmake_minimum_required(VERSION 3.5)

project(common_component_example VERSION 1.0.0)

add_library(common_component_example SHARED common_component_example.cc)

target_link_libraries(common_component_example
    Cyber::init
    Cyber::transmitter
    cyber::examples_proto
)
install(TARGETS
    common_component_example
    DESTINATION  ${CYBER_INSTALL_LIB_DIR}
    )
