
SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX11.0.sdk
#${SYSROOT}和$SYSROOT都行，如果要匹配比如${SYSROOT}.mm则用{}
FILE_NAME=test
HEADER_SEARCH_PATH=./StaticLibrary

function MToOOrExec {
  if [[ $2 == ".m" ]]; then
    clang -x objective-c \
    -target x86_64-apple-macos11.0 \
    -fobjc-arc \
    -isysroot ${SYSROOT} \
    -I${HEADER_SEARCH_PATH} \
    -c $1.m -o $1.o
  else
    clang -target x86_64-apple-macos11.0 \
    -fobjc-arc \
    -isysroot ${SYSROOT} \
    -L${HEADER_SEARCH_PATH} \
    -l$1 \
    ${FILE_NAME}.o -o ${FILE_NAME}
  fi
  return 0
}

echo "test.m -> test.o"

MToOOrExec ${FILE_NAME} ".m"

echo "pushd -> StaticLibrary"
#cd可以进入到一个目录不推荐使用，cd会修改目录栈上层，推荐使用 pushd，pushd是往目录栈中push一个目录。
pushd ${HEADER_SEARCH_PATH}

echo "HPExample.m -> HPExample.o"
MToOOrExec HPExample ".m"
echo "HPExample.o -> libHPExample.a"
#打包.o成静态库
ar -rc libHPExample.a HPExample.o
echo "popd -> StaticLibrary"
popd

echo "test.o -> test"
#链接
MToOOrExec HPExample ".o"

