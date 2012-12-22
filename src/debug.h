/*
    debug.h -- Debugging support

    Copyright (c) All Rights Reserved. See details at the end of the file.
 */
#ifndef SSL_DEBUG_H
#define SSL_DEBUG_H

#if BIT_LOGGING
#define SSL_DEBUG_MSG( level, args )                    \
    debug_print_msg( ssl, level, __FILE__, __LINE__, debug_fmt args );

#define SSL_DEBUG_RET( level, text, ret )                \
    debug_print_ret( ssl, level, __FILE__, __LINE__, text, ret );

#define SSL_DEBUG_BUF( level, text, buf, len )           \
    debug_print_buf( ssl, level, __FILE__, __LINE__, text, buf, len );

#define SSL_DEBUG_MPI( level, text, X )                  \
    debug_print_mpi( ssl, level, __FILE__, __LINE__, text, X );

#define SSL_DEBUG_CRT( level, text, crt )                \
    debug_print_crt( ssl, level, __FILE__, __LINE__, text, crt );
#else

#define SSL_DEBUG_MSG( level, args )            do { } while( 0 )
#define SSL_DEBUG_RET( level, text, ret )       do { } while( 0 )
#define SSL_DEBUG_BUF( level, text, buf, len )  do { } while( 0 )
#define SSL_DEBUG_MPI( level, text, X )         do { } while( 0 )
#define SSL_DEBUG_CRT( level, text, crt )       do { } while( 0 )
#endif

#ifdef __cplusplus
extern "C" {
#endif

    char *debug_fmt(const char *format, ...);
    void debug_print_msg(ssl_context * ssl, int level, char *file, int line, char *text);
    void debug_print_ret(ssl_context * ssl, int level, char *file, int line, char *text, int ret);
    void debug_print_buf(ssl_context * ssl, int level, char *file, int line, char *text, uchar *buf, int len);
    void debug_print_mpi(ssl_context * ssl, int level, char *file, int line, char *text, mpi * X);
    void debug_print_crt(ssl_context * ssl, int level, char *file, int line, char *text, x509_cert * crt);

#ifdef __cplusplus
}
#endif
#endif  /* debug.h */

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
