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
static const char *ng0 = "/home/hendri/Documents/workspaceXilinx/PBsegmentV2/decoderTestbench.vhd";
extern char *IEEE_P_3499444699;

char *ieee_p_3499444699_sub_2213602152_3536714472(char *, char *, int , int );


static void work_a_2201433240_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 1492U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(74, ng0);
    t2 = (t0 + 1844);
    t3 = (t2 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(75, ng0);
    t2 = (t0 + 948U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 1392);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(76, ng0);
    t2 = (t0 + 1844);
    t3 = (t2 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(77, ng0);
    t2 = (t0 + 948U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 1392);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_2201433240_2372691052_p_1(char *t0)
{
    char t6[16];
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned char t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    int64 t17;
    int64 t18;
    int t19;

LAB0:    t1 = (t0 + 1628U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(102, ng0);
    t2 = (t0 + 3536);
    *((int *)t2) = 0;
    t3 = (t0 + 3540);
    *((int *)t3) = 9;
    t4 = 0;
    t5 = 9;

LAB4:    if (t4 <= t5)
        goto LAB5;

LAB7:    goto LAB2;

LAB5:    xsi_set_current_line(103, ng0);
    t7 = (t0 + 3536);
    t8 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t6, *((int *)t7), 4);
    t9 = (t6 + 12U);
    t10 = *((unsigned int *)t9);
    t10 = (t10 * 1U);
    t11 = (4U != t10);
    if (t11 == 1)
        goto LAB8;

LAB9:    t12 = (t0 + 1880);
    t13 = (t12 + 32U);
    t14 = *((char **)t13);
    t15 = (t14 + 32U);
    t16 = *((char **)t15);
    memcpy(t16, t8, 4U);
    xsi_driver_first_trans_fast(t12);
    xsi_set_current_line(104, ng0);
    t2 = (t0 + 948U);
    t3 = *((char **)t2);
    t17 = *((int64 *)t3);
    t18 = (t17 / 3);
    t2 = (t0 + 1528);
    xsi_process_wait(t2, t18);

LAB12:    *((char **)t1) = &&LAB13;

LAB1:    return;
LAB6:    t2 = (t0 + 3536);
    t4 = *((int *)t2);
    t3 = (t0 + 3540);
    t5 = *((int *)t3);
    if (t4 == t5)
        goto LAB7;

LAB14:    t19 = (t4 + 1);
    t4 = t19;
    t7 = (t0 + 3536);
    *((int *)t7) = t4;
    goto LAB4;

LAB8:    xsi_size_not_matching(4U, t10, 0);
    goto LAB9;

LAB10:    goto LAB6;

LAB11:    goto LAB10;

LAB13:    goto LAB11;

}


extern void work_a_2201433240_2372691052_init()
{
	static char *pe[] = {(void *)work_a_2201433240_2372691052_p_0,(void *)work_a_2201433240_2372691052_p_1};
	xsi_register_didat("work_a_2201433240_2372691052", "isim/decoderTestbench_isim_beh.exe.sim/work/a_2201433240_2372691052.didat");
	xsi_register_executes(pe);
}
