# Umfpack lib usually requires linking to a blas library.
# It is up to the user of this module to find a BLAS and link to it.

if (UMFPACK_INCLUDES AND UMFPACK_LIBRARIES)
  set(UMFPACK_FIND_QUIETLY TRUE)
endif (UMFPACK_INCLUDES AND UMFPACK_LIBRARIES)

find_path(UMFPACK_INCLUDES
  NAMES
  umfpack.h
  PATHS
  $ENV{UMFPACKDIR}
  ${INCLUDE_INSTALL_DIR}
  PATH_SUFFIXES
  suitesparse
  ufsparse
)

find_library(UMFPACK_LIBRARIES
  NAMES
  libumfpack
  umfpack
  PATHS
  $ENV{UMFPACKDIR}
  ${LIB_INSTALL_DIR}
)

if(UMFPACK_LIBRARIES)

  if(NOT UMFPACK_LIBDIR)
    get_filename_component(UMFPACK_LIBDIR ${UMFPACK_LIBRARIES} PATH)
  endif(NOT UMFPACK_LIBDIR)

  find_library(COLAMD_LIBRARY
    libcolamd
    colamd
    PATHS
    ${UMFPACK_LIBDIR}
    $ENV{UMFPACKDIR}
    ${LIB_INSTALL_DIR}
  )
  if(COLAMD_LIBRARY)
    set(UMFPACK_LIBRARIES ${UMFPACK_LIBRARIES} ${COLAMD_LIBRARY})
  endif ()

  find_library(CCOLAMD_LIBRARY
    libccolamd
    ccolamd
    PATHS
    ${UMFPACK_LIBDIR}
    $ENV{UMFPACKDIR}
    ${LIB_INSTALL_DIR}
  )
  if(CCOLAMD_LIBRARY)
    set(UMFPACK_LIBRARIES ${UMFPACK_LIBRARIES} ${CCOLAMD_LIBRARY})
  endif ()

  find_library(AMD_LIBRARY
    libamd
    amd
    PATHS
    ${UMFPACK_LIBDIR}
    $ENV{UMFPACKDIR}
    ${LIB_INSTALL_DIR}
  )
  if(AMD_LIBRARY)
    set(UMFPACK_LIBRARIES ${UMFPACK_LIBRARIES} ${AMD_LIBRARY})
  endif ()

  find_library(CAMD_LIBRARY
    libcamd
    camd
    PATHS
    ${UMFPACK_LIBDIR}
    $ENV{UMFPACKDIR}
    ${LIB_INSTALL_DIR}
  )
  if(CAMD_LIBRARY)
    set(UMFPACK_LIBRARIES ${UMFPACK_LIBRARIES} ${CAMD_LIBRARY})
  endif ()

  find_library(SUITESPARSE_LIBRARY
    suitesparseconfig
    libsuitesparseconfig
    SuiteSparse
    libSuiteSparse
    PATHS
    ${UMFPACK_LIBDIR}
    $ENV{UMFPACKDIR}
    ${LIB_INSTALL_DIR}
  )
  if(SUITESPARSE_LIBRARY)
    set(UMFPACK_LIBRARIES ${UMFPACK_LIBRARIES} ${SUITESPARSE_LIBRARY})
  endif ()

  find_library(CHOLMOD_LIBRARY
    libcholmod
    cholmod
    PATHS
    $ENV{UMFPACK_LIBDIR}
    $ENV{UMFPACKDIR}
    ${LIB_INSTALL_DIR}
  )
  if(CHOLMOD_LIBRARY)
    set(UMFPACK_LIBRARIES ${UMFPACK_LIBRARIES} ${CHOLMOD_LIBRARY})
  endif()

  find_library(METIS_LIBRARY
    libmetis
    metis
    PATHS
    $ENV{UMFPACK_LIBDIR}
    $ENV{UMFPACKDIR}
    ${LIB_INSTALL_DIR}
  )
  if(METIS_LIBRARY)
    set(UMFPACK_LIBRARIES ${UMFPACK_LIBRARIES} ${METIS_LIBRARY})
  endif()

endif(UMFPACK_LIBRARIES)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(UMFPACK DEFAULT_MSG
                                  UMFPACK_INCLUDES UMFPACK_LIBRARIES)

mark_as_advanced(UMFPACK_INCLUDES UMFPACK_LIBRARIES AMD_LIBRARY COLAMD_LIBRARY CHOLMOD_LIBRARY SUITESPARSE_LIBRARY)
