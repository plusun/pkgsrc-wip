#!/bin/sh

set -e

# Variables to be adapted according to your settings.
# You don't need to prepare any source file for these
# directories, they will be cloned from Yang's GitHub

nr_threads=`getconf NPROCESSORS_CONF`

llvm_root=/public  # root dir for LLVM to store source and build
llvm_dir=$llvm_root/llvm/  # dir to hold llvm source
clang_dir=$llvm_root/clang/ #dir to hold clang source
crt_dir=$llvm_root/compiler-rt/ #dir to hold compiler-rt source
llvm_build_dir=$llvm_root/llvm-build/ # dir to build llvm

netbsd_root=/public
netbsd_src_dir=$netbsd_root/src/ #dir to hold NetBSD source
netbsd_external_tooldir=$netbsd_root/extern_tooldir/ # dir to hold external toolchain
netbsd_tooldir=$netbsd_root/tooldir/ # dir to hold toolchain
netbsd_destdir=$netbsd_root/destdir/
netbsd_releasedir=$netbsd_root/releasedir/
netbsd_external_objdir=$netbsd_root/extern_objdir/
netbsd_objdir=$netbsd_root/objdir/
netbsd_xsrc=$netbsd_root/xsrc/

# check dependencies
check_command() {
    cmd=$1
    echo -n $cmd": " && command -v $cmd || \
	    { echo "missing"; exit 1; }
}

check_command clang
check_command clang++
clang_path=`command -v clang || echo`
clangpp_path=`command -v clang++ || echo`
check_command git
check_command cmake

echo "Please make sure the following settting \
is correct and the directories do not exist:"
echo "  Number of Threads: "$nr_threads
echo "  LLVM part:"
echo "    llvm_dir="$llvm_dir
echo "    clang_dir="$clang_dir
echo "    compiler_rt_dir="$crt_dir
echo "    llvm_build_dir="$llvm_build_dir
echo "  NetBSD part:"
echo "    netbsd_src_dir="$netbsd_src_dir
echo "    netbsd_tooldir="$netbsd_tooldir
echo "    netbsd_destdir="$netbsd_destdir
echo "    netbsd_releasedir="$netbsd_releasedir
echo "    netbsd_objdir"=$netbsd_objdir
echo "    netbsd_xsrc"=$netbsd_xsrc
echo "    netbsd_external_tooldir"=$netbsd_external_tooldir
echo "    netbsd_external_objdir"=$netbsd_external_objdir

read -r -p "Is above setting correct? [y/N] " response
case "$response" in
    [yY])
        # do nothing, continue
        ;;
    *)
	exit 1
	;;
esac

echo "Start building..."

default_branch=gsoc2018
llvm_repo=https://github.com/plusun/llvm.git
clang_repo=https://github.com/plusun/clang.git
crt_repo=https://github.com/plusun/compiler-rt.git
netbsd_src_repo=https://github.com/plusun/src.git

clone_to() {
    repo=$1
    dir=$2
    nr_args=$#
    if [ "$nr_args" -eq "3" ]; then
	branch=$3
    else
	branch=$default_branch
    fi
    mkdir -p $dir
    (cd $dir && git clone $repo -b $branch .)
}

set -x

# building LLVM external toolchain
clone_to $llvm_repo $llvm_dir
clone_to $clang_repo $clang_dir
clone_to $crt_repo $crt_dir
ln -s $crt_dir $llvm_dir/projects/compiler-rt
ln -s $clang_dir $llvm_dir/tools/clang

mkdir -p $llvm_build_dir
(cd $llvm_build_dir && \
     cmake -DCMAKE_BUILD_TYPE=Release \
	   -DLLVM_BUILD_STATIC=ON \
	   -DCMAKE_C_COMPILER=$clang_path \
	   -DCMAKE_CXX_COMPILER=$clangpp_path \
	   -DCLANG_DEFAULT_CXX_STDLIB=libc++ \
	   -DCLANG_DEFAULT_RTLIB=compiler-rt \
	   -DSANITIZER_CXX_ABI=libc++ \
	   -DCMAKE_INSTALL_PREFIX=/usr/ \
	   -DLLVM_BUILD_DOCS=OFF \
	   -DLLVM_TARGETS_TO_BUILD=X86 \
	   -DLLVM_ENABLE_MODULES=OFF \
	   -DLIBCLANG_BUILD_STATIC=ON \
	   $llvm_dir && \
     make -j $nr_threads)

# building NetBSD source
## prepare source
clone_to $netbsd_src_repo $netbsd_src_dir
## create dirs
mkdir -p $netbsd_external_tooldir $netbsd_destdir $netbsd_releasedir $netbsd_objdir $netbsd_xsrc
## prepare external toolchain
(cd $netbsd_src_dir && \
     ./build.sh -T $netbsd_external_tooldir -D $netbsd_destdir -R $netbsd_releasedir \
		-O $netbsd_external_objdir -X $netbsd_xsrc -m amd64 -r \
		-V MKX11=no -V HAVE_LLVM=yes \
		-V MKLLVM=yes -V MKGCC=no -V MKCOMPAT=no -V MKATF=no \
		-V HOST_CC=$llvm_build_dir/bin/clang \
		-V HOST_CXX=$llvm_build_dir/bin/clang++ -j $nr_threads \
		tools)
### remove orginal clang
rm $netbsd_external_tooldir/bin/x86_64--netbsd-clang
### symlink for clang
ln -s $llvm_build_dir/bin/clang $netbsd_external_tooldir/bin/x86_64--netbsd-clang
### prepare tooldir
# cp -RH $netbsd_external_tooldir $netbsd_tooldir
# build source
(cd $netbsd_src_dir && \
     ./build.sh -T $netbsd_tooldir -D $netbsd_destdir -R $netbsd_releasedir \
		-O $netbsd_objdir -X $netbsd_xsrc -m amd64 -u \
		-V MKX11=no -V HAVE_LLVM=yes -V MKLLVM=no \
		-V MKGCC=no -V MKCXX=yes -V MKLIBCXX=yes -V MKCOMPAT=no -V MKATF=no \
		-V HOST_CC=$llvm_build_dir/bin/clang \
		-V HOST_CXX=$llvm_build_dir/bin/clang++ \
		-V EXTERNAL_TOOLCHAIN=$netbsd_external_tooldir \
		-j$nr_threads distribution)

# install external LLVM into destdir
(cd $llvm_build_dir && \
     make install DESTDIR=$netbsd_destdir)

# create cc and c++ for destdir
ln -s /usr/bin/clang $netbsd_destdir/usr/bin/cc
ln -s /usr/bin/clang++ $netbsd_destdir/usr/bin/c++

# generate tar ball for destdir
filename=NetBSD-distribution-clang7svn-libfuzzer-`date +%Y%m%d`
echo "Generating tar ball for destdir..."
tar cpf $filename.tar -C `dirname $netbsd_destdir` `basename $netbsd_destdir`
gzip $filename.tar
echo "Generated "$filename".tar.gz, you can uncompress it and chroot to destdir."
echo "Done."
