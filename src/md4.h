/*
    md4.h -- 

    Copyright (c) All Rights Reserved. See details at the end of the file.
 */
#ifndef EST_MD4_H
#define EST_MD4_H

/**
 * \brief          MD4 context structure
 */
typedef struct {
    unsigned long total[2]; /*!< number of bytes processed  */
    unsigned long state[4]; /*!< intermediate digest state  */
    unsigned char buffer[64];   /*!< data block being processed */

    unsigned char ipad[64]; /*!< HMAC: inner padding        */
    unsigned char opad[64]; /*!< HMAC: outer padding        */
} md4_context;

#ifdef __cplusplus
extern "C" {
#endif

    /**
     * \brief          MD4 context setup
     *
     * \param ctx      context to be initialized
     */
    void md4_starts(md4_context * ctx);

    /**
     * \brief          MD4 process buffer
     *
     * \param ctx      MD4 context
     * \param input    buffer holding the  data
     * \param ilen     length of the input data
     */
    void md4_update(md4_context * ctx, unsigned char *input, int ilen);

    /**
     * \brief          MD4 final digest
     *
     * \param ctx      MD4 context
     * \param output   MD4 checksum result
     */
    void md4_finish(md4_context * ctx, unsigned char output[16]);

    /**
     * \brief          Output = MD4( input buffer )
     *
     * \param input    buffer holding the  data
     * \param ilen     length of the input data
     * \param output   MD4 checksum result
     */
    void md4(unsigned char *input, int ilen, unsigned char output[16]);

    /**
     * \brief          Output = MD4( file contents )
     *
     * \param path     input file name
     * \param output   MD4 checksum result
     *
     * \return         0 if successful, 1 if fopen failed,
     *                 or 2 if fread failed
     */
    int md4_file(char *path, unsigned char output[16]);

    /**
     * \brief          MD4 HMAC context setup
     *
     * \param ctx      HMAC context to be initialized
     * \param key      HMAC secret key
     * \param keylen   length of the HMAC key
     */
    void md4_hmac_starts(md4_context * ctx, unsigned char *key, int keylen);

    /**
     * \brief          MD4 HMAC process buffer
     *
     * \param ctx      HMAC context
     * \param input    buffer holding the  data
     * \param ilen     length of the input data
     */
    void md4_hmac_update(md4_context * ctx, unsigned char *input, int ilen);

    /**
     * \brief          MD4 HMAC final digest
     *
     * \param ctx      HMAC context
     * \param output   MD4 HMAC checksum result
     */
    void md4_hmac_finish(md4_context * ctx, unsigned char output[16]);

    /**
     * \brief          Output = HMAC-MD4( hmac key, input buffer )
     *
     * \param key      HMAC secret key
     * \param keylen   length of the HMAC key
     * \param input    buffer holding the  data
     * \param ilen     length of the input data
     * \param output   HMAC-MD4 result
     */
    void md4_hmac(unsigned char *key, int keylen,
              unsigned char *input, int ilen, unsigned char output[16]);

    /**
     * \brief          Checkup routine
     *
     * \return         0 if successful, or 1 if the test failed
     */
    int md4_self_test(int verbose);

#ifdef __cplusplus
}
#endif
#endif              /* md4.h */

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
