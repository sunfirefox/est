/*
    ssl_client1.c -- SSL client demonstration program

    Copyright (c) All Rights Reserved. See details at the end of the file.
 */
#ifndef _CRT_SECURE_NO_DEPRECATE
#define _CRT_SECURE_NO_DEPRECATE 1
#endif

#include <string.h>
#include <stdio.h>

#include "tropicssl/net.h"
#include "tropicssl/ssl.h"
#include "tropicssl/havege.h"

#define SERVER_PORT 443
/*
#define SERVER_NAME "localhost"
#define GET_REQUEST "GET / HTTP/1.0\r\n\r\n"
*/
#define SERVER_NAME "tropicssl.org"
#define GET_REQUEST \
    "GET /hello/ HTTP/1.1\r\n" \
    "Host: tropicssl.org\r\n\r\n"

#define DEBUG_LEVEL 0

void my_debug(void *ctx, int level, char *str)
{
	if (level < DEBUG_LEVEL) {
		fprintf((FILE *) ctx, "%s", str);
		fflush((FILE *) ctx);
	}
}

int main(void)
{
	int ret, len, server_fd;
	unsigned char buf[1024];
	havege_state hs;
	ssl_context ssl;
	ssl_session ssn;

	/*
	 * 0. Initialize the RNG and the session data
	 */
	havege_init(&hs);
	memset(&ssn, 0, sizeof(ssl_session));

	/*
	 * 1. Start the connection
	 */
	printf("\n  . Connecting to tcp/%s/%4d...", SERVER_NAME, SERVER_PORT);
	fflush(stdout);

	if ((ret = net_connect(&server_fd, SERVER_NAME, SERVER_PORT)) != 0) {
		printf(" failed\n  ! net_connect returned %d\n\n", ret);
		goto exit;
	}

	printf(" ok\n");

	/*
	 * 2. Setup stuff
	 */
	printf("  . Setting up the SSL/TLS structure...");
	fflush(stdout);

	if ((ret = ssl_init(&ssl)) != 0) {
		printf(" failed\n  ! ssl_init returned %d\n\n", ret);
		goto exit;
	}

	printf(" ok\n");

	ssl_set_endpoint(&ssl, SSL_IS_CLIENT);
	ssl_set_authmode(&ssl, SSL_VERIFY_NONE);

	ssl_set_rng(&ssl, havege_rand, &hs);
	ssl_set_dbg(&ssl, my_debug, stdout);
	ssl_set_bio(&ssl, net_recv, &server_fd, net_send, &server_fd);

	ssl_set_ciphers(&ssl, ssl_default_ciphers);
	ssl_set_session(&ssl, 1, 600, &ssn);

	/*
	 * 3. Write the GET request
	 */
	printf("  > Write to server:");
	fflush(stdout);

	len = sprintf((char *)buf, GET_REQUEST);

	while ((ret = ssl_write(&ssl, buf, len)) <= 0) {
		if (ret != TROPICSSL_ERR_NET_TRY_AGAIN) {
			printf(" failed\n  ! ssl_write returned %d\n\n", ret);
			goto exit;
		}
	}

	len = ret;
	printf(" %d bytes written\n\n%s", len, (char *)buf);

	/*
	 * 7. Read the HTTP response
	 */
	printf("  < Read from server:");
	fflush(stdout);

	do {
		len = sizeof(buf) - 1;
		memset(buf, 0, sizeof(buf));
		ret = ssl_read(&ssl, buf, len);

		if (ret == TROPICSSL_ERR_NET_TRY_AGAIN)
			continue;

		if (ret == TROPICSSL_ERR_SSL_PEER_CLOSE_NOTIFY)
			break;

		if (ret <= 0) {
			printf("failed\n  ! ssl_read returned %d\n\n", ret);
			break;
		}

		len = ret;
		printf(" %d bytes read\n\n%s", len, (char *)buf);
	}
	while (0);

	ssl_close_notify(&ssl);

exit:

	net_close(server_fd);
	ssl_free(&ssl);

	memset(&ssl, 0, sizeof(ssl));

#ifdef WIN32
	printf("  + Press Enter to exit this program.\n");
	fflush(stdout);
	getchar();
#endif

	return (ret);
}

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
