vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO robotology/icub-main
    REF "v${VERSION}"
    SHA512 279e3cb7ce07dc9664cafd0aa9ac3273be606bd4888c77b482758de9a5733457d9a177581892470702f23917b5ee2ee45638d4061cbc418738d18e6ccde3e13c
    HEAD_REF master
    PATCHES 934.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        "dragonfly2" ENABLE_icubmod_dragonfly2
)

if("embobj" IN_LIST FEATURES)
    set(ICUB_MAIN_COMPILE_EMBOBJ ON)
else()
    set(ICUB_MAIN_COMPILE_EMBOBJ OFF)
endif()

if("can" IN_LIST FEATURES)
    set(ICUB_MAIN_COMPILE_CAN ON)
else()
    set(ICUB_MAIN_COMPILE_CAN OFF)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        # Plugins by default are installed in lib/iCub,
        # but vcpkg prefers all dynamics libraries to be installed under bin
        -DICUB_DYNAMIC_PLUGINS_INSTALL_DIR="bin/iCub"
        -DENABLE_icubmod_cartesiancontrollerserver:BOOL=ON
        -DENABLE_icubmod_cartesiancontrollerclient:BOOL=ON
        -DENABLE_icubmod_gazecontrollerclient:BOOL=ON
        -DENABLE_icubmod_skinWrapper:BOOL=ON
        -DENABLE_icubmod_sharedcan:BOOL=ON
        -DENABLE_icubmod_bcbBattery:BOOL=${ICUB_MAIN_COMPILE_EMBOBJ}
        -DENABLE_icubmod_canmotioncontrol:BOOL=${ICUB_MAIN_COMPILE_CAN}
        -DENABLE_icubmod_canBusAnalogSensor:BOOL=${ICUB_MAIN_COMPILE_CAN}
        -DENABLE_icubmod_canBusInertialMTB:BOOL=${ICUB_MAIN_COMPILE_CAN}
        -DENABLE_icubmod_canBusSkin:BOOL=${ICUB_MAIN_COMPILE_CAN}
        -DENABLE_icubmod_canBusFtSensor:BOOL=${ICUB_MAIN_COMPILE_CAN}
        -DENABLE_icubmod_canBusVirtualAnalogSensor:BOOL=${ICUB_MAIN_COMPILE_CAN}
        -DENABLE_icubmod_cfw2can:BOOL=OFF
        -DENABLE_icubmod_ecan:BOOL=OFF
        -DENABLE_icubmod_embObjBattery:BOOL=${ICUB_MAIN_COMPILE_EMBOBJ}
        -DENABLE_icubmod_embObjFTsensor:BOOL=${ICUB_MAIN_COMPILE_EMBOBJ}
        -DENABLE_icubmod_embObjMultipleFTsensors:BOOL=${ICUB_MAIN_COMPILE_EMBOBJ}
        -DENABLE_icubmod_embObjIMU:BOOL=${ICUB_MAIN_COMPILE_EMBOBJ}
        -DENABLE_icubmod_embObjInertials:BOOL=${ICUB_MAIN_COMPILE_EMBOBJ}
        -DENABLE_icubmod_embObjMais:BOOL=${ICUB_MAIN_COMPILE_EMBOBJ}
        -DENABLE_icubmod_embObjMotionControl:BOOL=${ICUB_MAIN_COMPILE_EMBOBJ}
        -DENABLE_icubmod_embObjSkin:BOOL=${ICUB_MAIN_COMPILE_EMBOBJ}
        -DENABLE_icubmod_parametricCalibrator:BOOL=${ICUB_MAIN_COMPILE_CAN}
        -DENABLE_icubmod_parametricCalibratorEth:BOOL=${ICUB_MAIN_COMPILE_EMBOBJ}
        -DENABLE_icubmod_embObjPOS:BOOL=${ICUB_MAIN_COMPILE_EMBOBJ}
        -DENABLE_icubmod_xsensmtx:BOOL=OFF
        -DENABLE_icubmod_socketcan:BOOL=OFF
        -DICUB_USE_icub_firmware_shared:BOOL=ON
        # For now we just disable modules and tools, if necessary the 
        # options can be exposed as vcpkg features, and properly processed via vcpkg_copy_tools
        -DICUBMAIN_COMPILE_CORE:BOOL=OFF
        -DICUBMAIN_COMPILE_MODULES:BOOL=OFF
        -DICUBMAIN_COMPILE_TOOLS:BOOL=OFF
        -DICUB_COMPILE_BINDINGS:BOOL=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(
    PACKAGE_NAME ICUB
    CONFIG_PATH lib/cmake/ICUB)
vcpkg_copy_pdbs()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
