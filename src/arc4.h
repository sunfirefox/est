/*
    arc4.h -- 

    Copyright (c) All Rights Reserved. See details at the end of the file.
 */
#ifndef EST_ARC4_H
#define EST_ARC4_H

/**
 * \brief          ARC4 context structure
 */
typedef struct {
    int x;          /*!< permutation index */
    int y;          /*!< permutation index */
    unsigned char m[256];   /*!< permutation table */
} arc4_context;

#ifdef __cplusplus
extern "C" {
#endif

    /**
     * \brief          ARC4 key schedule
     *
     * \param ctx      ARC4 context to be initialized
     * \param key      the secret key
     * \param keylen   length of the key
     */
    void arc4_setup(arc4_context * ctx, unsigned char *key, int keylen);

    /**
     * \brief          ARC4 cipher function
     *
     * \param ctx      ARC4 context
     * \param buf      buffer to be processed
     * \param buflen   amount of data in buf
     */
    void arc4_crypt(arc4_context * ctx, unsigned char *buf, int buflen);

    /*
     * \brief          Checkup routine
     *
     * \return         0 if successful, or 1 if the test failed
     */
    int arc4_self_test(int verbose);

#ifdef __cplusplus
}
#endif
#endif              /* arc4.h */

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
