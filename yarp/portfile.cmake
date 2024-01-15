vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO robotology/yarp
    REF "v${VERSION}"
    SHA512 846eab76f9518928e314003ce8e17439c903dfd3126fe62c41832b27f948c3b345dce5fede91dedb19f8ed146c27001fbf9a7472d334e05db165987e9197c204
    HEAD_REF master
    PATCHES 3069.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        "gui-tools" YARP_COMPILE_GUIS
        "fake-devices" YARP_COMPILE_ALL_FAKE_DEVICES
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        # We always compile all the executable to ensure that idl_tools required tools are available
        # Then, depending on the features enabled, we removed not usd tools
        -DYARP_COMPILE_EXECUTABLES:BOOL=ON
        # Plugins by default are installed in lib/yarp,
        # but vcpkg prefers all dynamics libraries to be installed under bin
        -DYARP_DYNAMIC_PLUGINS_INSTALL_DIR="bin/yarp"
        -DYARP_COMPILE_libYARP_math:BOOL=ON
        -DYARP_COMPILE_CARRIER_PLUGINS:BOOL=ON
        -DENABLE_yarpcar_bayer:BOOL=ON
        -DENABLE_yarpcar_tcpros:BOOL=ON
        -DENABLE_yarpcar_xmlrpc:BOOL=ON
        -DENABLE_yarpcar_priority:BOOL=ON
        -DENABLE_yarpcar_bayer:BOOL=ON
        -DENABLE_yarpcar_mjpeg:BOOL=ON
        -DENABLE_yarpcar_portmonitor:BOOL=ON
        -DENABLE_yarppm_bottle_compression_zlib:BOOL=ON
        -DENABLE_yarppm_depthimage_compression_zlib:BOOL=ON
        -DENABLE_yarppm_image_compression_ffmpeg:BOOL=ON
        -DENABLE_yarppm_depthimage_to_mono:BOOL=ON
        -DENABLE_yarppm_depthimage_to_rgb:BOOL=ON
        -DYARP_COMPILE_DEVICE_PLUGINS:BOOL=ON
        -DENABLE_yarpcar_human:BOOL=ON
        -DENABLE_yarpcar_rossrv:BOOL=ON
        -DENABLE_yarpmod_serialport:BOOL=OFF
        -DENABLE_yarpmod_AudioPlayerWrapper:BOOL=OFF
        -DENABLE_yarpmod_AudioRecorderWrapper:BOOL=OFF
        -DENABLE_yarpmod_portaudio:BOOL=OFF
        -DENABLE_yarpmod_portaudioPlayer:BOOL=OFF
        -DENABLE_yarpmod_portaudioRecorder:BOOL=OFF
        -DENABLE_yarpmod_opencv_grabber:BOOL=ON
)

vcpkg_cmake_install(ADD_BIN_TO_PATH)

set(YARP_CMAKE_PACKAGES)
list(APPEND YARP_CMAKE_PACKAGES YARP_priv_tinyxml)
list(APPEND YARP_CMAKE_PACKAGES YARP_priv_xmlrpcpp)
list(APPEND YARP_CMAKE_PACKAGES YARP_priv_hmac)
list(APPEND YARP_CMAKE_PACKAGES YARP_conf)
list(APPEND YARP_CMAKE_PACKAGES YARP_sig)
list(APPEND YARP_CMAKE_PACKAGES YARP_gsl)
list(APPEND YARP_CMAKE_PACKAGES YARP_eigen)
list(APPEND YARP_CMAKE_PACKAGES YARP_math)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_native)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_std_msgs)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_actionlib_msgs)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_diagnostic_msgs)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_geometry_msgs)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_nav_msgs)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_sensor_msgs)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_shape_msgs)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_stereo_msgs)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_trajectory_msgs)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_visualization_msgs)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_tf)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg_tf2_msgs)
list(APPEND YARP_CMAKE_PACKAGES YARP_rosmsg)
list(APPEND YARP_CMAKE_PACKAGES YARP_dev)
list(APPEND YARP_CMAKE_PACKAGES YARP_robotinterface)
list(APPEND YARP_CMAKE_PACKAGES YARP_companion)
list(APPEND YARP_CMAKE_PACKAGES YARP_name)
list(APPEND YARP_CMAKE_PACKAGES YARP_serversql)
list(APPEND YARP_CMAKE_PACKAGES YARP_run)
list(APPEND YARP_CMAKE_PACKAGES YARP_logger)
list(APPEND YARP_CMAKE_PACKAGES YARP_dataplayer)
list(APPEND YARP_CMAKE_PACKAGES YARP_wire_rep_utils)
list(APPEND YARP_CMAKE_PACKAGES YARP_yarpcar)
list(APPEND YARP_CMAKE_PACKAGES YARP_yarppm)
list(APPEND YARP_CMAKE_PACKAGES YARP_yarpmod)
list(APPEND YARP_CMAKE_PACKAGES YARP_os)
list(APPEND YARP_CMAKE_PACKAGES YARP)
list(APPEND YARP_CMAKE_PACKAGES YARP_idl_tools)

if("executables" IN_LIST FEATURES)
endif()

foreach(cmakePackage ${YARP_CMAKE_PACKAGES})
    vcpkg_cmake_config_fixup(PACKAGE_NAME ${cmakePackage}
                             CONFIG_PATH lib/cmake/${cmakePackage}
                             DO_NOT_DELETE_PARENT_CONFIG_PATH)
endforeach()

# Change location of CMake config file (moved by vcpkg_cmake_config_fixup) 
# also in related variable YARP_CMAKECONFIG_DIR
file(READ "${CURRENT_PACKAGES_DIR}/share/yarp/YARPConfig.cmake" contents)
string(REPLACE "\${PACKAGE_PREFIX_DIR}/lib/cmake" "\${PACKAGE_PREFIX_DIR}/share" contents "${contents}")
file(WRITE "${CURRENT_PACKAGES_DIR}/share/yarp/YARPConfig.cmake" "${contents}")



vcpkg_copy_pdbs()


set(TOOL_NAMES_LIST)
list(APPEND TOOL_NAMES_LIST yarpidl_thrift)
list(APPEND TOOL_NAMES_LIST yarpidl_rosmsg)
list(APPEND TOOL_NAMES_LIST yarpros)

set(TOOL_NAMES_TO_DELETE_LIST)

if("command-line-tools" IN_LIST FEATURES)
  list(APPEND TOOL_NAMES_LIST yarpserver)
  list(APPEND TOOL_NAMES_LIST yarp)
  list(APPEND TOOL_NAMES_LIST yarp-config)
  list(APPEND TOOL_NAMES_LIST yarprun)
  list(APPEND TOOL_NAMES_LIST yarphear)
  list(APPEND TOOL_NAMES_LIST yarpdev)
  list(APPEND TOOL_NAMES_LIST yarprobotinterface)
  list(APPEND TOOL_NAMES_LIST yarpconnectionsinfo)
  list(APPEND TOOL_NAMES_LIST yarpmanager-console)
  list(APPEND TOOL_NAMES_LIST yarpdatadumper)
else()
  list(APPEND TOOL_NAMES_TO_DELETE_LIST yarpserver)
  list(APPEND TOOL_NAMES_TO_DELETE_LIST yarp)
  list(APPEND TOOL_NAMES_TO_DELETE_LIST yarp-config)
  list(APPEND TOOL_NAMES_TO_DELETE_LIST yarprun)
  list(APPEND TOOL_NAMES_TO_DELETE_LIST yarphear)
  list(APPEND TOOL_NAMES_TO_DELETE_LIST yarpdev)
  list(APPEND TOOL_NAMES_TO_DELETE_LIST yarprobotinterface)
  list(APPEND TOOL_NAMES_TO_DELETE_LIST yarpconnectionsinfo)
  list(APPEND TOOL_NAMES_TO_DELETE_LIST yarpmanager-console)
  list(APPEND TOOL_NAMES_TO_DELETE_LIST yarpdatadumper)
endif()

if("gui-tools" IN_LIST FEATURES)
  list(APPEND TOOL_NAMES_LIST yarplogger-console)
  list(APPEND TOOL_NAMES_LIST yarpdataplayer-console)
  list(APPEND TOOL_NAMES_LIST yarpview)
  list(APPEND TOOL_NAMES_LIST yarpscope)
  list(APPEND TOOL_NAMES_LIST yarpmanager)
  list(APPEND TOOL_NAMES_LIST yarplogger)
  list(APPEND TOOL_NAMES_LIST yarpdataplayer)
  list(APPEND TOOL_NAMES_LIST yarpmotorgui)
  list(APPEND TOOL_NAMES_LIST yarpbatterygui)
  list(APPEND TOOL_NAMES_LIST yarpmobilebasegui)
  list(APPEND TOOL_NAMES_LIST yarplaserscannergui)
  list(APPEND TOOL_NAMES_LIST yarpviz)
  list(APPEND TOOL_NAMES_LIST yarpaudiocontrolgui)
  list(APPEND TOOL_NAMES_LIST yarpllmgui)
endif()

vcpkg_copy_tools(
  TOOL_NAMES ${TOOL_NAMES_LIST}
  AUTO_CLEAN
)

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/lib/cmake"
    "${CURRENT_PACKAGES_DIR}/debug/lib/cmake"
    "${CURRENT_PACKAGES_DIR}/debug/include"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
