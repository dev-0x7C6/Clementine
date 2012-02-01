# Change this file when releasing a new version.

# Version numbers.
set(CLEMENTINE_VERSION_MAJOR 0)
set(CLEMENTINE_VERSION_MINOR 7)
set(CLEMENTINE_VERSION_PATCH 3)

# This should be set to OFF in an svn tag
set(INCLUDE_SVN_REVISION OFF)

# The format for version numbers is:
# Display: $major.$minor[.$patch] [$prerelease] [r$svn]
# Deb:     $major.$minor[.$patch][~$prerelease][.r$svn]
# Rpm:     $major.$minor[.$patch][$prerelease][.r$svn]
# And the rpm version is used for mac and windows


set(CLEMENTINE_VERSION_DISPLAY "${CLEMENTINE_VERSION_MAJOR}.${CLEMENTINE_VERSION_MINOR}")
set(CLEMENTINE_VERSION_DEB "${CLEMENTINE_VERSION_MAJOR}.${CLEMENTINE_VERSION_MINOR}")
set(CLEMENTINE_VERSION_RPM "${CLEMENTINE_VERSION_MAJOR}.${CLEMENTINE_VERSION_MINOR}")

# Add patch
if(CLEMENTINE_VERSION_PATCH)
  set(CLEMENTINE_VERSION_DISPLAY "${CLEMENTINE_VERSION_DISPLAY}.${CLEMENTINE_VERSION_PATCH}")
  set(CLEMENTINE_VERSION_DEB "${CLEMENTINE_VERSION_DEB}.${CLEMENTINE_VERSION_PATCH}")
  set(CLEMENTINE_VERSION_RPM "${CLEMENTINE_VERSION_RPM}.${CLEMENTINE_VERSION_PATCH}")
endif(CLEMENTINE_VERSION_PATCH)

# Add prerelease
if(CLEMENTINE_VERSION_PRERELEASE)
  set(CLEMENTINE_VERSION_DISPLAY "${CLEMENTINE_VERSION_DISPLAY} ${CLEMENTINE_VERSION_PRERELEASE}")
  set(CLEMENTINE_VERSION_DEB "${CLEMENTINE_VERSION_DEB}~${CLEMENTINE_VERSION_PRERELEASE}")
  set(CLEMENTINE_VERSION_RPM "${CLEMENTINE_VERSION_RPM}${CLEMENTINE_VERSION_PRERELEASE}")
endif(CLEMENTINE_VERSION_PRERELEASE)

# Add svn revision
if(FORCE_SVN_REVISION)
  set(SVN_REVISION ${FORCE_SVN_REVISION})
else(FORCE_SVN_REVISION)
  include(FindSubversion)
  find_package(Subversion)

  if(Subversion_FOUND)
    execute_process(COMMAND ${Subversion_SVN_EXECUTABLE} info ${PROJECT_SOURCE_DIR}
        RESULT_VARIABLE SVN_INFO_RESULT
        OUTPUT_QUIET
        ERROR_QUIET)
    if(${SVN_INFO_RESULT} EQUAL 0)
      Subversion_WC_INFO(${PROJECT_SOURCE_DIR} clementine)
      set(SVN_REVISION ${clementine_WC_REVISION})
    endif(${SVN_INFO_RESULT} EQUAL 0)
  endif(Subversion_FOUND)
endif(FORCE_SVN_REVISION)

if(INCLUDE_SVN_REVISION AND SVN_REVISION)
  set(CLEMENTINE_VERSION_DISPLAY "${CLEMENTINE_VERSION_DISPLAY} r${SVN_REVISION}")
  set(CLEMENTINE_VERSION_DEB "${CLEMENTINE_VERSION_DEB}.r${SVN_REVISION}")
  set(CLEMENTINE_VERSION_RPM "${CLEMENTINE_VERSION_RPM}.r${SVN_REVISION}")
endif(INCLUDE_SVN_REVISION AND SVN_REVISION)
