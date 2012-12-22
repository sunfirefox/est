/*
    sha2sum.c -- 

    Copyright (c) All Rights Reserved. See details at the end of the file.
 */
#ifndef _CRT_SECURE_NO_DEPRECATE
#define _CRT_SECURE_NO_DEPRECATE 1
#endif

#include <string.h>
#include <stdio.h>

#include "tropicssl/sha2.h"

static int sha2_wrapper(char *filename, unsigned char *sum)
{
	int ret = sha2_file(filename, sum, 0);

	if (ret == 1)
		fprintf(stderr, "failed to open: %s\n", filename);

	if (ret == 2)
		fprintf(stderr, "failed to read: %s\n", filename);

	return (ret);
}

static int sha2_print(char *filename)
{
	int i;
	unsigned char sum[32];

	if (sha2_wrapper(filename, sum) != 0)
		return (1);

	for (i = 0; i < 32; i++)
		printf("%02x", sum[i]);

	printf("  %s\n", filename);
	return (0);
}

static int sha2_check(char *filename)
{
	int i;
	size_t n;
	FILE *f;
	int nb_err1, nb_err2;
	int nb_tot1, nb_tot2;
	unsigned char sum[32];
	char buf[65], line[1024];

	if ((f = fopen(filename, "rb")) == NULL) {
		printf("failed to open: %s\n", filename);
		return (1);
	}

	nb_err1 = nb_err2 = 0;
	nb_tot1 = nb_tot2 = 0;

	memset(line, 0, sizeof(line));

	n = sizeof(line);

	while (fgets(line, n - 1, f) != NULL) {
		n = strlen(line);

		if (n < 68)
			continue;

		if (line[64] != ' ' || line[65] != ' ')
			continue;

		if (line[n - 1] == '\n') {
			n--;
			line[n] = '\0';
		}
		if (line[n - 1] == '\r') {
			n--;
			line[n] = '\0';
		}

		nb_tot1++;

		if (sha2_wrapper(line + 66, sum) != 0) {
			nb_err1++;
			continue;
		}

		nb_tot2++;

		for (i = 0; i < 32; i++)
			sprintf(buf + i * 2, "%02x", sum[i]);

		if (memcmp(line, buf, 64) != 0) {
			nb_err2++;
			fprintf(stderr, "wrong checksum: %s\n", line + 66);
		}

		n = sizeof(line);
	}

	if (nb_err1 != 0) {
		printf("WARNING: %d (out of %d) input files could "
		       "not be read\n", nb_err1, nb_tot1);
	}

	if (nb_err2 != 0) {
		printf("WARNING: %d (out of %d) computed checksums did "
		       "not match\n", nb_err2, nb_tot2);
	}

	return (nb_err1 != 0 || nb_err2 != 0);
}

int main(int argc, char *argv[])
{
	int ret, i;

	if (argc == 1) {
		printf("print mode:  sha2sum <file> <file> ...\n");
		printf("check mode:  sha2sum -c <checksum file>\n");

#ifdef WIN32
		printf("\n  Press Enter to exit this program.\n");
		fflush(stdout);
		getchar();
#endif

		return (1);
	}

	if (argc == 3 && strcmp("-c", argv[1]) == 0)
		return (sha2_check(argv[2]));

	ret = 0;
	for (i = 1; i < argc; i++)
		ret |= sha2_print(argv[i]);

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
