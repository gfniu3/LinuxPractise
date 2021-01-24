# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_LIB_SRCS 变量
aux_source_directory(. DIR_LIB_SRCS)

# 生成静态库
#add_library (MathFunctions ${DIR_LIB_SRCS})

# BUILD_SHARED_LIBS这个开关用来控制默认的库编译方式,
# 如果不进行设置,使用 ADD_LIBRARY 并没有指定库类型的情况下,默认编译生成的库都是静态库。
# 如果 SET(BUILD_SHARED_LIBS ON)后,默认生成的为动态库
#SET(BUILD_SHARED_LIBS ON)
#add_library (MathFunctions ${DIR_LIB_SRCS})

# 生成动态库：库类型有三种：STATIC  SHARED MODULE，默认为STATIC
#add_library (MathFunctions SHARED  ${DIR_LIB_SRCS})

# 同时生成静态库和动态库，并加载，通过符号表不难发现，当前加载的库为静态库
add_library (MathFunctions STATIC  ${DIR_LIB_SRCS})
add_library (MathFunctions_SO SHARED  ${DIR_LIB_SRCS})
set_target_properties(MathFunctions_SO PROPERTIES OUTPUT_NAME "MathFunctions")

# 指定 MathFunctions 库的安装路径
install (TARGETS MathFunctions DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
install (FILES MathFunctions.h DESTINATION ${CMAKE_INSTALL_PREFIX}/include)
