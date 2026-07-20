cmake_minimum_required(VERSION 3.5)

project(entry)


set(CMAKE_CXX_STANDARD 17)


add_library(
    entry
    SHARED

    napi_bridge.cpp
    proxy_engine.cpp
)


target_include_directories(
    entry

    PRIVATE

    ${CMAKE_CURRENT_SOURCE_DIR}/include
)


add_library(
    libbox

    SHARED

    IMPORTED
)


set_target_properties(
    libbox

    PROPERTIES

    IMPORTED_LOCATION

    ${CMAKE_CURRENT_SOURCE_DIR}/../libs/arm64-v8a/libbox.so
)


target_link_libraries(

    entry

    libbox

    hilog_ndk.z

    ace_napi.z

    c++_shared

)