/*
    bit.h -- Build It Configuration Header for linux-x86

    This header is generated by Bit during configuration. To change settings, re-run
    configure or define variables in your Makefile to override these default values.
 */

/* Settings */
#ifndef BIT_BUILD_NUMBER
    #define BIT_BUILD_NUMBER "0"
#endif
#ifndef BIT_COMPANY
    #define BIT_COMPANY "Embedthis"
#endif
#ifndef BIT_DEPTH
    #define BIT_DEPTH 1
#endif
/* Settings */
#ifndef BIT_EST_AES
    #define BIT_EST_AES 1
#endif
#ifndef BIT_EST_BASE64
    #define BIT_EST_BASE64 1
#endif
#ifndef BIT_EST_BIGNUM
    #define BIT_EST_BIGNUM 1
#endif
#ifndef BIT_EST_CAMELLIA
    #define BIT_EST_CAMELLIA 0
#endif
#ifndef BIT_EST_DES
    #define BIT_EST_DES 1
#endif
#ifndef BIT_EST_DHM
    #define BIT_EST_DHM 1
#endif
#ifndef BIT_EST_GEN_PRIME
    #define BIT_EST_GEN_PRIME 1
#endif
#ifndef BIT_EST_HAVEGE
    #define BIT_EST_HAVEGE 1
#endif
#ifndef BIT_EST_LOGGING
    #define BIT_EST_LOGGING 1
#endif
#ifndef BIT_EST_MD2
    #define BIT_EST_MD2 0
#endif
#ifndef BIT_EST_MD4
    #define BIT_EST_MD4 0
#endif
#ifndef BIT_EST_MD5
    #define BIT_EST_MD5 1
#endif
#ifndef BIT_EST_NET
    #define BIT_EST_NET 1
#endif
#ifndef BIT_EST_PADLOCK
    #define BIT_EST_PADLOCK 1
#endif
#ifndef BIT_EST_RC4
    #define BIT_EST_RC4 1
#endif
#ifndef BIT_EST_ROM_TABLES
    #define BIT_EST_ROM_TABLES 1
#endif
#ifndef BIT_EST_RSA
    #define BIT_EST_RSA 1
#endif
#ifndef BIT_EST_SHA1
    #define BIT_EST_SHA1 1
#endif
#ifndef BIT_EST_SHA2
    #define BIT_EST_SHA2 1
#endif
#ifndef BIT_EST_SHA4
    #define BIT_EST_SHA4 1
#endif
#ifndef BIT_EST_SSL_CLIENT
    #define BIT_EST_SSL_CLIENT 1
#endif
#ifndef BIT_EST_SSL_SERVER
    #define BIT_EST_SSL_SERVER 1
#endif
#ifndef BIT_EST_TEST_CERTS
    #define BIT_EST_TEST_CERTS 1
#endif
#ifndef BIT_EST_X509
    #define BIT_EST_X509 1
#endif
#ifndef BIT_EST_XTEA
    #define BIT_EST_XTEA 1
#endif
#ifndef BIT_HAS_DOUBLE_BRACES
    #define BIT_HAS_DOUBLE_BRACES 0
#endif
#ifndef BIT_HAS_DYN_LOAD
    #define BIT_HAS_DYN_LOAD 1
#endif
#ifndef BIT_HAS_LIB_EDIT
    #define BIT_HAS_LIB_EDIT 0
#endif
#ifndef BIT_HAS_LIB_RT
    #define BIT_HAS_LIB_RT 1
#endif
#ifndef BIT_HAS_MMU
    #define BIT_HAS_MMU 1
#endif
#ifndef BIT_HAS_MTUNE
    #define BIT_HAS_MTUNE 1
#endif
#ifndef BIT_HAS_PAM
    #define BIT_HAS_PAM 0
#endif
#ifndef BIT_HAS_STACK_PROTECTOR
    #define BIT_HAS_STACK_PROTECTOR 1
#endif
#ifndef BIT_HAS_SYNC
    #define BIT_HAS_SYNC 1
#endif
#ifndef BIT_HAS_SYNC_CAS
    #define BIT_HAS_SYNC_CAS 0
#endif
#ifndef BIT_HAS_UNNAMED_UNIONS
    #define BIT_HAS_UNNAMED_UNIONS 1
#endif
#ifndef BIT_OPTIONAL
    #define BIT_OPTIONAL "doxygen,dsi,ejs,man,man2html,pmaker,utest,zip"
#endif
#ifndef BIT_PACKS
    #define BIT_PACKS "bits/packs"
#endif
#ifndef BIT_PRODUCT
    #define BIT_PRODUCT "est"
#endif
#ifndef BIT_REQUIRED
    #define BIT_REQUIRED "compiler,lib,link"
#endif
#ifndef BIT_SYNC
    #define BIT_SYNC "bitos"
#endif
#ifndef BIT_TITLE
    #define BIT_TITLE "Embedthis Security Transport"
#endif
#ifndef BIT_VERSION
    #define BIT_VERSION "0.1.0"
#endif
#ifndef BIT_WARN64TO32
    #define BIT_WARN64TO32 0
#endif
#ifndef BIT_WARN_UNUSED
    #define BIT_WARN_UNUSED 1
#endif
#ifndef BIT_WITHOUT_ALL
    #define BIT_WITHOUT_ALL "doxygen,dsi,ejs,man,man2html,pmaker"
#endif

/* Prefixes */
#ifndef BIT_CFG_PREFIX
    #define BIT_CFG_PREFIX "/etc/est"
#endif
#ifndef BIT_BIN_PREFIX
    #define BIT_BIN_PREFIX "/usr/lib/est/0.1.0/bin"
#endif
#ifndef BIT_INC_PREFIX
    #define BIT_INC_PREFIX "/usr/lib/est/0.1.0/inc"
#endif
#ifndef BIT_LOG_PREFIX
    #define BIT_LOG_PREFIX "/var/log/est"
#endif
#ifndef BIT_PRD_PREFIX
    #define BIT_PRD_PREFIX "/usr/lib/est"
#endif
#ifndef BIT_SPL_PREFIX
    #define BIT_SPL_PREFIX "/var/spool/est"
#endif
#ifndef BIT_SRC_PREFIX
    #define BIT_SRC_PREFIX "/usr/src/est-0.1.0"
#endif
#ifndef BIT_VER_PREFIX
    #define BIT_VER_PREFIX "/usr/lib/est/0.1.0"
#endif
#ifndef BIT_WEB_PREFIX
    #define BIT_WEB_PREFIX "/var/www/est-default"
#endif

/* Suffixes */
#ifndef BIT_EXE
    #define BIT_EXE ""
#endif
#ifndef BIT_SHLIB
    #define BIT_SHLIB ".so"
#endif
#ifndef BIT_SHOBJ
    #define BIT_SHOBJ ".so"
#endif
#ifndef BIT_LIB
    #define BIT_LIB ".a"
#endif
#ifndef BIT_OBJ
    #define BIT_OBJ ".o"
#endif

/* Profile */
#ifndef BIT_CONFIG_CMD
    #define BIT_CONFIG_CMD "bit -d -q -platform linux-x86 -without all -configure . -gen sh,make"
#endif
#ifndef BIT_EST_PRODUCT
    #define BIT_EST_PRODUCT 1
#endif
#ifndef BIT_PROFILE
    #define BIT_PROFILE "debug"
#endif

/* Miscellaneous */
#ifndef BIT_MAJOR_VERSION
    #define BIT_MAJOR_VERSION 0
#endif
#ifndef BIT_MINOR_VERSION
    #define BIT_MINOR_VERSION 1
#endif
#ifndef BIT_PATCH_VERSION
    #define BIT_PATCH_VERSION 0
#endif
#ifndef BIT_VNUM
    #define BIT_VNUM 10000
#endif

/* Packs */
#ifndef BIT_PACK_CC
    #define BIT_PACK_CC 1
#endif
#ifndef BIT_PACK_DOXYGEN
    #define BIT_PACK_DOXYGEN 0
#endif
#ifndef BIT_PACK_DSI
    #define BIT_PACK_DSI 0
#endif
#ifndef BIT_PACK_EJS
    #define BIT_PACK_EJS 0
#endif
#ifndef BIT_PACK_LIB
    #define BIT_PACK_LIB 1
#endif
#ifndef BIT_PACK_LINK
    #define BIT_PACK_LINK 1
#endif
#ifndef BIT_PACK_MAN
    #define BIT_PACK_MAN 0
#endif
#ifndef BIT_PACK_MAN2HTML
    #define BIT_PACK_MAN2HTML 0
#endif
#ifndef BIT_PACK_PMAKER
    #define BIT_PACK_PMAKER 0
#endif
#ifndef BIT_PACK_UTEST
    #define BIT_PACK_UTEST 1
#endif
#ifndef BIT_PACK_ZIP
    #define BIT_PACK_ZIP 1
#endif
#ifndef BIT_PACK_COMPILER_PATH
    #define BIT_PACK_COMPILER_PATH "/usr/bin/gcc"
#endif
#ifndef BIT_PACK_LIB_PATH
    #define BIT_PACK_LIB_PATH "/usr/bin/ar"
#endif
#ifndef BIT_PACK_LINK_PATH
    #define BIT_PACK_LINK_PATH "/usr/bin/ld"
#endif
#ifndef BIT_PACK_UTEST_PATH
    #define BIT_PACK_UTEST_PATH "/Users/mob/git/ejs/macosx-x64-release/bin/utest"
#endif
#ifndef BIT_PACK_ZIP_PATH
    #define BIT_PACK_ZIP_PATH "/usr/bin/zip"
#endif
