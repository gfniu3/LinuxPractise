# CMake generated Testfile for 
# Source directory: /mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5
# Build directory: /mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/build-intermediate
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(test_run "Demo5" "5" "2")
set_tests_properties(test_run PROPERTIES  _BACKTRACE_TRIPLES "/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;70;add_test;/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;0;")
add_test(test_usage "Demo5")
set_tests_properties(test_usage PROPERTIES  PASS_REGULAR_EXPRESSION "Usage: .* base exponent" _BACKTRACE_TRIPLES "/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;73;add_test;/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;0;")
add_test(test_5_2 "Demo5" "5" "2")
set_tests_properties(test_5_2 PROPERTIES  PASS_REGULAR_EXPRESSION "is 25" _BACKTRACE_TRIPLES "/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;101;add_test;/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;107;do_test;/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;0;")
add_test(test_10_5 "Demo5" "10" "5")
set_tests_properties(test_10_5 PROPERTIES  PASS_REGULAR_EXPRESSION "is 100000" _BACKTRACE_TRIPLES "/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;101;add_test;/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;108;do_test;/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;0;")
add_test(test_2_10 "Demo5" "2" "10")
set_tests_properties(test_2_10 PROPERTIES  PASS_REGULAR_EXPRESSION "is 1024" _BACKTRACE_TRIPLES "/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;101;add_test;/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;109;do_test;/mnt/c/Users/gfniu3/Downloads/cmake-demo-master/cmake-Demo5/CMakeLists.txt;0;")
subdirs("math")
