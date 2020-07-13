include(vcpkg_common_functions)

if(NOT VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
    message(FATAL_ERROR "This port does not currently support architecture: ${VCPKG_TARGET_ARCHITECTURE}")
endif()

# Empty VCPKG_CMAKE_SYSTEM_NAME means Windows, see https://github.com/microsoft/vcpkg/blame/2019.07/docs/users/triplets.md#L31
if(VCPKG_CMAKE_SYSTEM_NAME) 
    message(FATAL_ERROR "This port does not currently support system: ${VCPKG_CMAKE_SYSTEM_NAME}, only Windows 64bit is supported.")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "http://www.icub.org/download/3rd-party/ipopt-3.12.7_msvc14_x86_amd64.zip"
    FILENAME "ipopt-3.12.7_msvc14_x86_amd64.zip"
    SHA512 26b42b8f6a75a815a3b3988b828a383965e291d4c204f053591b9e05e7925aa265d055a10d771fb505ea4ed98a1e9aa2521ce9d0375afe54ee75418a39dfafc1
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

# Just install the content directly 
file(INSTALL ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})
file(INSTALL ${SOURCE_PATH}/bin DESTINATION ${CURRENT_PACKAGES_DIR})
file(INSTALL ${SOURCE_PATH}/lib DESTINATION ${CURRENT_PACKAGES_DIR})
file(INSTALL ${SOURCE_PATH}/bin DESTINATION ${CURRENT_PACKAGES_DIR}/debug)
file(INSTALL ${SOURCE_PATH}/lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug)

# Install an Ipopt-config.cmake file for compatibility with Casadi
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/Ipopt-config.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/Ipopt)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/share/coin/doc/Ipopt/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/ipopt-binary RENAME copyright)

