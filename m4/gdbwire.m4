dnl Add a new --enable-NAME option to the configure script.
dnl
dnl The first parameter will be the name of the option to add.
dnl For instance, a call to
dnl   GDBWIRE_ARG_ENABLE([tests], [automated testing])
dnl would create the configure option
dnl     --enable-tests          Enable automated testing (default is no)
dnl
dnl The second parameter will be the help message provide when the
dnl user types configure --help.
dnl
dnl As the function name suggests, the default for this enable option is
dnl off (no). The cases supported by this macro are,
dnl default          no
dnl --enable-$1      yes
dnl --enable-$1=yes  yes
dnl --enable-$1=no   no
dnl
dnl The variable enable_$1 (ie. $enable_tests) will be set to yes or
dnl no depending on the users configuration options.
AC_DEFUN([GDBWIRE_ARG_ENABLE_DEFAULT_OFF], [
    AC_ARG_ENABLE([$1],
        AS_HELP_STRING([--enable-$1], [Enable $2 (default is no)]),
        [case "${enableval}" in
           yes) enable_$1=yes ;;
           no)  enable_$1=no ;;
           *) AC_MSG_ERROR([bad value ${enableval} for --enable-$1, to \
enable this option use "--enable-$1" or "--enable-$1=yes"]) ;;
         esac],
        [enable_$1=no])
])

dnl Add a new --with-NAME option to the configure script.
dnl
dnl The first parameter will be the name of the option to add.
dnl For instance, a call to
dnl   GDBWIRE_ARG_WITH([gtest])
dnl would create the configure option
dnl   --with-gtest            Use system installed gtest library
dnl
dnl The default value for this option is empty or set to the directory
dnl path provided by the user.
dnl default          unset
dnl --with-$1=dir    dir
dnl
dnl The variable with_$1 (ie. $with_gtest) will be set to the
dnl installation directory provided by the user or to unset if the
dnl option was not used by the user.
dnl
dnl The variable with_$1_help (ie. $with_gtest_help) will be set to 
dnl the installation directory provided by the user or to
dnl   search system libraries (default)
dnl if the option was not used by the user.
AC_DEFUN([GDBWIRE_ARG_WITH], [
    with_$1_help="search system libraries (default)"
    AC_ARG_WITH([$1],
        AS_HELP_STRING([--with-$1], [Use system installed $1 library]),
        [case "${withval}" in
            *)  if test -d "$withval"; then
                    with_$1=$withval
                else
                    AC_MSG_ERROR([\
The installation path (PREFIX) provided to --with-$1 must be a directory])
                fi ;;
         esac],
        [with_$1="unset"])
])
