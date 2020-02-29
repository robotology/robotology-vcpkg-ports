include(vcpkg_common_functions)

if(NOT VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
    message(FATAL_ERROR "This port does not currently support architecture: ${VCPKG_TARGET_ARCHITECTURE}")
endif()

# Empty VCPKG_CMAKE_SYSTEM_NAME means Windows, see https://github.com/microsoft/vcpkg/blame/2019.07/docs/users/triplets.md#L31
if(VCPKG_CMAKE_SYSTEM_NAME) 
    message(FATAL_ERROR "This port does not currently support system: ${VCPKG_CMAKE_SYSTEM_NAME}, only Windows 64bit is supported.")
endif()

set(version 6.3.0)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/robotology/robotology-vcpkg-binary-ports/releases/download/storage/esdcan-${version}.zip"
    FILENAME "ensenso-${version}.zip"
    SHA512 8a98b00df1dbb5a675c1d4554d3a277844fbfd7ce60df1f8b1f72ba92200cce0dd9bb833de158be223f1bdb47322486c5bfe57d60ec84e1a6822133627ed8e84
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
file(INSTALL ${SOURCE_PATH}/esd_license.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/esdcan-binary RENAME copyright)

