/*
    timing.c -- Portable interface to the CPU cycle counter

    MOB - rename file

    Copyright (c) All Rights Reserved. See details at the end of the file.
 */
#include "est.h"

#if BIT_EST_TIMING

#if defined(WIN32)

#include <windows.h>
#include <winbase.h>

struct _hr_time {
    LARGE_INTEGER start;
};

#else

#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>
#include <signal.h>
#include <time.h>

struct _hr_time {
    struct timeval start;
};

#endif

//  MOB -- fix
#if UNUSED && (defined(_MSC_VER) && defined(_M_IX86)) || defined(__WATCOMC__)

ulong hardclock(void)
{
    ulong tsc;
    __asm rdtsc __asm mov[tsc], eax return (tsc);
}

#else
#if defined(__GNUC__) && defined(__i386__)

ulong hardclock(void)
{
    ulong tsc;
asm("rdtsc":"=a"(tsc));
    return (tsc);
}

#else
#if defined(__GNUC__) && (defined(__amd64__) || defined(__x86_64__))

ulong hardclock(void)
{
    ulong lo, hi;
asm("rdtsc":"=a"(lo), "=d"(hi));
    return (lo | (hi << 32));
}

#else
#if defined(__GNUC__) && (defined(__powerpc__) || defined(__ppc__))

ulong hardclock(void)
{
    ulong tbl, tbu0, tbu1;

    do {
asm("mftbu %0":"=r"(tbu0));
asm("mftb   %0":"=r"(tbl));
asm("mftbu %0":"=r"(tbu1));
    } while (tbu0 != tbu1);

    return (tbl);
}

#else
#if defined(__GNUC__) && defined(__sparc__)

ulong hardclock(void)
{
    ulong tick;
    asm(".byte 0x83, 0x41, 0x00, 0x00");
asm("mov    %%g1, %0":"=r"(tick));
    return (tick);
}

#else
#if defined(__GNUC__) && defined(__alpha__)

ulong hardclock(void)
{
    ulong cc;
asm("rpcc %0":"=r"(cc));
    return (cc & 0xFFFFFFFF);
}

#else
#if defined(__GNUC__) && defined(__ia64__)

ulong hardclock(void)
{
    ulong itc;
asm("mov %0 = ar.itc":"=r"(itc));
    return (itc);
}

#else

static int hardclock_init = 0;
static struct timeval tv_init;

ulong hardclock(void)
{
    struct timeval tv_cur;

    if (hardclock_init == 0) {
        gettimeofday(&tv_init, NULL);
        hardclock_init = 1;
    }

    gettimeofday(&tv_cur, NULL);
    return ((tv_cur.tv_sec - tv_init.tv_sec) * 1000000
        + (tv_cur.tv_usec - tv_init.tv_usec));
}

#endif /* generic */
#endif /* IA-64   */
#endif /* Alpha   */
#endif /* SPARC8  */
#endif /* PowerPC */
#endif /* AMD64   */
#endif /* i586+   */

int alarmed = 0;

#if defined(WIN32)

ulong get_timer(struct hr_time *val, int reset)
{
    ulong delta;
    LARGE_INTEGER offset, hfreq;
    struct _hr_time *t = (struct _hr_time *)val;

    QueryPerformanceCounter(&offset);
    QueryPerformanceFrequency(&hfreq);

    delta = (ulong)((1000 *
                 (offset.QuadPart - t->start.QuadPart)) /
                hfreq.QuadPart);

    if (reset)
        QueryPerformanceCounter(&t->start);

    return (delta);
}

DWORD WINAPI TimerProc(LPVOID uElapse)
{
    Sleep((DWORD) uElapse);
    alarmed = 1;
    return (TRUE);
}

void set_alarm(int seconds)
{
    DWORD ThreadId;

    alarmed = 0;
    CloseHandle(CreateThread(NULL, 0, TimerProc,
                 (LPVOID) (seconds * 1000), 0, &ThreadId));
}

void m_sleep(int milliseconds)
{
    Sleep(milliseconds);
}

#else

ulong get_timer(struct hr_time *val, int reset)
{
    ulong delta;
    struct timeval offset;
    struct _hr_time *t = (struct _hr_time *)val;

    gettimeofday(&offset, NULL);

    delta = (offset.tv_sec - t->start.tv_sec) * 1000
        + (offset.tv_usec - t->start.tv_usec) / 1000;

    if (reset) {
        t->start.tv_sec = offset.tv_sec;
        t->start.tv_usec = offset.tv_usec;
    }

    return (delta);
}

static void sighandler(int signum)
{
    alarmed = 1;
    signal(signum, sighandler);
}

void set_alarm(int seconds)
{
    alarmed = 0;
    signal(SIGALRM, sighandler);
    alarm(seconds);
}

void m_sleep(int milliseconds)
{
    struct timeval tv;

    tv.tv_sec = milliseconds / 1000;
    tv.tv_usec = milliseconds * 1000;

    select(0, NULL, NULL, NULL, &tv);
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
