find_library(Glog_LIBRARY NAMES "glog"
    PATHS "/usr/local/lib"
    NO_DEFAULT_PATH
    )
find_path(Glog_INCLUDE_DIR NAMES "glog/logging.h"
    PATHS "/usr/local/include"
    DOC "The Glog Include path")
message(STATUS "Glog inc: ${Glog_INCLUDE_DIR} lib: ${Glog_LIBRARY}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Glog DEFAULT_MSG Glog_INCLUDE_DIR Glog_LIBRARY)

mark_as_advanced(Glog_INCLUDE_DIR Glog_LIBRARY)

if(Glog_FOUND)
    if (NOT TARGET Glog::glog)
        add_library(Glog::glog INTERFACE IMPORTED)
        target_link_libraries(Glog::glog INTERFACE ${Glog_LIBRARY})
        target_include_directories(Glog::glog INTERFACE ${Glog_INCLUDE_DIR})
    endif()
endif()
