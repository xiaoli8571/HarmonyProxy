@"
cmake_minimum_required(VERSION 3.5)

project(HarmonyProxy)

add_library(
  harmonyproxy
SHARED
napi_bridge.cpp
proxy_engine.cpp
)

target_include_directories(
  harmonyproxy
PRIVATE
include
)
"@ | Set-Content entry\src\main\cpp\CMakeLists.txt