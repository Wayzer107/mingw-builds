
#
# The BSD 3-Clause License. http://www.opensource.org/licenses/BSD-3-Clause
#
# This file is part of 'MinGW-W64' project.
# Copyright (c) 2011,2012,2013 by niXman (i dotty nixman doggy gmail dotty com)
# Copyright (c) 2012,2013 by Alexpux (alexpux doggy gmail dotty com)
# All rights reserved.
#
# Project: MinGW-W64 ( http://sourceforge.net/projects/mingw-w64/ )
#
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met:
# - Redistributions of source code must retain the above copyright 
#     notice, this list of conditions and the following disclaimer.
# - Redistributions in binary form must reproduce the above copyright 
#     notice, this list of conditions and the following disclaimer in 
#     the documentation and/or other materials provided with the distribution.
# - Neither the name of the 'MinGW-W64' nor the names of its contributors may 
#     be used to endorse or promote products derived from this software 
#     without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR 
# A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY 
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS 
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE 
# USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# **************************************************************************

function python_deps_post {
	[[ ! -f $BUILDS_DIR/3rdparty-post.marker ]] && {

		local _toolchain_path=$(eval "echo \${${BUILD_ARCHITECTURE}_HOST_MINGW_PATH}")
		local _gcc_dll=( $(find $_toolchain_path/bin -type f \
							-name libstdc++*.dll -o \
							-name libgcc*.dll -o \
							-name libwinpthread*.dll) )
		[[ ${#_gcc_dll[@]} >0 ]] && {
			cp -f ${_gcc_dll[@]} $LIBS_DIR/bin/ >/dev/null 2>&1
		}

		rm -rf $LIBS_DIR/include
		rm -rf $LIBS_DIR/lib/pkgconfig
		find $LIBS_DIR/lib -maxdepth 1 -type f -name *.a -print0 | xargs -0 rm -f
		rm -rf $LIBS_DIR/man
		rm -rf $LIBS_DIR/share/man
		rm -rf $LIBS_DIR/share/info

		touch $BUILDS_DIR/3rdparty-post.marker
	}
}

python_deps_post

# **************************************************************************
