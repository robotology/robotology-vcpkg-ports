vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO robotology/ycm
    REF "v${VERSION}"
    SHA512 26cea86ed954bb600ac81d221d25d511e34700db0418c0c4c3ed62469a8768a01df8b19ca7f4ad5c7dc5f477996299907f2f59225c280ce09cb06df6853e42e0
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(
    PACKAGE_NAME YCM
    CONFIG_PATH share/cmake/YCM)


file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

# Allow empty include directory
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
