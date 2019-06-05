project(square)

option(MSVC_USE_STATIC_RUNTIME OFF)
option(MSVC_USE_MP OFF)
option(BUILD_SHARED_SQUARE_LIB "build dll" OFF)

if (BUILD_SHARED_SQUARE_LIB)
    message("===========BUILD SHARED SQUARE LIBRARY===========")
    add_library(square SHARED square.cpp square.h)
else()
    message("===========BUILD STATIC SQUARE LIBRARY===========")
    add_library(square STATIC square.cpp square.h)
endif(BUILD_SHARED_SQUARE_LIB)

unset(BUILD_SHARED_SQUARE_LIB CACHE)

set(SQUARE_PATH "${CMAKE_CURRENT_LIST_DIR}" CACHE PATH "")
target_include_directories(square PUBLIC SQUARE_PATH)