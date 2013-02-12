#
#   est-macosx-default.mk -- Makefile to build Embedthis Security Transport for macosx
#

PRODUCT         := est
VERSION         := 0.1.0
BUILD_NUMBER    := 0
PROFILE         := default
ARCH            := $(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/')
OS              := macosx
CC              := /usr/bin/clang
LD              := /usr/bin/ld
CONFIG          := $(OS)-$(ARCH)-$(PROFILE)
LBIN            := $(CONFIG)/bin

BIT_ROOT_PREFIX := /
BIT_BASE_PREFIX := $(BIT_ROOT_PREFIX)usr/lib
BIT_CFG_PREFIX  := $(BIT_ROOT_PREFIX)etc/$(PRODUCT)
BIT_PRD_PREFIX  := $(BIT_BASE_PREFIX)/$(PRODUCT)
BIT_VER_PREFIX  := $(BIT_PRD_PREFIX)/$(VERSION)
BIT_BIN_PREFIX  := $(BIT_VER_PREFIX)/bin
BIT_INC_PREFIX  := $(BIT_VER_PREFIX)/inc
BIT_LIB_PREFIX  := $(BIT_VER_PREFIX)/lib
BIT_LOG_PREFIX  := $(BIT_ROOT_PREFIX)var/log/$(PRODUCT)
BIT_SPL_PREFIX  := $(BIT_ROOT_PREFIX)var/spool/$(PRODUCT)
BIT_SRC_PREFIX  := $(BIT_ROOT_PREFIX)usr/src/$(PRODUCT)-$(VERSION)
BIT_WEB_PREFIX  := $(BIT_ROOT_PREFIX)var/www/$(PRODUCT)-default
BIT_MAN_PREFIX  := $(BIT_ROOT_PREFIX)usr/local/share/man
BIT_UBIN_PREFIX := $(BIT_ROOT_PREFIX)usr/local/bin

CFLAGS          += -w
DFLAGS          +=  $(patsubst %,-D%,$(filter BIT_%,$(MAKEFLAGS)))
IFLAGS          += -I$(CONFIG)/inc
LDFLAGS         += '-Wl,-rpath,@executable_path/' '-Wl,-rpath,@loader_path/'
LIBPATHS        += -L$(CONFIG)/bin
LIBS            += -lpthread -lm -ldl

DEBUG           := debug
CFLAGS-debug    := -g
DFLAGS-debug    := -DBIT_DEBUG
LDFLAGS-debug   := -g
DFLAGS-release  := 
CFLAGS-release  := -O2
LDFLAGS-release := 
CFLAGS          += $(CFLAGS-$(DEBUG))
DFLAGS          += $(DFLAGS-$(DEBUG))
LDFLAGS         += $(LDFLAGS-$(DEBUG))

unexport CDPATH

all compile: prep \
        $(CONFIG)/bin/libest.dylib

.PHONY: prep

prep:
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(BIT_PRD_PREFIX)" = "" ] ; then echo WARNING: BIT_PRD_PREFIX not set ; exit 255 ; fi
	@[ ! -x $(CONFIG)/bin ] && mkdir -p $(CONFIG)/bin; true
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc; true
	@[ ! -x $(CONFIG)/obj ] && mkdir -p $(CONFIG)/obj; true
	@[ ! -f $(CONFIG)/inc/bit.h ] && cp projects/est-macosx-default-bit.h $(CONFIG)/inc/bit.h ; true
	@[ ! -f $(CONFIG)/inc/bitos.h ] && cp src/bitos.h $(CONFIG)/inc/bitos.h ; true
	@if ! diff $(CONFIG)/inc/bit.h projects/est-macosx-default-bit.h >/dev/null ; then\
		echo cp projects/est-macosx-default-bit.h $(CONFIG)/inc/bit.h  ; \
		cp projects/est-macosx-default-bit.h $(CONFIG)/inc/bit.h  ; \
	fi; true
clean:
	rm -rf $(CONFIG)/bin/libest.dylib
	rm -rf $(CONFIG)/obj/aes.o
	rm -rf $(CONFIG)/obj/arc4.o
	rm -rf $(CONFIG)/obj/base64.o
	rm -rf $(CONFIG)/obj/bignum.o
	rm -rf $(CONFIG)/obj/camellia.o
	rm -rf $(CONFIG)/obj/certs.o
	rm -rf $(CONFIG)/obj/debug.o
	rm -rf $(CONFIG)/obj/des.o
	rm -rf $(CONFIG)/obj/dhm.o
	rm -rf $(CONFIG)/obj/havege.o
	rm -rf $(CONFIG)/obj/md2.o
	rm -rf $(CONFIG)/obj/md4.o
	rm -rf $(CONFIG)/obj/md5.o
	rm -rf $(CONFIG)/obj/net.o
	rm -rf $(CONFIG)/obj/padlock.o
	rm -rf $(CONFIG)/obj/rsa.o
	rm -rf $(CONFIG)/obj/sha1.o
	rm -rf $(CONFIG)/obj/sha2.o
	rm -rf $(CONFIG)/obj/sha4.o
	rm -rf $(CONFIG)/obj/ssl_cli.o
	rm -rf $(CONFIG)/obj/ssl_srv.o
	rm -rf $(CONFIG)/obj/ssl_tls.o
	rm -rf $(CONFIG)/obj/timing.o
	rm -rf $(CONFIG)/obj/x509parse.o
	rm -rf $(CONFIG)/obj/xtea.o

clobber: clean
	rm -fr ./$(CONFIG)

$(CONFIG)/inc/aes.h: 
	rm -fr $(CONFIG)/inc/aes.h
	cp -r src/aes.h $(CONFIG)/inc/aes.h

$(CONFIG)/inc/arc4.h: 
	rm -fr $(CONFIG)/inc/arc4.h
	cp -r src/arc4.h $(CONFIG)/inc/arc4.h

$(CONFIG)/inc/base64.h: 
	rm -fr $(CONFIG)/inc/base64.h
	cp -r src/base64.h $(CONFIG)/inc/base64.h

$(CONFIG)/inc/bignum.h: 
	rm -fr $(CONFIG)/inc/bignum.h
	cp -r src/bignum.h $(CONFIG)/inc/bignum.h

$(CONFIG)/inc/bitos.h: \
    $(CONFIG)/inc/bit.h
	rm -fr $(CONFIG)/inc/bitos.h
	cp -r src/bitos.h $(CONFIG)/inc/bitos.h

$(CONFIG)/inc/bn_mul.h: 
	rm -fr $(CONFIG)/inc/bn_mul.h
	cp -r src/bn_mul.h $(CONFIG)/inc/bn_mul.h

$(CONFIG)/inc/camellia.h: 
	rm -fr $(CONFIG)/inc/camellia.h
	cp -r src/camellia.h $(CONFIG)/inc/camellia.h

$(CONFIG)/inc/certs.h: 
	rm -fr $(CONFIG)/inc/certs.h
	cp -r src/certs.h $(CONFIG)/inc/certs.h

$(CONFIG)/inc/debug.h: 
	rm -fr $(CONFIG)/inc/debug.h
	cp -r src/debug.h $(CONFIG)/inc/debug.h

$(CONFIG)/inc/des.h: 
	rm -fr $(CONFIG)/inc/des.h
	cp -r src/des.h $(CONFIG)/inc/des.h

$(CONFIG)/inc/dhm.h: 
	rm -fr $(CONFIG)/inc/dhm.h
	cp -r src/dhm.h $(CONFIG)/inc/dhm.h

$(CONFIG)/inc/est.h: 
	rm -fr $(CONFIG)/inc/est.h
	cp -r src/est.h $(CONFIG)/inc/est.h

$(CONFIG)/inc/havege.h: 
	rm -fr $(CONFIG)/inc/havege.h
	cp -r src/havege.h $(CONFIG)/inc/havege.h

$(CONFIG)/inc/md2.h: 
	rm -fr $(CONFIG)/inc/md2.h
	cp -r src/md2.h $(CONFIG)/inc/md2.h

$(CONFIG)/inc/md4.h: 
	rm -fr $(CONFIG)/inc/md4.h
	cp -r src/md4.h $(CONFIG)/inc/md4.h

$(CONFIG)/inc/md5.h: 
	rm -fr $(CONFIG)/inc/md5.h
	cp -r src/md5.h $(CONFIG)/inc/md5.h

$(CONFIG)/inc/net.h: 
	rm -fr $(CONFIG)/inc/net.h
	cp -r src/net.h $(CONFIG)/inc/net.h

$(CONFIG)/inc/openssl.h: 
	rm -fr $(CONFIG)/inc/openssl.h
	cp -r src/openssl.h $(CONFIG)/inc/openssl.h

$(CONFIG)/inc/padlock.h: 
	rm -fr $(CONFIG)/inc/padlock.h
	cp -r src/padlock.h $(CONFIG)/inc/padlock.h

$(CONFIG)/inc/rsa.h: 
	rm -fr $(CONFIG)/inc/rsa.h
	cp -r src/rsa.h $(CONFIG)/inc/rsa.h

$(CONFIG)/inc/sha1.h: 
	rm -fr $(CONFIG)/inc/sha1.h
	cp -r src/sha1.h $(CONFIG)/inc/sha1.h

$(CONFIG)/inc/sha2.h: 
	rm -fr $(CONFIG)/inc/sha2.h
	cp -r src/sha2.h $(CONFIG)/inc/sha2.h

$(CONFIG)/inc/sha4.h: 
	rm -fr $(CONFIG)/inc/sha4.h
	cp -r src/sha4.h $(CONFIG)/inc/sha4.h

$(CONFIG)/inc/ssl.h: 
	rm -fr $(CONFIG)/inc/ssl.h
	cp -r src/ssl.h $(CONFIG)/inc/ssl.h

$(CONFIG)/inc/timing.h: 
	rm -fr $(CONFIG)/inc/timing.h
	cp -r src/timing.h $(CONFIG)/inc/timing.h

$(CONFIG)/inc/x509.h: 
	rm -fr $(CONFIG)/inc/x509.h
	cp -r src/x509.h $(CONFIG)/inc/x509.h

$(CONFIG)/inc/xtea.h: 
	rm -fr $(CONFIG)/inc/xtea.h
	cp -r src/xtea.h $(CONFIG)/inc/xtea.h

$(CONFIG)/obj/aes.o: \
    src/aes.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h \
    $(CONFIG)/inc/bitos.h \
    $(CONFIG)/inc/bignum.h \
    $(CONFIG)/inc/net.h \
    $(CONFIG)/inc/dhm.h \
    $(CONFIG)/inc/rsa.h \
    $(CONFIG)/inc/md5.h \
    $(CONFIG)/inc/sha1.h \
    $(CONFIG)/inc/x509.h \
    $(CONFIG)/inc/ssl.h \
    $(CONFIG)/inc/aes.h \
    $(CONFIG)/inc/arc4.h \
    $(CONFIG)/inc/base64.h \
    $(CONFIG)/inc/bn_mul.h \
    $(CONFIG)/inc/camellia.h \
    $(CONFIG)/inc/certs.h \
    $(CONFIG)/inc/debug.h \
    $(CONFIG)/inc/des.h \
    $(CONFIG)/inc/havege.h \
    $(CONFIG)/inc/md2.h \
    $(CONFIG)/inc/md4.h \
    $(CONFIG)/inc/padlock.h \
    $(CONFIG)/inc/sha2.h \
    $(CONFIG)/inc/sha4.h \
    $(CONFIG)/inc/timing.h \
    $(CONFIG)/inc/xtea.h
	$(CC) -c -o $(CONFIG)/obj/aes.o $(DFLAGS) $(IFLAGS) src/aes.c

$(CONFIG)/obj/arc4.o: \
    src/arc4.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/arc4.o $(DFLAGS) $(IFLAGS) src/arc4.c

$(CONFIG)/obj/base64.o: \
    src/base64.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/base64.o $(DFLAGS) $(IFLAGS) src/base64.c

$(CONFIG)/obj/bignum.o: \
    src/bignum.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/bignum.o $(DFLAGS) $(IFLAGS) src/bignum.c

$(CONFIG)/obj/camellia.o: \
    src/camellia.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/camellia.o $(DFLAGS) $(IFLAGS) src/camellia.c

$(CONFIG)/obj/certs.o: \
    src/certs.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/certs.o $(DFLAGS) $(IFLAGS) src/certs.c

$(CONFIG)/obj/debug.o: \
    src/debug.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/debug.o $(DFLAGS) $(IFLAGS) src/debug.c

$(CONFIG)/obj/des.o: \
    src/des.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/des.o $(DFLAGS) $(IFLAGS) src/des.c

$(CONFIG)/obj/dhm.o: \
    src/dhm.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/dhm.o $(DFLAGS) $(IFLAGS) src/dhm.c

$(CONFIG)/obj/havege.o: \
    src/havege.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/havege.o $(DFLAGS) $(IFLAGS) src/havege.c

$(CONFIG)/obj/md2.o: \
    src/md2.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/md2.o $(DFLAGS) $(IFLAGS) src/md2.c

$(CONFIG)/obj/md4.o: \
    src/md4.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/md4.o $(DFLAGS) $(IFLAGS) src/md4.c

$(CONFIG)/obj/md5.o: \
    src/md5.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/md5.o $(DFLAGS) $(IFLAGS) src/md5.c

$(CONFIG)/obj/net.o: \
    src/net.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/net.o $(DFLAGS) $(IFLAGS) src/net.c

$(CONFIG)/obj/padlock.o: \
    src/padlock.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/padlock.o $(DFLAGS) $(IFLAGS) src/padlock.c

$(CONFIG)/obj/rsa.o: \
    src/rsa.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/rsa.o $(DFLAGS) $(IFLAGS) src/rsa.c

$(CONFIG)/obj/sha1.o: \
    src/sha1.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/sha1.o $(DFLAGS) $(IFLAGS) src/sha1.c

$(CONFIG)/obj/sha2.o: \
    src/sha2.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/sha2.o $(DFLAGS) $(IFLAGS) src/sha2.c

$(CONFIG)/obj/sha4.o: \
    src/sha4.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/sha4.o $(DFLAGS) $(IFLAGS) src/sha4.c

$(CONFIG)/obj/ssl_cli.o: \
    src/ssl_cli.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/ssl_cli.o $(DFLAGS) $(IFLAGS) src/ssl_cli.c

$(CONFIG)/obj/ssl_srv.o: \
    src/ssl_srv.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/ssl_srv.o $(DFLAGS) $(IFLAGS) src/ssl_srv.c

$(CONFIG)/obj/ssl_tls.o: \
    src/ssl_tls.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/ssl_tls.o $(DFLAGS) $(IFLAGS) src/ssl_tls.c

$(CONFIG)/obj/timing.o: \
    src/timing.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/timing.o $(DFLAGS) $(IFLAGS) src/timing.c

$(CONFIG)/obj/x509parse.o: \
    src/x509parse.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/x509parse.o $(DFLAGS) $(IFLAGS) src/x509parse.c

$(CONFIG)/obj/xtea.o: \
    src/xtea.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/xtea.o $(DFLAGS) $(IFLAGS) src/xtea.c

$(CONFIG)/bin/libest.dylib: \
    $(CONFIG)/inc/aes.h \
    $(CONFIG)/inc/arc4.h \
    $(CONFIG)/inc/base64.h \
    $(CONFIG)/inc/bignum.h \
    $(CONFIG)/inc/bitos.h \
    $(CONFIG)/inc/bn_mul.h \
    $(CONFIG)/inc/camellia.h \
    $(CONFIG)/inc/certs.h \
    $(CONFIG)/inc/debug.h \
    $(CONFIG)/inc/des.h \
    $(CONFIG)/inc/dhm.h \
    $(CONFIG)/inc/est.h \
    $(CONFIG)/inc/havege.h \
    $(CONFIG)/inc/md2.h \
    $(CONFIG)/inc/md4.h \
    $(CONFIG)/inc/md5.h \
    $(CONFIG)/inc/net.h \
    $(CONFIG)/inc/openssl.h \
    $(CONFIG)/inc/padlock.h \
    $(CONFIG)/inc/rsa.h \
    $(CONFIG)/inc/sha1.h \
    $(CONFIG)/inc/sha2.h \
    $(CONFIG)/inc/sha4.h \
    $(CONFIG)/inc/ssl.h \
    $(CONFIG)/inc/timing.h \
    $(CONFIG)/inc/x509.h \
    $(CONFIG)/inc/xtea.h \
    $(CONFIG)/obj/aes.o \
    $(CONFIG)/obj/arc4.o \
    $(CONFIG)/obj/base64.o \
    $(CONFIG)/obj/bignum.o \
    $(CONFIG)/obj/camellia.o \
    $(CONFIG)/obj/certs.o \
    $(CONFIG)/obj/debug.o \
    $(CONFIG)/obj/des.o \
    $(CONFIG)/obj/dhm.o \
    $(CONFIG)/obj/havege.o \
    $(CONFIG)/obj/md2.o \
    $(CONFIG)/obj/md4.o \
    $(CONFIG)/obj/md5.o \
    $(CONFIG)/obj/net.o \
    $(CONFIG)/obj/padlock.o \
    $(CONFIG)/obj/rsa.o \
    $(CONFIG)/obj/sha1.o \
    $(CONFIG)/obj/sha2.o \
    $(CONFIG)/obj/sha4.o \
    $(CONFIG)/obj/ssl_cli.o \
    $(CONFIG)/obj/ssl_srv.o \
    $(CONFIG)/obj/ssl_tls.o \
    $(CONFIG)/obj/timing.o \
    $(CONFIG)/obj/x509parse.o \
    $(CONFIG)/obj/xtea.o
	$(CC) -dynamiclib -o $(CONFIG)/bin/libest.dylib $(LDFLAGS) -compatibility_version 0.1.0 -current_version 0.1.0 $(LIBPATHS) -install_name @rpath/libest.dylib $(CONFIG)/obj/aes.o $(CONFIG)/obj/arc4.o $(CONFIG)/obj/base64.o $(CONFIG)/obj/bignum.o $(CONFIG)/obj/camellia.o $(CONFIG)/obj/certs.o $(CONFIG)/obj/debug.o $(CONFIG)/obj/des.o $(CONFIG)/obj/dhm.o $(CONFIG)/obj/havege.o $(CONFIG)/obj/md2.o $(CONFIG)/obj/md4.o $(CONFIG)/obj/md5.o $(CONFIG)/obj/net.o $(CONFIG)/obj/padlock.o $(CONFIG)/obj/rsa.o $(CONFIG)/obj/sha1.o $(CONFIG)/obj/sha2.o $(CONFIG)/obj/sha4.o $(CONFIG)/obj/ssl_cli.o $(CONFIG)/obj/ssl_srv.o $(CONFIG)/obj/ssl_tls.o $(CONFIG)/obj/timing.o $(CONFIG)/obj/x509parse.o $(CONFIG)/obj/xtea.o $(LIBS)

version: 
	@echo 0.1.0-0

