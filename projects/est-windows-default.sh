#
#   est-windows-default.sh -- Build It Shell Script to build Embedthis Security Transport
#

export PATH="$(SDK)/Bin:$(VS)/VC/Bin:$(VS)/Common7/IDE:$(VS)/Common7/Tools:$(VS)/SDK/v3.5/bin:$(VS)/VC/VCPackages;$(PATH)"
export INCLUDE="$(INCLUDE);$(SDK)/Include:$(VS)/VC/INCLUDE"
export LIB="$(LIB);$(SDK)/Lib:$(VS)/VC/lib"

PRODUCT="est"
VERSION="0.1.0"
BUILD_NUMBER="0"
PROFILE="default"
ARCH="x86"
ARCH="`uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/'`"
OS="windows"
CONFIG="${OS}-${ARCH}-${PROFILE}"
CC="cl.exe"
LD="link.exe"
CFLAGS="-nologo -GR- -W3 -O2 -MD -w"
DFLAGS="-D_REENTRANT -D_MT"
IFLAGS="-I${CONFIG}/inc"
LDFLAGS="-nologo -nodefaultlib -incremental:no -machine:x86"
LIBPATHS="-libpath:${CONFIG}/bin"
LIBS="ws2_32.lib advapi32.lib user32.lib kernel32.lib oldnames.lib msvcrt.lib shell32.lib"

[ ! -x ${CONFIG}/inc ] && mkdir -p ${CONFIG}/inc ${CONFIG}/obj ${CONFIG}/lib ${CONFIG}/bin

[ ! -f ${CONFIG}/inc/bit.h ] && cp projects/est-${OS}-${PROFILE}-bit.h ${CONFIG}/inc/bit.h
[ ! -f ${CONFIG}/inc/bitos.h ] && cp ${SRC}/src/bitos.h ${CONFIG}/inc/bitos.h
if ! diff ${CONFIG}/inc/bit.h projects/est-${OS}-${PROFILE}-bit.h >/dev/null ; then
	cp projects/est-${OS}-${PROFILE}-bit.h ${CONFIG}/inc/bit.h
fi

rm -rf ${CONFIG}/inc/aes.h
cp -r src/aes.h ${CONFIG}/inc/aes.h

rm -rf ${CONFIG}/inc/arc4.h
cp -r src/arc4.h ${CONFIG}/inc/arc4.h

rm -rf ${CONFIG}/inc/base64.h
cp -r src/base64.h ${CONFIG}/inc/base64.h

rm -rf ${CONFIG}/inc/bignum.h
cp -r src/bignum.h ${CONFIG}/inc/bignum.h

rm -rf ${CONFIG}/inc/bitos.h
cp -r src/bitos.h ${CONFIG}/inc/bitos.h

rm -rf ${CONFIG}/inc/bn_mul.h
cp -r src/bn_mul.h ${CONFIG}/inc/bn_mul.h

rm -rf ${CONFIG}/inc/camellia.h
cp -r src/camellia.h ${CONFIG}/inc/camellia.h

rm -rf ${CONFIG}/inc/certs.h
cp -r src/certs.h ${CONFIG}/inc/certs.h

rm -rf ${CONFIG}/inc/debug.h
cp -r src/debug.h ${CONFIG}/inc/debug.h

rm -rf ${CONFIG}/inc/des.h
cp -r src/des.h ${CONFIG}/inc/des.h

rm -rf ${CONFIG}/inc/dhm.h
cp -r src/dhm.h ${CONFIG}/inc/dhm.h

rm -rf ${CONFIG}/inc/net.h
cp -r src/net.h ${CONFIG}/inc/net.h

rm -rf ${CONFIG}/inc/rsa.h
cp -r src/rsa.h ${CONFIG}/inc/rsa.h

rm -rf ${CONFIG}/inc/md5.h
cp -r src/md5.h ${CONFIG}/inc/md5.h

rm -rf ${CONFIG}/inc/sha1.h
cp -r src/sha1.h ${CONFIG}/inc/sha1.h

rm -rf ${CONFIG}/inc/x509.h
cp -r src/x509.h ${CONFIG}/inc/x509.h

rm -rf ${CONFIG}/inc/ssl.h
cp -r src/ssl.h ${CONFIG}/inc/ssl.h

rm -rf ${CONFIG}/inc/havege.h
cp -r src/havege.h ${CONFIG}/inc/havege.h

rm -rf ${CONFIG}/inc/md2.h
cp -r src/md2.h ${CONFIG}/inc/md2.h

rm -rf ${CONFIG}/inc/md4.h
cp -r src/md4.h ${CONFIG}/inc/md4.h

rm -rf ${CONFIG}/inc/padlock.h
cp -r src/padlock.h ${CONFIG}/inc/padlock.h

rm -rf ${CONFIG}/inc/sha2.h
cp -r src/sha2.h ${CONFIG}/inc/sha2.h

rm -rf ${CONFIG}/inc/sha4.h
cp -r src/sha4.h ${CONFIG}/inc/sha4.h

rm -rf ${CONFIG}/inc/timing.h
cp -r src/timing.h ${CONFIG}/inc/timing.h

rm -rf ${CONFIG}/inc/xtea.h
cp -r src/xtea.h ${CONFIG}/inc/xtea.h

rm -rf ${CONFIG}/inc/est.h
cp -r src/est.h ${CONFIG}/inc/est.h

rm -rf ${CONFIG}/inc/openssl.h
cp -r src/openssl.h ${CONFIG}/inc/openssl.h

"${CC}" -c -Fo${CONFIG}/obj/aes.obj -Fd${CONFIG}/obj/aes.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/aes.c

"${CC}" -c -Fo${CONFIG}/obj/arc4.obj -Fd${CONFIG}/obj/arc4.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/arc4.c

"${CC}" -c -Fo${CONFIG}/obj/base64.obj -Fd${CONFIG}/obj/base64.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/base64.c

"${CC}" -c -Fo${CONFIG}/obj/bignum.obj -Fd${CONFIG}/obj/bignum.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/bignum.c

"${CC}" -c -Fo${CONFIG}/obj/camellia.obj -Fd${CONFIG}/obj/camellia.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/camellia.c

"${CC}" -c -Fo${CONFIG}/obj/certs.obj -Fd${CONFIG}/obj/certs.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/certs.c

"${CC}" -c -Fo${CONFIG}/obj/debug.obj -Fd${CONFIG}/obj/debug.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/debug.c

"${CC}" -c -Fo${CONFIG}/obj/des.obj -Fd${CONFIG}/obj/des.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/des.c

"${CC}" -c -Fo${CONFIG}/obj/dhm.obj -Fd${CONFIG}/obj/dhm.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/dhm.c

"${CC}" -c -Fo${CONFIG}/obj/havege.obj -Fd${CONFIG}/obj/havege.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/havege.c

"${CC}" -c -Fo${CONFIG}/obj/md2.obj -Fd${CONFIG}/obj/md2.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/md2.c

"${CC}" -c -Fo${CONFIG}/obj/md4.obj -Fd${CONFIG}/obj/md4.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/md4.c

"${CC}" -c -Fo${CONFIG}/obj/md5.obj -Fd${CONFIG}/obj/md5.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/md5.c

"${CC}" -c -Fo${CONFIG}/obj/net.obj -Fd${CONFIG}/obj/net.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/net.c

"${CC}" -c -Fo${CONFIG}/obj/padlock.obj -Fd${CONFIG}/obj/padlock.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/padlock.c

"${CC}" -c -Fo${CONFIG}/obj/rsa.obj -Fd${CONFIG}/obj/rsa.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/rsa.c

"${CC}" -c -Fo${CONFIG}/obj/sha1.obj -Fd${CONFIG}/obj/sha1.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/sha1.c

"${CC}" -c -Fo${CONFIG}/obj/sha2.obj -Fd${CONFIG}/obj/sha2.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/sha2.c

"${CC}" -c -Fo${CONFIG}/obj/sha4.obj -Fd${CONFIG}/obj/sha4.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/sha4.c

"${CC}" -c -Fo${CONFIG}/obj/ssl_cli.obj -Fd${CONFIG}/obj/ssl_cli.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/ssl_cli.c

"${CC}" -c -Fo${CONFIG}/obj/ssl_srv.obj -Fd${CONFIG}/obj/ssl_srv.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/ssl_srv.c

"${CC}" -c -Fo${CONFIG}/obj/ssl_tls.obj -Fd${CONFIG}/obj/ssl_tls.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/ssl_tls.c

"${CC}" -c -Fo${CONFIG}/obj/timing.obj -Fd${CONFIG}/obj/timing.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/timing.c

"${CC}" -c -Fo${CONFIG}/obj/x509parse.obj -Fd${CONFIG}/obj/x509parse.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/x509parse.c

"${CC}" -c -Fo${CONFIG}/obj/xtea.obj -Fd${CONFIG}/obj/xtea.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/xtea.c

"${LD}" -dll -out:${CONFIG}/bin/libest.dll -entry:_DllMainCRTStartup@12 ${LDFLAGS} ${LIBPATHS} ${CONFIG}/obj/aes.obj ${CONFIG}/obj/arc4.obj ${CONFIG}/obj/base64.obj ${CONFIG}/obj/bignum.obj ${CONFIG}/obj/camellia.obj ${CONFIG}/obj/certs.obj ${CONFIG}/obj/debug.obj ${CONFIG}/obj/des.obj ${CONFIG}/obj/dhm.obj ${CONFIG}/obj/havege.obj ${CONFIG}/obj/md2.obj ${CONFIG}/obj/md4.obj ${CONFIG}/obj/md5.obj ${CONFIG}/obj/net.obj ${CONFIG}/obj/padlock.obj ${CONFIG}/obj/rsa.obj ${CONFIG}/obj/sha1.obj ${CONFIG}/obj/sha2.obj ${CONFIG}/obj/sha4.obj ${CONFIG}/obj/ssl_cli.obj ${CONFIG}/obj/ssl_srv.obj ${CONFIG}/obj/ssl_tls.obj ${CONFIG}/obj/timing.obj ${CONFIG}/obj/x509parse.obj ${CONFIG}/obj/xtea.obj ${LIBS}

#  Omit build script undefined
