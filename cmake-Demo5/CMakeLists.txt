# CMake 最低版本号要求
cmake_minimum_required (VERSION 2.8)

# 项目信息
project (Demo5)

#设置工程包含当前目录，非必须,但是不打开该开关，该参数USE_MYMATH设置失效，原因暂不详
SET(CMAKE_INCLUDE_CURRENT_DIR ON)

# 打印PATH环境变量设置
message("ngf test: PATH is $ENV{PATH}")

# 设置版本号
set (Demo_VERSION_MAJOR 9)
set (Demo_VERSION_MINOR 5)
set (Demo_VERSION_PATCH 2)

# 设置编译参数
#add_compile_options(-std=c++11)
add_definitions(-std=c++11)

# 设置install文件安装路径
SET(CMAKE_INSTALL_PREFIX .)
message("ngf test: CMAKE_INSTALL_PREFIX is ${CMAKE_INSTALL_PREFIX}")


# 方法一：
# 是否加入 MathFunctions 库
# 是否使用自己的 MathFunctions 库
option (USE_MYMATH
	   "Use provided math implementation" ON)
	   
if (USE_MYMATH)
  include_directories ("${PROJECT_SOURCE_DIR}/math")
  add_subdirectory (math)
  set (EXTRA_LIBS MathFunctions)
#  set (EXTRA_LIBS ${EXTRA_LIBS} MathFunctions)
  message("ngf test: use my own customer library.")
else()
  message("ngf test: use the standard library.")
endif ()
#endif (USE_MYMATH)

# 加入一个配置头文件，用于处理 CMake 对源码中宏定义的设置
configure_file (
  "${PROJECT_SOURCE_DIR}/config.h.in"
  "${PROJECT_BINARY_DIR}/config.h"
  )

# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_SRCS 变量
#aux_source_directory(. DIR_SRCS)
 FILE(GLOB DIR_SRCS "./*.cc") 
 FILE(GLOB HEAD_FILES "./*.h")

# 指定生成目标
add_executable(${PROJECT_NAME} ${DIR_SRCS})
target_link_libraries (${PROJECT_NAME}  ${EXTRA_LIBS})

# 指定安装路径
set(LIBRARY_OUTPUT_PATH ${CMAKE_INSTALL_PREFIX}/bin)
set(INCLUDE_OUTPUT_PATH ${CMAKE_INSTALL_PREFIX}/include)
install (TARGETS ${PROJECT_NAME} DESTINATION ${LIBRARY_OUTPUT_PATH})
install (FILES "${PROJECT_BINARY_DIR}/config.h" DESTINATION ${INCLUDE_OUTPUT_PATH})

# 启用测试
enable_testing()

# 测试程序是否成功运行
add_test (test_run ${PROJECT_NAME} 5 2)

# 测试帮助信息是否可以正常提示
add_test (test_usage ${PROJECT_NAME})
set_tests_properties (test_usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage: .* base exponent")

# 方法一：
#[[ *********************************
# 测试 5 的平方
 add_test (test_5_2 ${PROJECT_NAME} 5 2)

# set_tests_properties (test_5_2
 PROPERTIES PASS_REGULAR_EXPRESSION "is 25")

# 测试 10 的 5 次方
 add_test (test_10_5 ${PROJECT_NAME} 10 5)

# set_tests_properties (test_10_5
 PROPERTIES PASS_REGULAR_EXPRESSION "is 100000")

# 测试 2 的 10 次方
 add_test (test_2_10 ${PROJECT_NAME} 2 10)

# set_tests_properties (test_2_10
 PROPERTIES PASS_REGULAR_EXPRESSION "is 1024")
********************************* ]]

# 方法二：
# 定义一个宏，用来简化测试工作
macro (do_test arg1 arg2 result)
  add_test (test_${arg1}_${arg2} ${PROJECT_NAME} ${arg1} ${arg2})
  set_tests_properties (test_${arg1}_${arg2}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result})
endmacro (do_test)

# 利用 do_test 宏，测试一系列数据
do_test (5 2 "is 25")
do_test (10 5 "is 100000")
do_test (2 10 "is 1024")


# 构建一个 CPack 安装包
include (InstallRequiredSystemLibraries)
set (CPACK_RESOURCE_FILE_LICENSE
  "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set (CPACK_PACKAGE_VERSION_MAJOR "${Demo_VERSION_MAJOR}")
set (CPACK_PACKAGE_VERSION_MINOR "${Demo_VERSION_MINOR}")
set (CPACK_PACKAGE_VERSION_PATCH  "${Demo_VERSION_PATCH}")

#set(VERSION ${CPACK_PACKAGE_VERSION_MAJOR}-${CPACK_PACKAGE_VERSION_MINOR}-${CPACK_PACKAGE_VERSION_PATCH})
include (CPack)
