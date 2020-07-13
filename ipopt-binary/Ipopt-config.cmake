# This file exports the Ipopt_LIBRARIES and Ipopt_INCLUDE_DIR variables to be compatible
# with the Ipopt built by https://github.com/chrisdembia/coin/commits/ipopt_external_mumps
# that is the structure assumed by Casadi in https://github.com/casadi/casadi/blob/3.5.1/cmake/FindIPOPT.cmake#L1

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../" ABSOLUTE)

# The definition of these variables have been extracted by running YCM's FindIPOPT 
# see https://github.com/robotology/ycm/blob/v0.11.1/find-modules/FindIPOPT.cmake
# if the files included in the port changes, it will be necessary to change them
set(Ipopt_INCLUDE_DIR "${PACKAGE_PREFIX_DIR}/include/coin")
set(Ipopt_LIBRARIES  "optimized;${PACKAGE_PREFIX_DIR}/lib/libipopt.lib;debug;${PACKAGE_PREFIX_DIR}/debug/lib/libipoptD.lib;${PACKAGE_PREFIX_DIR}/lib/ifconsol.lib;optimized;${PACKAGE_PREFIX_DIR}/lib/libifcoremd.lib;debug;${PACKAGE_PREFIX_DIR}/debug/lib/libifcoremdd.lib;${PACKAGE_PREFIX_DIR}/lib/libifportmd.lib;optimized;${PACKAGE_PREFIX_DIR}/lib/libmmd.lib;debug;${PACKAGE_PREFIX_DIR}/debug/lib/libmmdd.lib;${PACKAGE_PREFIX_DIR}/lib/libirc.lib;${PACKAGE_PREFIX_DIR}/lib/svml_dispmd.lib")

# The Casadi FindIPOPT (as of Casadi 3.5.1)  is actually malformed, and so we define a few variables to make it work correctly
set(IPOPT_FOUND ON)
set(IPOPT_INCLUDE_DIRS ${Ipopt_INCLUDE_DIR})
set(IPOPT_LIBRARY_DIRS "${PACKAGE_PREFIX_DIR}/lib")