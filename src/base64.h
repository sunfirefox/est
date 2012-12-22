/*
    base64.h -- Header for the Multithreaded Portable Runtime (MPR).

    Copyright (c) All Rights Reserved. See details at the end of the file.
 */
#ifndef EST_BASE64_H
#define EST_BASE64_H

#define EST_ERR_BASE64_BUFFER_TOO_SMALL               -0x0010
#define EST_ERR_BASE64_INVALID_CHARACTER              -0x0012

#ifdef __cplusplus
extern "C" {
#endif

    /**
     * \brief          Encode a buffer into base64 format
     *
     * \param dst      destination buffer
     * \param dlen     size of the buffer
     * \param src      source buffer
     * \param slen     amount of data to be encoded
     *
     * \return         0 if successful, or EST_ERR_BASE64_BUFFER_TOO_SMALL.
     *                 *dlen is always updated to reflect the amount
     *                 of data that has (or would have) been written.
     *
     * \note           Call this function with *dlen = 0 to obtain the
     *                 required buffer size in *dlen
     */
    int base64_encode(unsigned char *dst, int *dlen,
              unsigned char *src, int slen);

    /**
     * \brief          Decode a base64-formatted buffer
     *
     * \param dst      destination buffer
     * \param dlen     size of the buffer
     * \param src      source buffer
     * \param slen     amount of data to be decoded
     *
     * \return         0 if successful, EST_ERR_BASE64_BUFFER_TOO_SMALL, or
     *                 EST_ERR_BASE64_INVALID_DATA if the input data is not
     *                 correct. *dlen is always updated to reflect the amount
     *                 of data that has (or would have) been written.
     *
     * \note           Call this function with *dlen = 0 to obtain the
     *                 required buffer size in *dlen
     */
    int base64_decode(unsigned char *dst, int *dlen,
              unsigned char *src, int slen);

    /**
     * \brief          Checkup routine
     *
     * \return         0 if successful, or 1 if the test failed
     */
    int base64_self_test(int verbose);

#ifdef __cplusplus
}
#endif
#endif              /* base64.h */
