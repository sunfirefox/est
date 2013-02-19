#
#   est-vxworks-default.mk -- Makefile to build Embedthis Security Transport for vxworks
#

export WIND_BASE := $(WIND_BASE)
export WIND_HOME := $(WIND_BASE)/..
export WIND_PLATFORM := $(WIND_PLATFORM)

PRODUCT         := est
VERSION         := 0.6.0
BUILD_NUMBER    := 0
PROFILE         := default
ARCH            := $(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/')
OS              := vxworks
CC              := ccpentium
LD              := /usr/bin/ld
CONFIG          := $(OS)-$(ARCH)-$(PROFILE)
LBIN            := $(CONFIG)/bin

BIT_ROOT_PREFIX       := deploy
BIT_BASE_PREFIX       := $(BIT_ROOT_PREFIX)
BIT_DATA_PREFIX       := $(BIT_VAPP_PREFIX)
BIT_STATE_PREFIX      := $(BIT_VAPP_PREFIX)
BIT_BIN_PREFIX        := $(BIT_VAPP_PREFIX)
BIT_INC_PREFIX        := $(BIT_VAPP_PREFIX)/inc
BIT_LIB_PREFIX        := $(BIT_VAPP_PREFIX)
BIT_MAN_PREFIX        := $(BIT_VAPP_PREFIX)
BIT_SBIN_PREFIX       := $(BIT_VAPP_PREFIX)
BIT_ETC_PREFIX        := $(BIT_VAPP_PREFIX)
BIT_WEB_PREFIX        := $(BIT_VAPP_PREFIX)/web
BIT_LOG_PREFIX        := $(BIT_VAPP_PREFIX)
BIT_SPOOL_PREFIX      := $(BIT_VAPP_PREFIX)
BIT_CACHE_PREFIX      := $(BIT_VAPP_PREFIX)
BIT_APP_PREFIX        := $(BIT_BASE_PREFIX)
BIT_VAPP_PREFIX       := $(BIT_APP_PREFIX)
BIT_SRC_PREFIX        := $(BIT_ROOT_PREFIX)/usr/src/$(PRODUCT)-$(VERSION)

CFLAGS          += -fno-builtin -fno-defer-pop -fvolatile -w
DFLAGS          += -D_REENTRANT -DVXWORKS -DRW_MULTI_THREAD -D_GNU_TOOL -DCPU=PENTIUM $(patsubst %,-D%,$(filter BIT_%,$(MAKEFLAGS)))
IFLAGS          += -I$(CONFIG)/inc -I$(WIND_BASE)/target/h -I$(WIND_BASE)/target/h/wrn/coreip
LDFLAGS         += '-Wl,-r'
LIBPATHS        += -L$(CONFIG)/bin
LIBS            += 

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
        $(CONFIG)/bin/libest.out

.PHONY: prep

prep:
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(BIT_APP_PREFIX)" = "" ] ; then echo WARNING: BIT_APP_PREFIX not set ; exit 255 ; fi
	@[ ! -x $(CONFIG)/bin ] && mkdir -p $(CONFIG)/bin; true
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc; true
	@[ ! -x $(CONFIG)/obj ] && mkdir -p $(CONFIG)/obj; true
	@[ ! -f $(CONFIG)/inc/bit.h ] && cp projects/est-vxworks-default-bit.h $(CONFIG)/inc/bit.h ; true
	@[ ! -f $(CONFIG)/inc/bitos.h ] && cp src/bitos.h $(CONFIG)/inc/bitos.h ; true
	@if ! diff $(CONFIG)/inc/bit.h projects/est-vxworks-default-bit.h >/dev/null ; then\
		echo cp projects/est-vxworks-default-bit.h $(CONFIG)/inc/bit.h  ; \
		cp projects/est-vxworks-default-bit.h $(CONFIG)/inc/bit.h  ; \
	fi; true
clean:
	rm -rf $(CONFIG)/bin/libest.out
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
	mkdir -p "vxworks-x86-default/inc"
	cp "src/aes.h" "vxworks-x86-default/inc/aes.h"

$(CONFIG)/inc/arc4.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/arc4.h" "vxworks-x86-default/inc/arc4.h"

$(CONFIG)/inc/base64.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/base64.h" "vxworks-x86-default/inc/base64.h"

$(CONFIG)/inc/bignum.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/bignum.h" "vxworks-x86-default/inc/bignum.h"

$(CONFIG)/inc/bit.h: 

$(CONFIG)/inc/bitos.h: \
    $(CONFIG)/inc/bit.h
	mkdir -p "vxworks-x86-default/inc"
	cp "src/bitos.h" "vxworks-x86-default/inc/bitos.h"

$(CONFIG)/inc/bn_mul.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/bn_mul.h" "vxworks-x86-default/inc/bn_mul.h"

$(CONFIG)/inc/camellia.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/camellia.h" "vxworks-x86-default/inc/camellia.h"

$(CONFIG)/inc/certs.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/certs.h" "vxworks-x86-default/inc/certs.h"

$(CONFIG)/inc/debug.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/debug.h" "vxworks-x86-default/inc/debug.h"

$(CONFIG)/inc/des.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/des.h" "vxworks-x86-default/inc/des.h"

$(CONFIG)/inc/dhm.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/dhm.h" "vxworks-x86-default/inc/dhm.h"

$(CONFIG)/inc/est.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/est.h" "vxworks-x86-default/inc/est.h"

$(CONFIG)/inc/havege.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/havege.h" "vxworks-x86-default/inc/havege.h"

$(CONFIG)/inc/md2.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/md2.h" "vxworks-x86-default/inc/md2.h"

$(CONFIG)/inc/md4.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/md4.h" "vxworks-x86-default/inc/md4.h"

$(CONFIG)/inc/md5.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/md5.h" "vxworks-x86-default/inc/md5.h"

$(CONFIG)/inc/net.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/net.h" "vxworks-x86-default/inc/net.h"

$(CONFIG)/inc/openssl.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/openssl.h" "vxworks-x86-default/inc/openssl.h"

$(CONFIG)/inc/padlock.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/padlock.h" "vxworks-x86-default/inc/padlock.h"

$(CONFIG)/inc/rsa.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/rsa.h" "vxworks-x86-default/inc/rsa.h"

$(CONFIG)/inc/sha1.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/sha1.h" "vxworks-x86-default/inc/sha1.h"

$(CONFIG)/inc/sha2.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/sha2.h" "vxworks-x86-default/inc/sha2.h"

$(CONFIG)/inc/sha4.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/sha4.h" "vxworks-x86-default/inc/sha4.h"

$(CONFIG)/inc/ssl.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/ssl.h" "vxworks-x86-default/inc/ssl.h"

$(CONFIG)/inc/timing.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/timing.h" "vxworks-x86-default/inc/timing.h"

$(CONFIG)/inc/x509.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/x509.h" "vxworks-x86-default/inc/x509.h"

$(CONFIG)/inc/xtea.h: 
	mkdir -p "vxworks-x86-default/inc"
	cp "src/xtea.h" "vxworks-x86-default/inc/xtea.h"

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
	$(CC) -c -o $(CONFIG)/obj/aes.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/aes.c

$(CONFIG)/obj/arc4.o: \
    src/arc4.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/arc4.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/arc4.c

$(CONFIG)/obj/base64.o: \
    src/base64.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/base64.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/base64.c

$(CONFIG)/obj/bignum.o: \
    src/bignum.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/bignum.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/bignum.c

$(CONFIG)/obj/camellia.o: \
    src/camellia.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/camellia.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/camellia.c

$(CONFIG)/obj/certs.o: \
    src/certs.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/certs.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/certs.c

$(CONFIG)/obj/debug.o: \
    src/debug.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/debug.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/debug.c

$(CONFIG)/obj/des.o: \
    src/des.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/des.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/des.c

$(CONFIG)/obj/dhm.o: \
    src/dhm.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/dhm.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/dhm.c

$(CONFIG)/obj/havege.o: \
    src/havege.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/havege.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/havege.c

$(CONFIG)/obj/md2.o: \
    src/md2.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/md2.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/md2.c

$(CONFIG)/obj/md4.o: \
    src/md4.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/md4.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/md4.c

$(CONFIG)/obj/md5.o: \
    src/md5.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/md5.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/md5.c

$(CONFIG)/obj/net.o: \
    src/net.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/net.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/net.c

$(CONFIG)/obj/padlock.o: \
    src/padlock.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/padlock.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/padlock.c

$(CONFIG)/obj/rsa.o: \
    src/rsa.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/rsa.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/rsa.c

$(CONFIG)/obj/sha1.o: \
    src/sha1.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/sha1.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/sha1.c

$(CONFIG)/obj/sha2.o: \
    src/sha2.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/sha2.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/sha2.c

$(CONFIG)/obj/sha4.o: \
    src/sha4.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/sha4.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/sha4.c

$(CONFIG)/obj/ssl_cli.o: \
    src/ssl_cli.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/ssl_cli.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/ssl_cli.c

$(CONFIG)/obj/ssl_srv.o: \
    src/ssl_srv.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/ssl_srv.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/ssl_srv.c

$(CONFIG)/obj/ssl_tls.o: \
    src/ssl_tls.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/ssl_tls.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/ssl_tls.c

$(CONFIG)/obj/timing.o: \
    src/timing.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/timing.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/timing.c

$(CONFIG)/obj/x509parse.o: \
    src/x509parse.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/x509parse.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/x509parse.c

$(CONFIG)/obj/xtea.o: \
    src/xtea.c\
    $(CONFIG)/inc/bit.h \
    $(CONFIG)/inc/est.h
	$(CC) -c -o $(CONFIG)/obj/xtea.o -fno-builtin -fno-defer-pop -fvolatile $(DFLAGS) $(IFLAGS) src/xtea.c

$(CONFIG)/bin/libest.out: \
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
	$(CC) -r -o $(CONFIG)/bin/libest.out $(LDFLAGS) $(LIBPATHS) $(CONFIG)/obj/aes.o $(CONFIG)/obj/arc4.o $(CONFIG)/obj/base64.o $(CONFIG)/obj/bignum.o $(CONFIG)/obj/camellia.o $(CONFIG)/obj/certs.o $(CONFIG)/obj/debug.o $(CONFIG)/obj/des.o $(CONFIG)/obj/dhm.o $(CONFIG)/obj/havege.o $(CONFIG)/obj/md2.o $(CONFIG)/obj/md4.o $(CONFIG)/obj/md5.o $(CONFIG)/obj/net.o $(CONFIG)/obj/padlock.o $(CONFIG)/obj/rsa.o $(CONFIG)/obj/sha1.o $(CONFIG)/obj/sha2.o $(CONFIG)/obj/sha4.o $(CONFIG)/obj/ssl_cli.o $(CONFIG)/obj/ssl_srv.o $(CONFIG)/obj/ssl_tls.o $(CONFIG)/obj/timing.o $(CONFIG)/obj/x509parse.o $(CONFIG)/obj/xtea.o 

version: 
	@echo 0.6.0-0

stop: 
	

installBinary: stop


start: 
	

install: stop installBinary start
	

uninstall: stop


