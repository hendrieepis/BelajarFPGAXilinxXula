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
static const char *ng0 = "/home/hendri/Documents/workspaceXilinx/PBsegmentV2/decoder.vhd";



static void work_a_2263464102_3212880686_p_0(char *t0)
{
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    int t10;
    char *t11;
    char *t12;
    int t13;
    char *t14;
    int t16;
    char *t17;
    int t19;
    char *t20;
    int t22;
    char *t23;
    int t25;
    char *t26;
    int t28;
    char *t29;
    int t31;
    char *t32;
    int t34;
    char *t35;
    int t37;
    char *t38;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;

LAB0:    xsi_set_current_line(43, ng0);
    t2 = (t0 + 568U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 1604);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(44, ng0);
    t4 = (t0 + 684U);
    t8 = *((char **)t4);
    t4 = (t0 + 2921);
    t10 = xsi_mem_cmp(t4, t8, 4U);
    if (t10 == 1)
        goto LAB9;

LAB20:    t11 = (t0 + 2925);
    t13 = xsi_mem_cmp(t11, t8, 4U);
    if (t13 == 1)
        goto LAB10;

LAB21:    t14 = (t0 + 2929);
    t16 = xsi_mem_cmp(t14, t8, 4U);
    if (t16 == 1)
        goto LAB11;

LAB22:    t17 = (t0 + 2933);
    t19 = xsi_mem_cmp(t17, t8, 4U);
    if (t19 == 1)
        goto LAB12;

LAB23:    t20 = (t0 + 2937);
    t22 = xsi_mem_cmp(t20, t8, 4U);
    if (t22 == 1)
        goto LAB13;

LAB24:    t23 = (t0 + 2941);
    t25 = xsi_mem_cmp(t23, t8, 4U);
    if (t25 == 1)
        goto LAB14;

LAB25:    t26 = (t0 + 2945);
    t28 = xsi_mem_cmp(t26, t8, 4U);
    if (t28 == 1)
        goto LAB15;

LAB26:    t29 = (t0 + 2949);
    t31 = xsi_mem_cmp(t29, t8, 4U);
    if (t31 == 1)
        goto LAB16;

LAB27:    t32 = (t0 + 2953);
    t34 = xsi_mem_cmp(t32, t8, 4U);
    if (t34 == 1)
        goto LAB17;

LAB28:    t35 = (t0 + 2957);
    t37 = xsi_mem_cmp(t35, t8, 4U);
    if (t37 == 1)
        goto LAB18;

LAB29:
LAB19:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 3031);
    t5 = (t0 + 1648);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t11 = (t9 + 32U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 7U);
    xsi_driver_first_trans_fast_port(t5);

LAB8:    goto LAB3;

LAB5:    t4 = (t0 + 592U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB9:    xsi_set_current_line(46, ng0);
    t38 = (t0 + 2961);
    t40 = (t0 + 1648);
    t41 = (t40 + 32U);
    t42 = *((char **)t41);
    t43 = (t42 + 32U);
    t44 = *((char **)t43);
    memcpy(t44, t38, 7U);
    xsi_driver_first_trans_fast_port(t40);
    goto LAB8;

LAB10:    xsi_set_current_line(47, ng0);
    t2 = (t0 + 2968);
    t5 = (t0 + 1648);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t11 = (t9 + 32U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 7U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB8;

LAB11:    xsi_set_current_line(48, ng0);
    t2 = (t0 + 2975);
    t5 = (t0 + 1648);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t11 = (t9 + 32U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 7U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB8;

LAB12:    xsi_set_current_line(49, ng0);
    t2 = (t0 + 2982);
    t5 = (t0 + 1648);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t11 = (t9 + 32U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 7U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB8;

LAB13:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 2989);
    t5 = (t0 + 1648);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t11 = (t9 + 32U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 7U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB8;

LAB14:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 2996);
    t5 = (t0 + 1648);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t11 = (t9 + 32U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 7U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB8;

LAB15:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 3003);
    t5 = (t0 + 1648);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t11 = (t9 + 32U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 7U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB8;

LAB16:    xsi_set_current_line(53, ng0);
    t2 = (t0 + 3010);
    t5 = (t0 + 1648);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t11 = (t9 + 32U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 7U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB8;

LAB17:    xsi_set_current_line(54, ng0);
    t2 = (t0 + 3017);
    t5 = (t0 + 1648);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t11 = (t9 + 32U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 7U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB8;

LAB18:    xsi_set_current_line(55, ng0);
    t2 = (t0 + 3024);
    t5 = (t0 + 1648);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t11 = (t9 + 32U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 7U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB8;

LAB30:;
}


extern void work_a_2263464102_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2263464102_3212880686_p_0};
	xsi_register_didat("work_a_2263464102_3212880686", "isim/decoderTestbench_isim_beh.exe.sim/work/a_2263464102_3212880686.didat");
	xsi_register_executes(pe);
}
