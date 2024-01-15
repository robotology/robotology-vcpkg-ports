vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO robotology/icub-firmware-shared
    REF "v${VERSION}"
    SHA512 f0b83521468d6b97c6ba47423f3a9774ff185fba2036208a1236a4efe4ab4e4d0110ab2bdd7123d36ff1953c2991ea75432c41421ef3e4f3e94fd2af6c7ad0ed
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(
    PACKAGE_NAME icub_firmware_shared
    CONFIG_PATH lib/cmake/icub_firmware_shared)
vcpkg_copy_pdbs()

#set(TOOL_NAMES_LIST)
#vcpkg_copy_tools(
#    TOOL_NAMES ${TOOL_NAMES_LIST}
#    AUTO_CLEAN
#)

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
#file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
