#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "bit.h"

#define _FILE_OFFSET_BITS 64

#ifndef TROPICSSL_CONFIG_H
#define TROPICSSL_CONFIG_H

#ifndef _CRT_SECURE_NO_DEPRECATE
#define _CRT_SECURE_NO_DEPRECATE 1
#endif

/*
 * Uncomment if native integers are 8-bit wide.
 *
#define TROPICSSL_HAVE_INT8
 */

/*
 * Uncomment if native integers are 16-bit wide.
 *
#define TROPICSSL_HAVE_INT16
 */

/*
 * Uncomment if the compiler supports long long.
 *
#define TROPICSSL_HAVE_LONGLONG
 */

/*
 * Uncomment to enable the use of assembly code.
 */
#define TROPICSSL_HAVE_ASM

/*
 * Uncomment if the CPU supports SSE2 (IA-32 specific).
 *
#define TROPICSSL_HAVE_SSE2
 */

/*
 * Enable all SSL/TLS debugging messages.
 */
#define TROPICSSL_DEBUG_MSG

/*
 * Enable the checkup functions (*_self_test).
 */
#define TROPICSSL_SELF_TEST

/*
 * Enable the prime-number generation code.
 */
#define TROPICSSL_GENPRIME

/*
 * Uncomment this macro to store the AES tables in ROM.
 *
#define TROPICSSL_AES_ROM_TABLES
 */

/*
 * Module:  library/aes.c
 * Caller:  library/ssl_tls.c
 *
 * This module enables the following ciphersuites:
 *      SSL_RSA_AES_128_SHA
 *      SSL_RSA_AES_256_SHA
 *      SSL_EDH_RSA_AES_256_SHA
 */
#define TROPICSSL_AES_C

/*
 * Module:  library/arc4.c
 * Caller:  library/ssl_tls.c
 *
 * This module enables the following ciphersuites:
 *      SSL_RSA_RC4_128_MD5
 *      SSL_RSA_RC4_128_SHA
 */
#define TROPICSSL_ARC4_C

/*
 * Module:  library/base64.c
 * Caller:  library/x509parse.c
 *
 * This module is required for X.509 support.
 */
#define TROPICSSL_BASE64_C

/*
 * Module:  library/bignum.c
 * Caller:  library/dhm.c
 *          library/rsa.c
 *          library/ssl_tls.c
 *          library/x509parse.c
 *
 * This module is required for RSA and DHM support.
 */
#define TROPICSSL_BIGNUM_C

/*
 * Module:  library/camellia.c
 * Caller:
 *
 * This module enabled the following cipher suites:
 */
#define TROPICSSL_CAMELLIA_C

/*
 * Module:  library/certs.c
 * Caller:
 *
 * This module is used for testing (ssl_client/server).
 */
#define TROPICSSL_CERTS_C

/*
 * Module:  library/debug.c
 * Caller:  library/ssl_cli.c
 *          library/ssl_srv.c
 *          library/ssl_tls.c
 *
 * This module provides debugging functions.
 */
#define TROPICSSL_DEBUG_C

/*
 * Module:  library/des.c
 * Caller:  library/ssl_tls.c
 *
 * This module enables the following ciphersuites:
 *      SSL_RSA_DES_168_SHA
 *      SSL_EDH_RSA_DES_168_SHA
 */
#define TROPICSSL_DES_C

/*
 * Module:  library/dhm.c
 * Caller:  library/ssl_cli.c
 *          library/ssl_srv.c
 *
 * This module enables the following ciphersuites:
 *      SSL_EDH_RSA_DES_168_SHA
 *      SSL_EDH_RSA_AES_256_SHA
 */
#define TROPICSSL_DHM_C

/*
 * Module:  library/havege.c
 * Caller:
 *
 * This module enables the HAVEGE random number generator.
 */
#define TROPICSSL_HAVEGE_C

/*
 * Module:  library/md2.c
 * Caller:  library/x509parse.c
 *
 * Uncomment to enable support for (rare) MD2-signed X.509 certs.
 *
#define TROPICSSL_MD2_C
 */

/*
 * Module:  library/md4.c
 * Caller:  library/x509parse.c
 *
 * Uncomment to enable support for (rare) MD4-signed X.509 certs.
 *
#define TROPICSSL_MD4_C
 */

/*
 * Module:  library/md5.c
 * Caller:  library/ssl_tls.c
 *          library/x509parse.c
 *
 * This module is required for SSL/TLS and X.509.
 */
#define TROPICSSL_MD5_C

/*
 * Module:  library/net.c
 * Caller:
 *
 * This module provides TCP/IP networking routines.
 */
#define TROPICSSL_NET_C

/*
 * Module:  library/padlock.c
 * Caller:  library/aes.c
 *
 * This modules adds support for the VIA PadLock on x86.
 */
#define TROPICSSL_PADLOCK_C

/*
 * Module:  library/rsa.c
 * Caller:  library/ssl_cli.c
 *          library/ssl_srv.c
 *          library/ssl_tls.c
 *          library/x509.c
 *
 * This module is required for SSL/TLS and MD5-signed certificates.
 */
#define TROPICSSL_RSA_C

/*
 * Module:  library/sha1.c
 * Caller:  library/ssl_cli.c
 *          library/ssl_srv.c
 *          library/ssl_tls.c
 *          library/x509parse.c
 *
 * This module is required for SSL/TLS and SHA1-signed certificates.
 */
#define TROPICSSL_SHA1_C

/*
 * Module:  library/sha2.c
 * Caller:
 *
 * This module adds support for SHA-224 and SHA-256.
 */
#define TROPICSSL_SHA2_C

/*
 * Module:  library/sha4.c
 * Caller:
 *
 * This module adds support for SHA-384 and SHA-512.
 */
#define TROPICSSL_SHA4_C

/*
 * Module:  library/ssl_cli.c
 * Caller:
 *
 * This module is required for SSL/TLS client support.
 */
#define TROPICSSL_SSL_CLI_C

/*
 * Module:  library/ssl_srv.c
 * Caller:
 *
 * This module is required for SSL/TLS server support.
 */
#define TROPICSSL_SSL_SRV_C

/*
 * Module:  library/ssl_tls.c
 * Caller:  library/ssl_cli.c
 *          library/ssl_srv.c
 *
 * This module is required for SSL/TLS.
 */
#define TROPICSSL_SSL_TLS_C

/*
 * Module:  library/timing.c
 * Caller:  library/havege.c
 *
 * This module is used by the HAVEGE random number generator.
 */
#define TROPICSSL_TIMING_C

/*
 * Module:  library/x509parse.c
 * Caller:  library/ssl_cli.c
 *          library/ssl_srv.c
 *          library/ssl_tls.c
 *
 * This module is required for X.509 certificate parsing.
 */
#define TROPICSSL_X509_PARSE_C

/*
 * Module:  library/x509_write.c
 * Caller:
 *
 * This module is required for X.509 certificate writing.
 */
#define TROPICSSL_X509_WRITE_C

/*
 * Module:  library/xtea.c
 * Caller:
 */
#define TROPICSSL_XTEA_C
#endif /* config.h */

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

/*
#include "openssl.h"
*/
