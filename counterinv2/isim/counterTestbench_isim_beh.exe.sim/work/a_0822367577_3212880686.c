/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/hendri/Documents/workspaceXilinx/counterinv/inverter.vhd";
extern char *IEEE_P_2592010699;

char *ieee_p_2592010699_sub_1837678034_503743352(char *, char *, char *, char *);


static void work_a_0822367577_3212880686_p_0(char *t0)
{
    char t1[16];
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned char t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    xsi_set_current_line(43, ng0);
    t2 = (t0 + 592U);
    t3 = *((char **)t2);
    t2 = (t0 + 2708U);
    t4 = ieee_p_2592010699_sub_1837678034_503743352(IEEE_P_2592010699, t1, t3, t2);
    t5 = (t1 + 12U);
    t6 = *((unsigned int *)t5);
    t7 = (1U * t6);
    t8 = (8U != t7);
    if (t8 == 1)
        goto LAB2;

LAB3:    t9 = (t0 + 1556);
    t10 = (t9 + 32U);
    t11 = *((char **)t10);
    t12 = (t11 + 32U);
    t13 = *((char **)t12);
    memcpy(t13, t4, 8U);
    xsi_driver_first_trans_fast_port(t9);
    t2 = (t0 + 1512);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_size_not_matching(8U, t7, 0);
    goto LAB3;

}


extern void work_a_0822367577_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0822367577_3212880686_p_0};
	xsi_register_didat("work_a_0822367577_3212880686", "isim/counterTestbench_isim_beh.exe.sim/work/a_0822367577_3212880686.didat");
	xsi_register_executes(pe);
}
