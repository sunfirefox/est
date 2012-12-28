/**
    @file est.h

    Embedded Security Transport is an implementation of the SSL/TLS protocol standard.
 */

#ifndef _h_EST
#define _h_EST 1

/********************************** Includes **********************************/

#include "bit.h"
#include "bitos.h"

/*********************************** Forwards *********************************/

//  MOB - what about x64?
#if BIT_CPU_ARCH == BIT_CPU_X86 || BIT_CPU_ARCH == BIT_CPU_X64
    #define EST_HAVE_ASM 1
#endif

/* Enable if using Intel CPU with SSE2 */
#define BIT_EST_SSE2 0
/*
    Default configuration, optionally overridden by bit.h
 */
#ifndef BIT_EST_AES
    #define BIT_EST_AES 1
#endif
#ifndef BIT_EST_BIGNUM
    #define BIT_EST_BIGNUM 1
#endif
#ifndef BIT_EST_BASE64
    #define BIT_EST_BASE64 1
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
#ifndef BIT_EST_SELF_TEST
    #define BIT_EST_SELF_TEST 0
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
#ifndef BIT_EST_CLIENT
    #define BIT_EST_CLIENT 1
#endif
#ifndef BIT_EST_SERVER
    #define BIT_EST_SERVER 1
#endif
#ifndef BIT_EST_TEST_CERTS
    #define BIT_EST_TEST_CERTS 1
#endif
#ifndef BIT_EST_X509
    #define BIT_EST_X509 1
#endif
#ifndef BIT_EST_X509_WRITE
    #define BIT_EST_X509_WRITE 1
#endif
#ifndef BIT_EST_XTEA
    #define BIT_EST_XTEA 1
#endif

/*
    Required settings
 */
#define BIT_EST_SSL 1
#define BIT_EST_TIMING 1

/*
    Include all EST headers
 */
#include "bignum.h"
#include "net.h"
#include "dhm.h"
#include "rsa.h"
#include "md5.h"
#include "sha1.h"
#include "x509.h"
#include "ssl.h"
#include "aes.h"
#include "arc4.h"
#include "base64.h"
#include "bn_mul.h"
#include "camellia.h"
#include "certs.h"
#include "debug.h"
#include "des.h"
#include "havege.h"
#include "md2.h"
#include "md4.h"
#include "padlock.h"
#include "sha2.h"
#include "sha4.h"
#include "timing.h"
#include "xtea.h"

#ifdef __cplusplus
}
#endif

#endif /* _h_EST */

/*
    @copy   default

    Copyright (c) Embedthis Software LLC, 2003-2013. All Rights Reserved.

    This software is distributed under commercial and open source licenses.
    You may use the Embedthis Open Source license or you may acquire a 
    commercial license from Embedthis Software. You agree to be fully bound
    by the terms of either license. Consult the LICENSE.md distributed with
    this software for full details and other copyrights.

    Local variables:
    tab-width: 4
    c-basic-offset: 4
    End:
    vim: sw=4 ts=4 expandtab

    @end
 */
