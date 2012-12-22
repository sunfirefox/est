/*
    arc4.c -- An implementation of the ARCFOUR algorithm

    The ARCFOUR algorithm was publicly disclosed on 94/09.

    http://groups.google.com/group/sci.crypt/msg/10a300c9d21afca0

    Copyright (c) All Rights Reserved. See details at the end of the file.
 */
#include "est.h"

#if BIT_RC4

/*
 * ARC4 key schedule
 */
void arc4_setup(arc4_context * ctx, uchar *key, int keylen)
{
    int i, j, k, a;
    uchar *m;

    ctx->x = 0;
    ctx->y = 0;
    m = ctx->m;

    for (i = 0; i < 256; i++)
        m[i] = (uchar)i;

    j = k = 0;

    for (i = 0; i < 256; i++, k++) {
        if (k >= keylen)
            k = 0;

        a = m[i];
        j = (j + a + key[k]) & 0xFF;
        m[i] = m[j];
        m[j] = (uchar)a;
    }
}

/*
 * ARC4 cipher function
 */
void arc4_crypt(arc4_context * ctx, uchar *buf, int buflen)
{
    int i, x, y, a, b;
    uchar *m;

    x = ctx->x;
    y = ctx->y;
    m = ctx->m;

    for (i = 0; i < buflen; i++) {
        x = (x + 1) & 0xFF;
        a = m[x];
        y = (y + a) & 0xFF;
        b = m[y];

        m[x] = (uchar)b;
        m[y] = (uchar)a;

        buf[i] = (uchar)
            (buf[i] ^ m[(uchar)(a + b)]);
    }

    ctx->x = x;
    ctx->y = y;
}

#if defined(BIT_SELF_TEST)

/*
 * ARC4 tests vectors as posted by Eric Rescorla in sep. 1994:
 *
 * http://groups.google.com/group/comp.security.misc/msg/10a300c9d21afca0
 */
static const uchar arc4_test_key[3][8] = {
    {0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF},
    {0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF},
    {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
};

static const uchar arc4_test_pt[3][8] = {
    {0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF},
    {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
    {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}
};

static const uchar arc4_test_ct[3][8] = {
    {0x75, 0xB7, 0x87, 0x80, 0x99, 0xE0, 0xC5, 0x96},
    {0x74, 0x94, 0xC2, 0xE7, 0x10, 0x4B, 0x08, 0x79},
    {0xDE, 0x18, 0x89, 0x41, 0xA3, 0x37, 0x5D, 0x3A}
};

/*
 * Checkup routine
 */
int arc4_self_test(int verbose)
{
    int i;
    uchar buf[8];
    arc4_context ctx;

    for (i = 0; i < 3; i++) {
        if (verbose != 0)
            printf("  ARC4 test #%d: ", i + 1);

        memcpy(buf, arc4_test_pt[i], 8);

        arc4_setup(&ctx, (uchar *)arc4_test_key[i], 8);
        arc4_crypt(&ctx, buf, 8);

        if (memcmp(buf, arc4_test_ct[i], 8) != 0) {
            if (verbose != 0)
                printf("failed\n");

            return (1);
        }

        if (verbose != 0)
            printf("passed\n");
    }

    if (verbose != 0)
        printf("\n");

    return (0);
}

#endif

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
