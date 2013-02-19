#
#   est-freebsd-default.mk -- Makefile to build Embedthis Security Transport for freebsd
#

PRODUCT         := est
VERSION         := 0.6.0
BUILD_NUMBER    := 0
PROFILE         := default
ARCH            := $(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/')
OS              := freebsd
CC              := /usr/bin/gcc
LD              := /usr/bin/ld
CONFIG          := $(OS)-$(ARCH)-$(PROFILE)
LBIN            := $(CONFIG)/bin

BIT_ROOT_PREFIX       := /
BIT_BASE_PREFIX       := $(BIT_ROOT_PREFIX)/usr/local
BIT_DATA_PREFIX       := $(BIT_ROOT_PREFIX)/
BIT_STATE_PREFIX      := $(BIT_ROOT_PREFIX)/var
BIT_APP_PREFIX        := $(BIT_BASE_PREFIX)/lib/$(PRODUCT)
BIT_VAPP_PREFIX       := $(BIT_APP_PREFIX)/$(VERSION)
BIT_BIN_PREFIX        := $(BIT_ROOT_PREFIX)/usr/local/bin
BIT_INC_PREFIX        := $(BIT_ROOT_PREFIX)/usr/local/include
BIT_LIB_PREFIX        := $(BIT_ROOT_PREFIX)/usr/local/lib
BIT_MAN_PREFIX        := $(BIT_ROOT_PREFIX)/usr/local/share/man
BIT_SBIN_PREFIX       := $(BIT_ROOT_PREFIX)/usr/local/sbin
BIT_ETC_PREFIX        := $(BIT_ROOT_PREFIX)/etc/$(PRODUCT)
BIT_WEB_PREFIX        := $(BIT_ROOT_PREFIX)/var/www/$(PRODUCT)-default
BIT_LOG_PREFIX        := $(BIT_ROOT_PREFIX)/var/log/$(PRODUCT)
BIT_SPOOL_PREFIX      := $(BIT_ROOT_PREFIX)/var/spool/$(PRODUCT)
BIT_CACHE_PREFIX      := $(BIT_ROOT_PREFIX)/var/spool/$(PRODUCT)/cache
BIT_SRC_PREFIX        := $(BIT_ROOT_PREFIX)$(PRODUCT)-$(VERSION)

CFLAGS          += -fPIC  -w
DFLAGS          += -D_REENTRANT -DPIC  $(patsubst %,-D%,$(filter BIT_%,$(MAKEFLAGS)))
IFLAGS          += -I$(CONFIG)/inc
LDFLAGS         += '-g'
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
        $(CONFIG)/bin/libest.so

.PHONY: prep

prep:
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(BIT_APP_PREFIX)" = "" ] ; then echo WARNING: BIT_APP_PREFIX not set ; exit 255 ; fi
	@[ ! -x $(CONFIG)/bin ] && mkdir -p $(CONFIG)/bin; true
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc; true
	@[ ! -x $(CONFIG)/obj ] && mkdir -p $(CONFIG)/obj; true
	@[ ! -f $(CONFIG)/inc/bit.h ] && cp projects/est-freebsd-default-bit.h $(CONFIG)/inc/bit.h ; true
	@[ ! -f $(CONFIG)/inc/bitos.h ] && cp src/bitos.h $(CONFIG)/inc/bitos.h ; true
	@if ! diff $(CONFIG)/inc/bit.h projects/est-freebsd-default-bit.h >/dev/null ; then\
		echo cp projects/est-freebsd-default-bit.h $(CONFIG)/inc/bit.h  ; \
		cp projects/est-freebsd-default-bit.h $(CONFIG)/inc/bit.h  ; \
	fi; true
clean:
	rm -rf $(CONFIG)/bin/libest.so
	rm -rf $(CONFIG)/obj/removeFiles.o
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
	mkdir -p "freebsd-x86-default/inc"
	cp "src/aes.h" "freebsd-x86-default/inc/aes.h"

$(CONFIG)/inc/arc4.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/arc4.h" "freebsd-x86-default/inc/arc4.h"

$(CONFIG)/inc/base64.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/base64.h" "freebsd-x86-default/inc/base64.h"

$(CONFIG)/inc/bignum.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/bignum.h" "freebsd-x86-default/inc/bignum.h"

$(CONFIG)/inc/bit.h: 

$(CONFIG)/inc/bitos.h: \
    $(CONFIG)/inc/bit.h
	mkdir -p "freebsd-x86-default/inc"
	cp "src/bitos.h" "freebsd-x86-default/inc/bitos.h"

$(CONFIG)/inc/bn_mul.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/bn_mul.h" "freebsd-x86-default/inc/bn_mul.h"

$(CONFIG)/inc/camellia.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/camellia.h" "freebsd-x86-default/inc/camellia.h"

$(CONFIG)/inc/certs.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/certs.h" "freebsd-x86-default/inc/certs.h"

$(CONFIG)/inc/debug.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/debug.h" "freebsd-x86-default/inc/debug.h"

$(CONFIG)/inc/des.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/des.h" "freebsd-x86-default/inc/des.h"

$(CONFIG)/inc/dhm.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/dhm.h" "freebsd-x86-default/inc/dhm.h"

$(CONFIG)/inc/est.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/est.h" "freebsd-x86-default/inc/est.h"

$(CONFIG)/inc/havege.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/havege.h" "freebsd-x86-default/inc/havege.h"

$(CONFIG)/inc/md2.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/md2.h" "freebsd-x86-default/inc/md2.h"

$(CONFIG)/inc/md4.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/md4.h" "freebsd-x86-default/inc/md4.h"

$(CONFIG)/inc/md5.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/md5.h" "freebsd-x86-default/inc/md5.h"

$(CONFIG)/inc/net.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/net.h" "freebsd-x86-default/inc/net.h"

$(CONFIG)/inc/openssl.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/openssl.h" "freebsd-x86-default/inc/openssl.h"

$(CONFIG)/inc/padlock.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/padlock.h" "freebsd-x86-default/inc/padlock.h"

$(CONFIG)/inc/rsa.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/rsa.h" "freebsd-x86-default/inc/rsa.h"

$(CONFIG)/inc/sha1.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/sha1.h" "freebsd-x86-default/inc/sha1.h"

$(CONFIG)/inc/sha2.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/sha2.h" "freebsd-x86-default/inc/sha2.h"

$(CONFIG)/inc/sha4.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/sha4.h" "freebsd-x86-default/inc/sha4.h"

$(CONFIG)/inc/ssl.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/ssl.h" "freebsd-x86-default/inc/ssl.h"

$(CONFIG)/inc/timing.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/timing.h" "freebsd-x86-default/inc/timing.h"

$(CONFIG)/inc/x509.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/x509.h" "freebsd-x86-default/inc/x509.h"

$(CONFIG)/inc/xtea.h: 
	mkdir -p "freebsd-x86-default/inc"
	cp "src/xtea.h" "freebsd-x86-default/inc/xtea.h"

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
	$(CC) -c -o $(CONFIG)/obj/aes.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/aes.c

$(CONFIG)/obj/arc4.o: \
    src/arc4.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/arc4.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/arc4.c

$(CONFIG)/obj/base64.o: \
    src/base64.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/base64.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/base64.c

$(CONFIG)/obj/bignum.o: \
    src/bignum.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/bignum.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/bignum.c

$(CONFIG)/obj/camellia.o: \
    src/camellia.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/camellia.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/camellia.c

$(CONFIG)/obj/certs.o: \
    src/certs.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/certs.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/certs.c

$(CONFIG)/obj/debug.o: \
    src/debug.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/debug.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/debug.c

$(CONFIG)/obj/des.o: \
    src/des.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/des.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/des.c

$(CONFIG)/obj/dhm.o: \
    src/dhm.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/dhm.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/dhm.c

$(CONFIG)/obj/havege.o: \
    src/havege.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/havege.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/havege.c

$(CONFIG)/obj/md2.o: \
    src/md2.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/md2.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/md2.c

$(CONFIG)/obj/md4.o: \
    src/md4.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/md4.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/md4.c

$(CONFIG)/obj/md5.o: \
    src/md5.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/md5.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/md5.c

$(CONFIG)/obj/net.o: \
    src/net.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/net.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/net.c

$(CONFIG)/obj/padlock.o: \
    src/padlock.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/padlock.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/padlock.c

$(CONFIG)/obj/rsa.o: \
    src/rsa.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/rsa.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/rsa.c

$(CONFIG)/obj/sha1.o: \
    src/sha1.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/sha1.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/sha1.c

$(CONFIG)/obj/sha2.o: \
    src/sha2.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/sha2.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/sha2.c

$(CONFIG)/obj/sha4.o: \
    src/sha4.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/sha4.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/sha4.c

$(CONFIG)/obj/ssl_cli.o: \
    src/ssl_cli.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/ssl_cli.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/ssl_cli.c

$(CONFIG)/obj/ssl_srv.o: \
    src/ssl_srv.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/ssl_srv.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/ssl_srv.c

$(CONFIG)/obj/ssl_tls.o: \
    src/ssl_tls.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/ssl_tls.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/ssl_tls.c

$(CONFIG)/obj/timing.o: \
    src/timing.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/timing.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/timing.c

$(CONFIG)/obj/x509parse.o: \
    src/x509parse.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/x509parse.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/x509parse.c

$(CONFIG)/obj/xtea.o: \
    src/xtea.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/xtea.o -fPIC $(LDFLAGS) $(DFLAGS) $(IFLAGS) src/xtea.c

$(CONFIG)/bin/libest.so: \
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
	$(CC) -shared -o $(CONFIG)/bin/libest.so $(LDFLAGS) $(LIBPATHS) $(CONFIG)/obj/aes.o $(CONFIG)/obj/arc4.o $(CONFIG)/obj/base64.o $(CONFIG)/obj/bignum.o $(CONFIG)/obj/camellia.o $(CONFIG)/obj/certs.o $(CONFIG)/obj/debug.o $(CONFIG)/obj/des.o $(CONFIG)/obj/dhm.o $(CONFIG)/obj/havege.o $(CONFIG)/obj/md2.o $(CONFIG)/obj/md4.o $(CONFIG)/obj/md5.o $(CONFIG)/obj/net.o $(CONFIG)/obj/padlock.o $(CONFIG)/obj/rsa.o $(CONFIG)/obj/sha1.o $(CONFIG)/obj/sha2.o $(CONFIG)/obj/sha4.o $(CONFIG)/obj/ssl_cli.o $(CONFIG)/obj/ssl_srv.o $(CONFIG)/obj/ssl_tls.o $(CONFIG)/obj/timing.o $(CONFIG)/obj/x509parse.o $(CONFIG)/obj/xtea.o $(LIBS)

version: 
	@echo 0.6.0-0

stop: 
	

installBinary: stop


start: 
	

install: stop installBinary start
	

uninstall: stop


