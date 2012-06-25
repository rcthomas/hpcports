
# This generates the shell snippet which exports the per-package
# environment variables, and also the module file.  Also generate
# the shell snippet sourced by configure and other targets that need
# dependency information.

PKG=$1
VER=$2
PREFIX=$3
TARGET=$4

GITHASH=`git rev-parse --short HEAD`

# File headers

echo "# This file auto-generated by \"make extract\" " > ${PKG}-${VER}.sh

echo '#%Module###<-magic cookie ####################################################
##' > ${PKG}.module
echo "##   ${PKG} " >> ${PKG}.module
echo '##   HPCPorts module file
##
##
# variables for Tcl script use only' >> ${PKG}.module
echo "set     version  ${VER}" >> ${PKG}.module
echo "set     prefix   ${PREFIX}/${PKG}-${VER}" >> ${PKG}.module
echo "" >> ${PKG}.module
echo "module-whatis \"Loads the HPCPorts version of ${PKG}\"" >> ${PKG}.module
echo "" >> ${PKG}.module

# Process package vars:

process_var () {
	var=$1
	shift
	shift
	vals=$@
	if [ ! "x${vals}" = "x" ]; then
		if [ "x${var}" = "xpath" ]; then
			for val in ${vals}; do
				echo "export PATH=${PREFIX}/${PKG}-${VER}/${val}:\$PATH" >> ${PKG}-${VER}.sh
				echo "prepend-path PATH ${PREFIX}/${PKG}-${VER}/${val}" >> ${PKG}.module
			done
		elif [ "x${var}" = "xman" ]; then
			for val in ${vals}; do
				echo "export MANPATH=${PREFIX}/${PKG}-${VER}/${val}:\$MANPATH" >> ${PKG}-${VER}.sh
				echo "prepend-path MANPATH ${PREFIX}/${PKG}-${VER}/${val}" >> ${PKG}.module
			done
		elif [ "x${var}" = "xheader" ]; then
			OUT=""
			for val in ${vals}; do
				OUT="${OUT}-I${PREFIX}/${PKG}-${VER}/${val} "
			done
			echo "export ${PKG}_CPPFLAGS=\"${OUT}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_CPPFLAGS \"${OUT}\"" >> ${PKG}.module
		elif [ "x${var}" = "xdata" ]; then
			echo "export ${PKG}_DATA=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_DATA \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xld" ]; then
			OUT=""
			LD=""
			for val in ${vals}; do
				OUT="${OUT}${PREFIX}/${PKG}-${VER}/${val}:"
				LD="${LD}-L${PREFIX}/${PKG}-${VER}/${val} "
				echo "prepend-path LD_LIBRARY_PATH \"${PREFIX}/${PKG}-${VER}/${val}\"" >> ${PKG}.module
			done
			echo "export LD_LIBRARY_PATH=${OUT}\$LD_LIBRARY_PATH" >> ${PKG}-${VER}.sh
			echo "export ${PKG}_LDFLAGS=\"${LD}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LDFLAGS \"${LD}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_CC" ]; then
			echo "export ${PKG}_LIBS_CC=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_CC \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_CXX" ]; then
			echo "export ${PKG}_LIBS_CXX=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_CXX \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_F77" ]; then
			echo "export ${PKG}_LIBS_F77=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_F77 \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_FC" ]; then
			echo "export ${PKG}_LIBS_FC=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_FC \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_MPICC" ]; then
			echo "export ${PKG}_LIBS_MPICC=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_MPICC \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_MPICXX" ]; then
			echo "export ${PKG}_LIBS_MPICXX=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_MPICXX \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_MPIF77" ]; then
			echo "export ${PKG}_LIBS_MPIF77=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_MPIF77 \"${vals}\"" >> ${PKG}.module
		elif [ "x${var}" = "xlib_MPIFC" ]; then
			echo "export ${PKG}_LIBS_MPIFC=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_LIBS_MPIFC \"${vals}\"" >> ${PKG}.module
		else
			echo "export ${PKG}_${var}=\"${vals}\"" >> ${PKG}-${VER}.sh
			echo "setenv ${PKG}_${var} \"${vals}\"" >> ${PKG}.module
		fi
	fi
	return 0
}

echo "export ${PKG}_PREFIX=\"${PREFIX}/${PKG}-${VER}\"" >> ${PKG}-${VER}.sh
echo "setenv ${PKG}_PREFIX \"${PREFIX}/${PKG}-${VER}\"" >> ${PKG}.module
echo "export ${PKG}_VERSION=\"${VER}\"" >> ${PKG}-${VER}.sh
echo "setenv ${PKG}_VERSION \"${VER}\"" >> ${PKG}.module

cat ../vars | \
while read line; do
	process_var ${line}
done

echo "" >> ${PKG}.module

if [ ${PKG} = "hpcp" ]; then
	cat base.module >> ${PKG}.module
	echo "" >> ${PKG}.module
fi


# module file boiler-plate

echo "proc ModulesHelp { } {" >> ${PKG}.module
echo "  global version" >> ${PKG}.module
echo "  puts stderr \"\\\t    ${PKG} - Version \$version\\\n\"" >> ${PKG}.module
echo "  puts stderr \"\\\t This module file was auto-generated for the ${PKG}\"" >> ${PKG}.module
echo "  puts stderr \"\\\t package as part of the HPCPorts installation system.\"" >> ${PKG}.module
echo "  puts stderr \"\\\t In general, this module may modify the PATH,\"" >> ${PKG}.module
echo "  puts stderr \"\\\t LD_LIBRARY_PATH, and MANPATH environment variables,\"" >> ${PKG}.module
echo "  puts stderr \"\\\t as well as setting any variables needed for compiling\"" >> ${PKG}.module
echo "  puts stderr \"\\\t and linking against libraries in this package.\"" >> ${PKG}.module
echo "  puts stderr \"\"" >> ${PKG}.module
echo "}" >> ${PKG}.module
echo "" >> ${PKG}.module
echo "conflict ${PKG}" >> ${PKG}.module
echo "" >> ${PKG}.module

# Handle dependencies

echo "# This file auto-generated by \"make extract\" " > dep_env.sh

deps=`head -n 1 ../deps`

for dep in ${deps}; do
	if [ -e ../../overrides_${TARGET}/${dep} ]; then
		echo "if [ module-info mode load ] {" >> ${PKG}.module
		echo "	if [ is-loaded ${dep} ] {" >> ${PKG}.module
		echo "	} else {" >> ${PKG}.module
		echo "	  module load ${dep}" >> ${PKG}.module
		echo "	}" >> ${PKG}.module
		echo "}" >> ${PKG}.module
		echo "" >> ${PKG}.module
	else
		# FIXME!!!  This does not handle generated versions, like datestamp
		depver=${GITHASH}
		if [ -e ../../${dep}/version ]; then
			depver=`head -n 1 ../../${dep}/version`
		fi
		echo "source ${PREFIX}/env/${dep}-${depver}.sh" >> dep_env.sh
		echo "if [ module-info mode load ] {" >> ${PKG}.module
		echo "	if [ is-loaded ${dep} ] {" >> ${PKG}.module
		echo "	} else {" >> ${PKG}.module
		echo "	  module load ${dep}/${depver}-hpcp" >> ${PKG}.module
		echo "	}" >> ${PKG}.module
		echo "}" >> ${PKG}.module
		echo "" >> ${PKG}.module
	fi
done

if [ ${PKG} != "hpcp" ]; then
	echo "if [ module-info mode load ] {" >> ${PKG}.module
	echo "	if [ is-loaded hpcp ] {" >> ${PKG}.module
	echo "	} else {" >> ${PKG}.module
	echo "	  module load hpcp/${GITHASH}-hpcp" >> ${PKG}.module
	echo "	}" >> ${PKG}.module
	echo "}" >> ${PKG}.module
	echo "" >> ${PKG}.module
fi

echo "" >> ${PKG}.module

# module file version

echo '#%Module###################################################################
####' > ${PKG}.version
echo "## version file for ${PKG}" >> ${PKG}.version
echo '##' >> ${PKG}.version
echo "set ModulesVersion      \"${VER}-hpcp\"" >> ${PKG}.version

