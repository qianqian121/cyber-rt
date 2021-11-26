cmake_minimum_required(VERSION 3.5)
project(CyberData)

file(GLOB HEADERS *.h)

install(FILES ${HEADERS}
    DESTINATION ${CYBER_INSTALL_INCLUDE_DIR}/cyber/data/
    )

file(GLOB FUSION_HEADERS fusion/*.h)

install(FILES ${FUSION_HEADERS}
    DESTINATION ${CYBER_INSTALL_INCLUDE_DIR}/cyber/data/fusion/
    )
