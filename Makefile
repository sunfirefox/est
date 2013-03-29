#
#   Makefile - Embedthis EST Makefile wrapper for per-platform makefiles
#
#   This Makefile is for Unix/Linux and Cygwin. On windows, it can be invoked via make.bat.
#
#   You can use this Makefile and build via "make" with a pre-selected configuration. Alternatively,
#	you can build using the "bit" tool for for a fully configurable build. If you wish to 
#	cross-compile, you should use "bit".
#
#   Modify compiler and linker default definitions here:
#
#       export ARCH      = CPU architecture (x86, x64, ppc, ...)
#       export OS        = Operating system (linux, macosx, windows, vxworks, ...)
#       export CC        = Compiler to use 
#       export LD        = Linker to use
#       export DEBUG     = Set to debug or release for debug or optimized builds
#       export CONFIG    = Output directory for built items. Defaults to OS-ARCH-PROFILE
#       export CFLAGS    = Add compiler options. For example: -Wall
#       export DFLAGS    = Add compiler defines. For example: -DCOLOR=blue
#       export IFLAGS    = Add compiler include directories. For example: -I/extra/includes
#       export LDFLAGS   = Add linker options
#       export LIBPATHS  = Add linker library search directories. For example: -L/libraries
#       export LIBS      = Add linker libraries. For example: -lpthreads
#       export PROFILE   = Build profile, used in output products directory name
#
#	See projects/$(OS)-$(ARCH)-$(PROFILE)-bit.h for configuration default settings. Can override via
#	environment variables. For example: make BIT_PACK_SQLITE=0. These are converted to DFLAGS and 
#	will then override the bit.h default values.
#
NAME    := est
OS      := $(shell uname | sed 's/CYGWIN.*/windows/;s/Darwin/macosx/' | tr '[A-Z]' '[a-z]')
MAKE    := $(shell if which gmake >/dev/null 2>&1; then echo gmake ; else echo make ; fi) --no-print-directory
PROFILE := default
DEBUG	:= debug
EXT     := mk

ifeq ($(OS),windows)
ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
    ARCH?=x64
else
    ARCH?=x86
endif
    MAKE:= MAKEFLAGS= projects/windows.bat $(ARCH)
    EXT := nmake
else
	ARCH:= $(shell uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/')
endif
BIN 	:= $(OS)-$(ARCH)-$(PROFILE)/bin

.EXPORT_ALL_VARIABLES:

all build compile:
	$(MAKE) -f projects/$(NAME)-$(OS)-$(PROFILE).$(EXT) $@

clean clobber install installBinary uninstall run:
	$(MAKE) -f projects/$(NAME)-$(OS)-$(PROFILE).$(EXT) $@

version:
	@$(MAKE) -f projects/$(NAME)-$(OS)-$(PROFILE).$(EXT) $@

help:
	@echo '' >&2
	@echo 'With make, the default configuration can be modified by setting make' >&2
	@echo 'variables. Set to 0 to disable and 1 to enable:' >&2
	@echo '' >&2
	@echo '  PROFILE            # Select default or static for static linking' >&2
	@echo '  BIT_EST_AES        # Enable AES cipher (true|false)' >&2
	@echo '  BIT_EST_BASE64     # Enable arbitrary precision math (true|false)' >&2
	@echo '  BIT_EST_RC4        # Enable the ARC4 cipher (true|false)' >&2
	@echo '  BIT_EST_CAMELLIA   # Enable the Camellia cipher (true|false)' >&2
	@echo '  BIT_EST_DES        # Enable the 3DES cipher (true|false)' >&2
	@echo '  BIT_EST_DHM        # Enable the DHM (true|false)' >&2
	@echo '  BIT_EST_GEN_PRIME  # Enable generation of primes (true|false)' >&2
	@echo '  BIT_EST_HAVEGE     # Enable HAVEGE random generator (true|false)' >&2
	@echo '  BIT_EST_LOGGING    # Enable trace logging (true|false)' >&2
	@echo '  BIT_EST_MD2        # Enable MD2 (true|false)' >&2
	@echo '  BIT_EST_MD4        # Enable MD4 (true|false)' >&2
	@echo '  BIT_EST_MD5        # Enable MD5  (true|false)' >&2
	@echo '  BIT_EST_NET        # Enable network I/O layer (true|false)' >&2
	@echo '  BIT_EST_PADLOCK    # Enable VIA Padlock acceleration (true|false)' >&2
	@echo '  BIT_EST_ROM_TABLES # Enable ROM tables (true|false)' >&2
	@echo '  BIT_EST_RSA        # Enable RSA cipher (true|false)' >&2
	@echo '  BIT_EST_SHA1       # Enable SHA1 (true|false)' >&2
	@echo '  BIT_EST_SHA2       # Enable SHA2 (true|false)' >&2
	@echo '  BIT_EST_SHA4       # Enable SHA4 (true|false)' >&2
	@echo '  BIT_EST_SSL_CLIENT # Enable SSL/TLS client side (true|false)' >&2
	@echo '  BIT_EST_SSL_SERVER # Enable SSL/TLS server side (true|false)' >&2
	@echo '  BIT_EST_TEST_CERTS # Enable generation of test certificates (true|false)' >&2
	@echo '  BIT_EST_X509       # Enable X509 certificate support (true|false)' >&2
	@echo '  BIT_EST_XTEA       # Enable XTEA (true|false)' >&2
	@echo '' >&2
	@echo 'For example, to disable logging:' >&2
	@echo '' >&2
	@echo '  BIT_EST_LOGGING=0 make' >&2
	@echo '' >&2
	@echo 'Other make variables include:' >&2
	@echo '' >&2
	@echo '  ARCH, CC, CFLAGS, DFLAGS, IFLAGS, LD, LDFLAGS, LIBPATHS, LIBS, OS' >&2
	@echo '' >&2
	@echo 'Alternatively, for faster, easier and fully configurable building, install' >&2
	@echo 'bit from http://embedthis.com/downloads/bit/download.ejs and re-run'>&2
	@echo 'configure and then build with bit.' >&2
	@echo '' >&2
	@echo 'Use "SHOW=1 make" to show executed commands.' >&2
	@echo '' >&2
