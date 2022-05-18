cmake_minimum_required(VERSION 3.16)

# set the project name
project(prompt)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/CMakeModules/")

find_package(libgit2)

# add the executable
add_executable(${PROJECT_NAME} prompt.cpp)

# setup include dirs and linked libs
target_include_directories(${PROJECT_NAME}
    PRIVATE ${LIBGIT2_INCLUDE_DIR})
target_link_libraries(${PROJECT_NAME}
    PRIVATE ${LIBGIT2_LIBRARIES})

target_compile_options(${PROJECT_NAME} PUBLIC "-O2")

# target_compile_definitions(exe1 PRIVATE
#   $<$<CONFIG:Debug>:DEBUG_BUILD>
# )

# target_compile_options(foo PUBLIC "$<$<CONFIG:DEBUG>:${MY_DEBUG_OPTIONS}>")
# target_compile_options(foo PUBLIC "$<$<CONFIG:RELEASE>:${MY_RELEASE_OPTIONS}>")
