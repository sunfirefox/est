#
#   est-macosx-default.sh -- Build It Shell Script to build Embedthis Security Transport
#

PRODUCT="est"
VERSION="0.1.0"
BUILD_NUMBER="0"
PROFILE="default"
ARCH="x64"
ARCH="`uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/'`"
OS="macosx"
CONFIG="${OS}-${ARCH}-${PROFILE}"
CC="/usr/bin/clang"
LD="/usr/bin/ld"
CFLAGS="-O3   -w"
DFLAGS=""
IFLAGS="-I${CONFIG}/inc"
LDFLAGS="-Wl,-rpath,@executable_path/ -Wl,-rpath,@loader_path/"
LIBPATHS="-L${CONFIG}/bin"
LIBS="-lpthread -lm -ldl"

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

${DFLAGS}${CC} -c -o ${CONFIG}/obj/aes.o -arch x86_64 -O3 -I${CONFIG}/inc src/aes.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/arc4.o -arch x86_64 -O3 -I${CONFIG}/inc src/arc4.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/base64.o -arch x86_64 -O3 -I${CONFIG}/inc src/base64.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/bignum.o -arch x86_64 -O3 -I${CONFIG}/inc src/bignum.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/camellia.o -arch x86_64 -O3 -I${CONFIG}/inc src/camellia.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/certs.o -arch x86_64 -O3 -I${CONFIG}/inc src/certs.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/debug.o -arch x86_64 -O3 -I${CONFIG}/inc src/debug.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/des.o -arch x86_64 -O3 -I${CONFIG}/inc src/des.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/dhm.o -arch x86_64 -O3 -I${CONFIG}/inc src/dhm.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/havege.o -arch x86_64 -O3 -I${CONFIG}/inc src/havege.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/md2.o -arch x86_64 -O3 -I${CONFIG}/inc src/md2.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/md4.o -arch x86_64 -O3 -I${CONFIG}/inc src/md4.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/md5.o -arch x86_64 -O3 -I${CONFIG}/inc src/md5.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/net.o -arch x86_64 -O3 -I${CONFIG}/inc src/net.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/padlock.o -arch x86_64 -O3 -I${CONFIG}/inc src/padlock.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/rsa.o -arch x86_64 -O3 -I${CONFIG}/inc src/rsa.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/sha1.o -arch x86_64 -O3 -I${CONFIG}/inc src/sha1.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/sha2.o -arch x86_64 -O3 -I${CONFIG}/inc src/sha2.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/sha4.o -arch x86_64 -O3 -I${CONFIG}/inc src/sha4.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/ssl_cli.o -arch x86_64 -O3 -I${CONFIG}/inc src/ssl_cli.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/ssl_srv.o -arch x86_64 -O3 -I${CONFIG}/inc src/ssl_srv.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/ssl_tls.o -arch x86_64 -O3 -I${CONFIG}/inc src/ssl_tls.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/timing.o -arch x86_64 -O3 -I${CONFIG}/inc src/timing.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/x509parse.o -arch x86_64 -O3 -I${CONFIG}/inc src/x509parse.c

${DFLAGS}${CC} -c -o ${CONFIG}/obj/xtea.o -arch x86_64 -O3 -I${CONFIG}/inc src/xtea.c

${DFLAGS}${CC} -dynamiclib -o ${CONFIG}/bin/libest.dylib -arch x86_64 ${LDFLAGS} -compatibility_version 0.1.0 -current_version 0.1.0 ${LIBPATHS} -install_name @rpath/libest.dylib ${CONFIG}/obj/aes.o ${CONFIG}/obj/arc4.o ${CONFIG}/obj/base64.o ${CONFIG}/obj/bignum.o ${CONFIG}/obj/camellia.o ${CONFIG}/obj/certs.o ${CONFIG}/obj/debug.o ${CONFIG}/obj/des.o ${CONFIG}/obj/dhm.o ${CONFIG}/obj/havege.o ${CONFIG}/obj/md2.o ${CONFIG}/obj/md4.o ${CONFIG}/obj/md5.o ${CONFIG}/obj/net.o ${CONFIG}/obj/padlock.o ${CONFIG}/obj/rsa.o ${CONFIG}/obj/sha1.o ${CONFIG}/obj/sha2.o ${CONFIG}/obj/sha4.o ${CONFIG}/obj/ssl_cli.o ${CONFIG}/obj/ssl_srv.o ${CONFIG}/obj/ssl_tls.o ${CONFIG}/obj/timing.o ${CONFIG}/obj/x509parse.o ${CONFIG}/obj/xtea.o ${LIBS}

#  Omit build script undefined
