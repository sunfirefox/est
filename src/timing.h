/*
    timing.h -- 

    Copyright (c) All Rights Reserved. See details at the end of the file.
 */
#ifndef EST_TIMING_H
#define EST_TIMING_H

/**
 * \brief          timer structure
 */
struct hr_time {
    unsigned char opaque[32];
};

#ifdef __cplusplus
extern "C" {
#endif

    extern int alarmed;

    /**
     * \brief          Return the CPU cycle counter value
     */
    unsigned long hardclock(void);

    /**
     * \brief          Return the elapsed time in milliseconds
     *
     * \param val      points to a timer structure
     * \param reset    if set to 1, the timer is restarted
     */
    unsigned long get_timer(struct hr_time *val, int reset);

    /**
     * \brief          Setup an alarm clock
     *
     * \param seconds  delay before the "alarmed" flag is set
     */
    void set_alarm(int seconds);

    /**
     * \brief          Sleep for a certain amount of time
     */
    void m_sleep(int milliseconds);

#ifdef __cplusplus
}
#endif
#endif              /* timing.h */

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
