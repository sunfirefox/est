#
#   est-macosx-static.mk -- Makefile to build Embedded Security Transport for macosx
#

PRODUCT            := est
VERSION            := 0.6.0
BUILD_NUMBER       := 0
PROFILE            := static
ARCH               := $(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/')
CC_ARCH            := $(shell echo $(ARCH) | sed 's/x86/i686/;s/x64/x86_64/')
OS                 := macosx
CC                 := clang
LD                 := link
CONFIG             := $(OS)-$(ARCH)-$(PROFILE)
LBIN               := $(CONFIG)/bin


ifeq ($(BIT_PACK_LIB),1)
    BIT_PACK_COMPILER := 1
endif

BIT_PACK_COMPILER_PATH    := clang
BIT_PACK_DOXYGEN_PATH     := doxygen
BIT_PACK_DSI_PATH         := dsi
BIT_PACK_LIB_PATH         := ar
BIT_PACK_LINK_PATH        := link
BIT_PACK_MAN_PATH         := man
BIT_PACK_MAN2HTML_PATH    := man2html
BIT_PACK_PMAKER_PATH      := pmaker
BIT_PACK_UTEST_PATH       := utest
BIT_PACK_ZIP_PATH         := zip

CFLAGS             += -O2  -w
DFLAGS             +=  $(patsubst %,-D%,$(filter BIT_%,$(MAKEFLAGS))) 
IFLAGS             += -I$(CONFIG)/inc
LDFLAGS            += '-Wl,-rpath,@executable_path/' '-Wl,-rpath,@loader_path/'
LIBPATHS           += -L$(CONFIG)/bin
LIBS               += -ldl -lpthread -lm

DEBUG              := debug
CFLAGS-debug       := -g
DFLAGS-debug       := -DBIT_DEBUG
LDFLAGS-debug      := -g
DFLAGS-release     := 
CFLAGS-release     := -O2
LDFLAGS-release    := 
CFLAGS             += $(CFLAGS-$(DEBUG))
DFLAGS             += $(DFLAGS-$(DEBUG))
LDFLAGS            += $(LDFLAGS-$(DEBUG))

BIT_ROOT_PREFIX    := 
BIT_BASE_PREFIX    := $(BIT_ROOT_PREFIX)/usr/local
BIT_DATA_PREFIX    := $(BIT_ROOT_PREFIX)/
BIT_STATE_PREFIX   := $(BIT_ROOT_PREFIX)/var
BIT_APP_PREFIX     := $(BIT_BASE_PREFIX)/lib/$(PRODUCT)
BIT_VAPP_PREFIX    := $(BIT_APP_PREFIX)/$(VERSION)
BIT_BIN_PREFIX     := $(BIT_ROOT_PREFIX)/usr/local/bin
BIT_INC_PREFIX     := $(BIT_ROOT_PREFIX)/usr/local/include
BIT_LIB_PREFIX     := $(BIT_ROOT_PREFIX)/usr/local/lib
BIT_MAN_PREFIX     := $(BIT_ROOT_PREFIX)/usr/local/share/man
BIT_SBIN_PREFIX    := $(BIT_ROOT_PREFIX)/usr/local/sbin
BIT_ETC_PREFIX     := $(BIT_ROOT_PREFIX)/etc/$(PRODUCT)
BIT_WEB_PREFIX     := $(BIT_ROOT_PREFIX)/var/www/$(PRODUCT)-default
BIT_LOG_PREFIX     := $(BIT_ROOT_PREFIX)/var/log/$(PRODUCT)
BIT_SPOOL_PREFIX   := $(BIT_ROOT_PREFIX)/var/spool/$(PRODUCT)
BIT_CACHE_PREFIX   := $(BIT_ROOT_PREFIX)/var/spool/$(PRODUCT)/cache
BIT_SRC_PREFIX     := $(BIT_ROOT_PREFIX)$(PRODUCT)-$(VERSION)


TARGETS            += $(CONFIG)/bin/libest.a

unexport CDPATH

ifndef SHOW
.SILENT:
endif

all build compile: prep $(TARGETS)

.PHONY: prep

prep:
	@echo "      [Info] Use "make SHOW=1" to trace executed commands."
	@if [ "$(CONFIG)" = "" ] ; then echo WARNING: CONFIG not set ; exit 255 ; fi
	@if [ "$(BIT_APP_PREFIX)" = "" ] ; then echo WARNING: BIT_APP_PREFIX not set ; exit 255 ; fi
	@[ ! -x $(CONFIG)/bin ] && mkdir -p $(CONFIG)/bin; true
	@[ ! -x $(CONFIG)/inc ] && mkdir -p $(CONFIG)/inc; true
	@[ ! -x $(CONFIG)/obj ] && mkdir -p $(CONFIG)/obj; true
	@[ ! -f $(CONFIG)/inc/bitos.h ] && cp src/bitos.h $(CONFIG)/inc/bitos.h ; true
	@if ! diff $(CONFIG)/inc/bitos.h src/bitos.h >/dev/null ; then\
		cp src/bitos.h $(CONFIG)/inc/bitos.h  ; \
	fi; true
	@[ ! -f $(CONFIG)/inc/bit.h ] && cp projects/est-macosx-static-bit.h $(CONFIG)/inc/bit.h ; true
	@if ! diff $(CONFIG)/inc/bit.h projects/est-macosx-static-bit.h >/dev/null ; then\
		cp projects/est-macosx-static-bit.h $(CONFIG)/inc/bit.h  ; \
	fi; true
	@if [ -f "$(CONFIG)/.makeflags" ] ; then \
		if [ "$(MAKEFLAGS)" != " ` cat $(CONFIG)/.makeflags`" ] ; then \
			echo "   [Warning] Make flags have changed since the last build: "`cat $(CONFIG)/.makeflags`"" ; \
		fi ; \
	fi
	@echo $(MAKEFLAGS) >$(CONFIG)/.makeflags

clean:
	rm -f "$(CONFIG)/bin/libest.a"
	rm -f "$(CONFIG)/obj/aes.o"
	rm -f "$(CONFIG)/obj/arc4.o"
	rm -f "$(CONFIG)/obj/base64.o"
	rm -f "$(CONFIG)/obj/bignum.o"
	rm -f "$(CONFIG)/obj/camellia.o"
	rm -f "$(CONFIG)/obj/certs.o"
	rm -f "$(CONFIG)/obj/debug.o"
	rm -f "$(CONFIG)/obj/des.o"
	rm -f "$(CONFIG)/obj/dhm.o"
	rm -f "$(CONFIG)/obj/havege.o"
	rm -f "$(CONFIG)/obj/md2.o"
	rm -f "$(CONFIG)/obj/md4.o"
	rm -f "$(CONFIG)/obj/md5.o"
	rm -f "$(CONFIG)/obj/net.o"
	rm -f "$(CONFIG)/obj/padlock.o"
	rm -f "$(CONFIG)/obj/rsa.o"
	rm -f "$(CONFIG)/obj/sha1.o"
	rm -f "$(CONFIG)/obj/sha2.o"
	rm -f "$(CONFIG)/obj/sha4.o"
	rm -f "$(CONFIG)/obj/ssl_cli.o"
	rm -f "$(CONFIG)/obj/ssl_srv.o"
	rm -f "$(CONFIG)/obj/ssl_tls.o"
	rm -f "$(CONFIG)/obj/timing.o"
	rm -f "$(CONFIG)/obj/x509parse.o"
	rm -f "$(CONFIG)/obj/xtea.o"

clobber: clean
	rm -fr ./$(CONFIG)



#
#   version
#
version: $(DEPS_1)
	@echo 0.6.0-0

#
#   aes.h
#
$(CONFIG)/inc/aes.h: $(DEPS_2)
	@echo '      [Copy] $(CONFIG)/inc/aes.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/aes.h $(CONFIG)/inc/aes.h

#
#   arc4.h
#
$(CONFIG)/inc/arc4.h: $(DEPS_3)
	@echo '      [Copy] $(CONFIG)/inc/arc4.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/arc4.h $(CONFIG)/inc/arc4.h

#
#   base64.h
#
$(CONFIG)/inc/base64.h: $(DEPS_4)
	@echo '      [Copy] $(CONFIG)/inc/base64.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/base64.h $(CONFIG)/inc/base64.h

#
#   bignum.h
#
$(CONFIG)/inc/bignum.h: $(DEPS_5)
	@echo '      [Copy] $(CONFIG)/inc/bignum.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/bignum.h $(CONFIG)/inc/bignum.h

#
#   bit.h
#
$(CONFIG)/inc/bit.h: $(DEPS_6)
	@echo '      [Copy] $(CONFIG)/inc/bit.h'

#
#   bitos.h
#
DEPS_7 += $(CONFIG)/inc/bit.h

$(CONFIG)/inc/bitos.h: $(DEPS_7)
	@echo '      [Copy] $(CONFIG)/inc/bitos.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/bitos.h $(CONFIG)/inc/bitos.h

#
#   bn_mul.h
#
$(CONFIG)/inc/bn_mul.h: $(DEPS_8)
	@echo '      [Copy] $(CONFIG)/inc/bn_mul.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/bn_mul.h $(CONFIG)/inc/bn_mul.h

#
#   camellia.h
#
$(CONFIG)/inc/camellia.h: $(DEPS_9)
	@echo '      [Copy] $(CONFIG)/inc/camellia.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/camellia.h $(CONFIG)/inc/camellia.h

#
#   certs.h
#
$(CONFIG)/inc/certs.h: $(DEPS_10)
	@echo '      [Copy] $(CONFIG)/inc/certs.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/certs.h $(CONFIG)/inc/certs.h

#
#   debug.h
#
$(CONFIG)/inc/debug.h: $(DEPS_11)
	@echo '      [Copy] $(CONFIG)/inc/debug.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/debug.h $(CONFIG)/inc/debug.h

#
#   des.h
#
$(CONFIG)/inc/des.h: $(DEPS_12)
	@echo '      [Copy] $(CONFIG)/inc/des.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/des.h $(CONFIG)/inc/des.h

#
#   dhm.h
#
$(CONFIG)/inc/dhm.h: $(DEPS_13)
	@echo '      [Copy] $(CONFIG)/inc/dhm.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/dhm.h $(CONFIG)/inc/dhm.h

#
#   est.h
#
$(CONFIG)/inc/est.h: $(DEPS_14)
	@echo '      [Copy] $(CONFIG)/inc/est.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/est.h $(CONFIG)/inc/est.h

#
#   havege.h
#
$(CONFIG)/inc/havege.h: $(DEPS_15)
	@echo '      [Copy] $(CONFIG)/inc/havege.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/havege.h $(CONFIG)/inc/havege.h

#
#   md2.h
#
$(CONFIG)/inc/md2.h: $(DEPS_16)
	@echo '      [Copy] $(CONFIG)/inc/md2.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/md2.h $(CONFIG)/inc/md2.h

#
#   md4.h
#
$(CONFIG)/inc/md4.h: $(DEPS_17)
	@echo '      [Copy] $(CONFIG)/inc/md4.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/md4.h $(CONFIG)/inc/md4.h

#
#   md5.h
#
$(CONFIG)/inc/md5.h: $(DEPS_18)
	@echo '      [Copy] $(CONFIG)/inc/md5.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/md5.h $(CONFIG)/inc/md5.h

#
#   net.h
#
$(CONFIG)/inc/net.h: $(DEPS_19)
	@echo '      [Copy] $(CONFIG)/inc/net.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/net.h $(CONFIG)/inc/net.h

#
#   openssl.h
#
$(CONFIG)/inc/openssl.h: $(DEPS_20)
	@echo '      [Copy] $(CONFIG)/inc/openssl.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/openssl.h $(CONFIG)/inc/openssl.h

#
#   padlock.h
#
$(CONFIG)/inc/padlock.h: $(DEPS_21)
	@echo '      [Copy] $(CONFIG)/inc/padlock.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/padlock.h $(CONFIG)/inc/padlock.h

#
#   rsa.h
#
$(CONFIG)/inc/rsa.h: $(DEPS_22)
	@echo '      [Copy] $(CONFIG)/inc/rsa.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/rsa.h $(CONFIG)/inc/rsa.h

#
#   sha1.h
#
$(CONFIG)/inc/sha1.h: $(DEPS_23)
	@echo '      [Copy] $(CONFIG)/inc/sha1.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/sha1.h $(CONFIG)/inc/sha1.h

#
#   sha2.h
#
$(CONFIG)/inc/sha2.h: $(DEPS_24)
	@echo '      [Copy] $(CONFIG)/inc/sha2.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/sha2.h $(CONFIG)/inc/sha2.h

#
#   sha4.h
#
$(CONFIG)/inc/sha4.h: $(DEPS_25)
	@echo '      [Copy] $(CONFIG)/inc/sha4.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/sha4.h $(CONFIG)/inc/sha4.h

#
#   ssl.h
#
$(CONFIG)/inc/ssl.h: $(DEPS_26)
	@echo '      [Copy] $(CONFIG)/inc/ssl.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/ssl.h $(CONFIG)/inc/ssl.h

#
#   timing.h
#
$(CONFIG)/inc/timing.h: $(DEPS_27)
	@echo '      [Copy] $(CONFIG)/inc/timing.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/timing.h $(CONFIG)/inc/timing.h

#
#   x509.h
#
$(CONFIG)/inc/x509.h: $(DEPS_28)
	@echo '      [Copy] $(CONFIG)/inc/x509.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/x509.h $(CONFIG)/inc/x509.h

#
#   xtea.h
#
$(CONFIG)/inc/xtea.h: $(DEPS_29)
	@echo '      [Copy] $(CONFIG)/inc/xtea.h'
	mkdir -p "$(CONFIG)/inc"
	cp src/xtea.h $(CONFIG)/inc/xtea.h

#
#   aes.o
#
DEPS_30 += $(CONFIG)/inc/bit.h
DEPS_30 += $(CONFIG)/inc/est.h
DEPS_30 += $(CONFIG)/inc/bitos.h
DEPS_30 += $(CONFIG)/inc/bignum.h
DEPS_30 += $(CONFIG)/inc/net.h
DEPS_30 += $(CONFIG)/inc/dhm.h
DEPS_30 += $(CONFIG)/inc/rsa.h
DEPS_30 += $(CONFIG)/inc/md5.h
DEPS_30 += $(CONFIG)/inc/sha1.h
DEPS_30 += $(CONFIG)/inc/x509.h
DEPS_30 += $(CONFIG)/inc/ssl.h
DEPS_30 += $(CONFIG)/inc/aes.h
DEPS_30 += $(CONFIG)/inc/arc4.h
DEPS_30 += $(CONFIG)/inc/base64.h
DEPS_30 += $(CONFIG)/inc/bn_mul.h
DEPS_30 += $(CONFIG)/inc/camellia.h
DEPS_30 += $(CONFIG)/inc/certs.h
DEPS_30 += $(CONFIG)/inc/debug.h
DEPS_30 += $(CONFIG)/inc/des.h
DEPS_30 += $(CONFIG)/inc/havege.h
DEPS_30 += $(CONFIG)/inc/md2.h
DEPS_30 += $(CONFIG)/inc/md4.h
DEPS_30 += $(CONFIG)/inc/padlock.h
DEPS_30 += $(CONFIG)/inc/sha2.h
DEPS_30 += $(CONFIG)/inc/sha4.h
DEPS_30 += $(CONFIG)/inc/timing.h
DEPS_30 += $(CONFIG)/inc/xtea.h

$(CONFIG)/obj/aes.o: \
    src/aes.c $(DEPS_30)
	@echo '   [Compile] $(CONFIG)/obj/aes.o'
	$(CC) -c -o $(CONFIG)/obj/aes.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/aes.c

#
#   arc4.o
#
DEPS_31 += $(CONFIG)/inc/bit.h
DEPS_31 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/arc4.o: \
    src/arc4.c $(DEPS_31)
	@echo '   [Compile] $(CONFIG)/obj/arc4.o'
	$(CC) -c -o $(CONFIG)/obj/arc4.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/arc4.c

#
#   base64.o
#
DEPS_32 += $(CONFIG)/inc/bit.h
DEPS_32 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/base64.o: \
    src/base64.c $(DEPS_32)
	@echo '   [Compile] $(CONFIG)/obj/base64.o'
	$(CC) -c -o $(CONFIG)/obj/base64.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/base64.c

#
#   bignum.o
#
DEPS_33 += $(CONFIG)/inc/bit.h
DEPS_33 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/bignum.o: \
    src/bignum.c $(DEPS_33)
	@echo '   [Compile] $(CONFIG)/obj/bignum.o'
	$(CC) -c -o $(CONFIG)/obj/bignum.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/bignum.c

#
#   camellia.o
#
DEPS_34 += $(CONFIG)/inc/bit.h
DEPS_34 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/camellia.o: \
    src/camellia.c $(DEPS_34)
	@echo '   [Compile] $(CONFIG)/obj/camellia.o'
	$(CC) -c -o $(CONFIG)/obj/camellia.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/camellia.c

#
#   certs.o
#
DEPS_35 += $(CONFIG)/inc/bit.h
DEPS_35 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/certs.o: \
    src/certs.c $(DEPS_35)
	@echo '   [Compile] $(CONFIG)/obj/certs.o'
	$(CC) -c -o $(CONFIG)/obj/certs.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/certs.c

#
#   debug.o
#
DEPS_36 += $(CONFIG)/inc/bit.h
DEPS_36 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/debug.o: \
    src/debug.c $(DEPS_36)
	@echo '   [Compile] $(CONFIG)/obj/debug.o'
	$(CC) -c -o $(CONFIG)/obj/debug.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/debug.c

#
#   des.o
#
DEPS_37 += $(CONFIG)/inc/bit.h
DEPS_37 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/des.o: \
    src/des.c $(DEPS_37)
	@echo '   [Compile] $(CONFIG)/obj/des.o'
	$(CC) -c -o $(CONFIG)/obj/des.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/des.c

#
#   dhm.o
#
DEPS_38 += $(CONFIG)/inc/bit.h
DEPS_38 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/dhm.o: \
    src/dhm.c $(DEPS_38)
	@echo '   [Compile] $(CONFIG)/obj/dhm.o'
	$(CC) -c -o $(CONFIG)/obj/dhm.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/dhm.c

#
#   havege.o
#
DEPS_39 += $(CONFIG)/inc/bit.h
DEPS_39 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/havege.o: \
    src/havege.c $(DEPS_39)
	@echo '   [Compile] $(CONFIG)/obj/havege.o'
	$(CC) -c -o $(CONFIG)/obj/havege.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/havege.c

#
#   md2.o
#
DEPS_40 += $(CONFIG)/inc/bit.h
DEPS_40 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/md2.o: \
    src/md2.c $(DEPS_40)
	@echo '   [Compile] $(CONFIG)/obj/md2.o'
	$(CC) -c -o $(CONFIG)/obj/md2.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/md2.c

#
#   md4.o
#
DEPS_41 += $(CONFIG)/inc/bit.h
DEPS_41 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/md4.o: \
    src/md4.c $(DEPS_41)
	@echo '   [Compile] $(CONFIG)/obj/md4.o'
	$(CC) -c -o $(CONFIG)/obj/md4.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/md4.c

#
#   md5.o
#
DEPS_42 += $(CONFIG)/inc/bit.h
DEPS_42 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/md5.o: \
    src/md5.c $(DEPS_42)
	@echo '   [Compile] $(CONFIG)/obj/md5.o'
	$(CC) -c -o $(CONFIG)/obj/md5.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/md5.c

#
#   net.o
#
DEPS_43 += $(CONFIG)/inc/bit.h
DEPS_43 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/net.o: \
    src/net.c $(DEPS_43)
	@echo '   [Compile] $(CONFIG)/obj/net.o'
	$(CC) -c -o $(CONFIG)/obj/net.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/net.c

#
#   padlock.o
#
DEPS_44 += $(CONFIG)/inc/bit.h
DEPS_44 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/padlock.o: \
    src/padlock.c $(DEPS_44)
	@echo '   [Compile] $(CONFIG)/obj/padlock.o'
	$(CC) -c -o $(CONFIG)/obj/padlock.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/padlock.c

#
#   rsa.o
#
DEPS_45 += $(CONFIG)/inc/bit.h
DEPS_45 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/rsa.o: \
    src/rsa.c $(DEPS_45)
	@echo '   [Compile] $(CONFIG)/obj/rsa.o'
	$(CC) -c -o $(CONFIG)/obj/rsa.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/rsa.c

#
#   sha1.o
#
DEPS_46 += $(CONFIG)/inc/bit.h
DEPS_46 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/sha1.o: \
    src/sha1.c $(DEPS_46)
	@echo '   [Compile] $(CONFIG)/obj/sha1.o'
	$(CC) -c -o $(CONFIG)/obj/sha1.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/sha1.c

#
#   sha2.o
#
DEPS_47 += $(CONFIG)/inc/bit.h
DEPS_47 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/sha2.o: \
    src/sha2.c $(DEPS_47)
	@echo '   [Compile] $(CONFIG)/obj/sha2.o'
	$(CC) -c -o $(CONFIG)/obj/sha2.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/sha2.c

#
#   sha4.o
#
DEPS_48 += $(CONFIG)/inc/bit.h
DEPS_48 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/sha4.o: \
    src/sha4.c $(DEPS_48)
	@echo '   [Compile] $(CONFIG)/obj/sha4.o'
	$(CC) -c -o $(CONFIG)/obj/sha4.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/sha4.c

#
#   ssl_cli.o
#
DEPS_49 += $(CONFIG)/inc/bit.h
DEPS_49 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/ssl_cli.o: \
    src/ssl_cli.c $(DEPS_49)
	@echo '   [Compile] $(CONFIG)/obj/ssl_cli.o'
	$(CC) -c -o $(CONFIG)/obj/ssl_cli.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/ssl_cli.c

#
#   ssl_srv.o
#
DEPS_50 += $(CONFIG)/inc/bit.h
DEPS_50 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/ssl_srv.o: \
    src/ssl_srv.c $(DEPS_50)
	@echo '   [Compile] $(CONFIG)/obj/ssl_srv.o'
	$(CC) -c -o $(CONFIG)/obj/ssl_srv.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/ssl_srv.c

#
#   ssl_tls.o
#
DEPS_51 += $(CONFIG)/inc/bit.h
DEPS_51 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/ssl_tls.o: \
    src/ssl_tls.c $(DEPS_51)
	@echo '   [Compile] $(CONFIG)/obj/ssl_tls.o'
	$(CC) -c -o $(CONFIG)/obj/ssl_tls.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/ssl_tls.c

#
#   timing.o
#
DEPS_52 += $(CONFIG)/inc/bit.h
DEPS_52 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/timing.o: \
    src/timing.c $(DEPS_52)
	@echo '   [Compile] $(CONFIG)/obj/timing.o'
	$(CC) -c -o $(CONFIG)/obj/timing.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/timing.c

#
#   x509parse.o
#
DEPS_53 += $(CONFIG)/inc/bit.h
DEPS_53 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/x509parse.o: \
    src/x509parse.c $(DEPS_53)
	@echo '   [Compile] $(CONFIG)/obj/x509parse.o'
	$(CC) -c -o $(CONFIG)/obj/x509parse.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/x509parse.c

#
#   xtea.o
#
DEPS_54 += $(CONFIG)/inc/bit.h
DEPS_54 += $(CONFIG)/inc/est.h

$(CONFIG)/obj/xtea.o: \
    src/xtea.c $(DEPS_54)
	@echo '   [Compile] $(CONFIG)/obj/xtea.o'
	$(CC) -c -o $(CONFIG)/obj/xtea.o -arch $(CC_ARCH) -O2 "$(IFLAGS)" src/xtea.c

#
#   libest
#
DEPS_55 += $(CONFIG)/inc/aes.h
DEPS_55 += $(CONFIG)/inc/arc4.h
DEPS_55 += $(CONFIG)/inc/base64.h
DEPS_55 += $(CONFIG)/inc/bignum.h
DEPS_55 += $(CONFIG)/inc/bit.h
DEPS_55 += $(CONFIG)/inc/bitos.h
DEPS_55 += $(CONFIG)/inc/bn_mul.h
DEPS_55 += $(CONFIG)/inc/camellia.h
DEPS_55 += $(CONFIG)/inc/certs.h
DEPS_55 += $(CONFIG)/inc/debug.h
DEPS_55 += $(CONFIG)/inc/des.h
DEPS_55 += $(CONFIG)/inc/dhm.h
DEPS_55 += $(CONFIG)/inc/est.h
DEPS_55 += $(CONFIG)/inc/havege.h
DEPS_55 += $(CONFIG)/inc/md2.h
DEPS_55 += $(CONFIG)/inc/md4.h
DEPS_55 += $(CONFIG)/inc/md5.h
DEPS_55 += $(CONFIG)/inc/net.h
DEPS_55 += $(CONFIG)/inc/openssl.h
DEPS_55 += $(CONFIG)/inc/padlock.h
DEPS_55 += $(CONFIG)/inc/rsa.h
DEPS_55 += $(CONFIG)/inc/sha1.h
DEPS_55 += $(CONFIG)/inc/sha2.h
DEPS_55 += $(CONFIG)/inc/sha4.h
DEPS_55 += $(CONFIG)/inc/ssl.h
DEPS_55 += $(CONFIG)/inc/timing.h
DEPS_55 += $(CONFIG)/inc/x509.h
DEPS_55 += $(CONFIG)/inc/xtea.h
DEPS_55 += $(CONFIG)/obj/aes.o
DEPS_55 += $(CONFIG)/obj/arc4.o
DEPS_55 += $(CONFIG)/obj/base64.o
DEPS_55 += $(CONFIG)/obj/bignum.o
DEPS_55 += $(CONFIG)/obj/camellia.o
DEPS_55 += $(CONFIG)/obj/certs.o
DEPS_55 += $(CONFIG)/obj/debug.o
DEPS_55 += $(CONFIG)/obj/des.o
DEPS_55 += $(CONFIG)/obj/dhm.o
DEPS_55 += $(CONFIG)/obj/havege.o
DEPS_55 += $(CONFIG)/obj/md2.o
DEPS_55 += $(CONFIG)/obj/md4.o
DEPS_55 += $(CONFIG)/obj/md5.o
DEPS_55 += $(CONFIG)/obj/net.o
DEPS_55 += $(CONFIG)/obj/padlock.o
DEPS_55 += $(CONFIG)/obj/rsa.o
DEPS_55 += $(CONFIG)/obj/sha1.o
DEPS_55 += $(CONFIG)/obj/sha2.o
DEPS_55 += $(CONFIG)/obj/sha4.o
DEPS_55 += $(CONFIG)/obj/ssl_cli.o
DEPS_55 += $(CONFIG)/obj/ssl_srv.o
DEPS_55 += $(CONFIG)/obj/ssl_tls.o
DEPS_55 += $(CONFIG)/obj/timing.o
DEPS_55 += $(CONFIG)/obj/x509parse.o
DEPS_55 += $(CONFIG)/obj/xtea.o

$(CONFIG)/bin/libest.a: $(DEPS_55)
	@echo '      [Link] $(CONFIG)/bin/libest.a'
	ar -cr $(CONFIG)/bin/libest.a "$(CONFIG)/obj/aes.o" "$(CONFIG)/obj/arc4.o" "$(CONFIG)/obj/base64.o" "$(CONFIG)/obj/bignum.o" "$(CONFIG)/obj/camellia.o" "$(CONFIG)/obj/certs.o" "$(CONFIG)/obj/debug.o" "$(CONFIG)/obj/des.o" "$(CONFIG)/obj/dhm.o" "$(CONFIG)/obj/havege.o" "$(CONFIG)/obj/md2.o" "$(CONFIG)/obj/md4.o" "$(CONFIG)/obj/md5.o" "$(CONFIG)/obj/net.o" "$(CONFIG)/obj/padlock.o" "$(CONFIG)/obj/rsa.o" "$(CONFIG)/obj/sha1.o" "$(CONFIG)/obj/sha2.o" "$(CONFIG)/obj/sha4.o" "$(CONFIG)/obj/ssl_cli.o" "$(CONFIG)/obj/ssl_srv.o" "$(CONFIG)/obj/ssl_tls.o" "$(CONFIG)/obj/timing.o" "$(CONFIG)/obj/x509parse.o" "$(CONFIG)/obj/xtea.o"

#
#   stop
#
stop: $(DEPS_56)

#
#   installBinary
#
installBinary: $(DEPS_57)

#
#   start
#
start: $(DEPS_58)

#
#   install
#
DEPS_59 += stop
DEPS_59 += installBinary
DEPS_59 += start

install: $(DEPS_59)
	

#
#   uninstall
#
DEPS_60 += stop

uninstall: $(DEPS_60)

