/*
    debug.c -- Debugging routines

    Copyright (c) All Rights Reserved. See details at the end of the file.
 */
#include "est.h"

#if BIT_EST_LOGGING

#if defined _MSC_VER && !defined  snprintf
#define  snprintf  _snprintf
#endif

#if defined _MSC_VER && !defined vsnprintf
#define vsnprintf _vsnprintf
#endif

char *debug_fmt(cchar *format, ...)
{
    va_list argp;
    static char str[512];
    int maxlen = sizeof(str) - 1;

    va_start(argp, format);
    vsnprintf(str, maxlen, format, argp);
    va_end(argp);

    str[maxlen] = '\0';
    return str;
}

void debug_print_msg(ssl_context * ssl, int level,
             char *file, int line, char *text)
{
    char str[512];
    int maxlen = sizeof(str) - 1;

    if (ssl->f_dbg == NULL)
        return;

    snprintf(str, maxlen, "%s(%04d): %s\n", file, line, text);
    str[maxlen] = '\0';
    ssl->f_dbg(ssl->p_dbg, level, str);
}

void debug_print_ret(ssl_context * ssl, int level,
             char *file, int line, char *text, int ret)
{
    char str[512];
    int maxlen = sizeof(str) - 1;

    if (ssl->f_dbg == NULL)
        return;

    snprintf(str, maxlen, "%s(%04d): %s() returned %d (0x%x)\n",
         file, line, text, ret, ret);

    str[maxlen] = '\0';
    ssl->f_dbg(ssl->p_dbg, level, str);
}

void debug_print_buf(ssl_context * ssl, int level,
             char *file, int line, char *text,
             uchar *buf, int len)
{
    char str[512];
    int i, maxlen = sizeof(str) - 1;

    if (ssl->f_dbg == NULL || len < 0)
        return;

    snprintf(str, maxlen, "%s(%04d): dumping '%s' (%d bytes)\n",
         file, line, text, len);

    str[maxlen] = '\0';
    ssl->f_dbg(ssl->p_dbg, level, str);

    for (i = 0; i < len; i++) {
        if (i >= 4096)
            break;

        if (i % 16 == 0) {
            if (i > 0)
                ssl->f_dbg(ssl->p_dbg, level, "\n");

            snprintf(str, maxlen, "%s(%04d): %04x: ", file, line,
                 i);

            str[maxlen] = '\0';
            ssl->f_dbg(ssl->p_dbg, level, str);
        }

        snprintf(str, maxlen, " %02x", (uint)buf[i]);

        str[maxlen] = '\0';
        ssl->f_dbg(ssl->p_dbg, level, str);
    }

    if (len > 0)
        ssl->f_dbg(ssl->p_dbg, level, "\n");
}

void debug_print_mpi(ssl_context * ssl, int level,
             char *file, int line, char *text, mpi * X)
{
    char str[512];
    int i, j, k, n, maxlen = sizeof(str) - 1;

    if (ssl->f_dbg == NULL || X == NULL)
        return;

    for (n = X->n - 1; n >= 0; n--)
        if (X->p[n] != 0)
            break;

    snprintf(str, maxlen, "%s(%04d): value of '%s' (%u bits) is:\n", file, line, text, 
            (int) ((n + 1) * sizeof(t_int)) << 3);

    str[maxlen] = '\0';
    ssl->f_dbg(ssl->p_dbg, level, str);

    for (i = n, j = 0; i >= 0; i--, j++) {
        if (j % (16 / sizeof(t_int)) == 0) {
            if (j > 0)
                ssl->f_dbg(ssl->p_dbg, level, "\n");

            snprintf(str, maxlen, "%s(%04d): ", file, line);

            str[maxlen] = '\0';
            ssl->f_dbg(ssl->p_dbg, level, str);
        }

        for (k = sizeof(t_int) - 1; k >= 0; k--) {
            snprintf(str, maxlen, " %02x", (uint)
                 (X->p[i] >> (k << 3)) & 0xFF);

            str[maxlen] = '\0';
            ssl->f_dbg(ssl->p_dbg, level, str);
        }
    }

    ssl->f_dbg(ssl->p_dbg, level, "\n");
}

void debug_print_crt(ssl_context * ssl, int level,
             char *file, int line, char *text, x509_cert * crt)
{
    char str[512], prefix[64], *p;
    int i = 0, maxlen = sizeof(prefix) - 1;

    if (ssl->f_dbg == NULL || crt == NULL)
        return;

    snprintf(prefix, maxlen, "%s(%04d): ", file, line);
    prefix[maxlen] = '\0';
    maxlen = sizeof(str) - 1;

    while (crt != NULL && crt->next != NULL) {
        p = x509parse_cert_info(prefix, crt);

        snprintf(str, maxlen, "%s(%04d): %s #%d:\n%s",
             file, line, text, ++i, p);

        str[maxlen] = '\0';
        ssl->f_dbg(ssl->p_dbg, level, str);

        debug_print_mpi(ssl, level, file, line,
                "crt->rsa.N", &crt->rsa.N);

        debug_print_mpi(ssl, level, file, line,
                "crt->rsa.E", &crt->rsa.E);

        crt = crt->next;
    }
}

#endif

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
