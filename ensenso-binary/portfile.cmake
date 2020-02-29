include(vcpkg_common_functions)

if(NOT VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
    message(FATAL_ERROR "This port does not currently support architecture: ${VCPKG_TARGET_ARCHITECTURE}")
endif()

# Empty VCPKG_CMAKE_SYSTEM_NAME means Windows, see https://github.com/microsoft/vcpkg/blame/2019.07/docs/users/triplets.md#L31
if(VCPKG_CMAKE_SYSTEM_NAME) 
    message(FATAL_ERROR "This port does not currently support system: ${VCPKG_CMAKE_SYSTEM_NAME}, only Windows 64bit is supported.")
endif()

set(version 2.3.1174)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/robotology/robotology-vcpkg-binary-ports/releases/download/storage/ensenso-${version}.zip"
    FILENAME "ensenso-${version}.zip"
    SHA512 f72d75b2edc170a43b43d90d040fd5cada0d8329fb4685c7cb48166ef48897458e459deca8ebabed833912964298090c517cfdcfe7029498415e3f31873f7e61
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE} 
)

# Just install the content directly 
file(INSTALL ${SOURCE_PATH}/include DESTINATION ${CURRENT_PACKAGES_DIR})
file(INSTALL ${SOURCE_PATH}/lib DESTINATION ${CURRENT_PACKAGES_DIR})
file(INSTALL ${SOURCE_PATH}/lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/Eula.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/ensenso-binary RENAME copyright)

