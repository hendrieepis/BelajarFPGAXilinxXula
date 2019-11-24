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
static const char *ng0 = "/home/hendri/Documents/workspaceXilinx/countersegment/counter.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_2592010699_sub_2507238156_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_3620187407_sub_2546382208_3965413181(char *, char *, char *, int );
unsigned char ieee_p_3620187407_sub_4058165771_3965413181(char *, char *, char *, char *, char *);
char *ieee_p_3620187407_sub_436279890_3965413181(char *, char *, char *, char *, int );


static void work_a_4000226436_3212880686_p_0(char *t0)
{
    char t7[16];
    char t13[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    int t10;
    unsigned int t11;
    unsigned char t12;
    char *t14;
    char *t15;
    char *t16;
    unsigned int t17;
    unsigned char t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;

LAB0:    xsi_set_current_line(46, ng0);
    t1 = (t0 + 568U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 2152);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(47, ng0);
    t3 = (t0 + 868U);
    t4 = *((char **)t3);
    t3 = (t0 + 4000U);
    t5 = (t0 + 4069);
    t8 = (t7 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 0;
    t9 = (t8 + 4U);
    *((int *)t9) = 21;
    t9 = (t8 + 8U);
    *((int *)t9) = 1;
    t10 = (21 - 0);
    t11 = (t10 * 1);
    t11 = (t11 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t11;
    t12 = ieee_p_3620187407_sub_4058165771_3965413181(IEEE_P_3620187407, t4, t3, t5, t7);
    if (t12 != 0)
        goto LAB5;

LAB7:    xsi_set_current_line(50, ng0);
    t1 = xsi_get_transient_memory(23U);
    memset(t1, 0, 23U);
    t3 = t1;
    memset(t3, (unsigned char)2, 23U);
    t4 = (t0 + 2212);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    t8 = (t6 + 32U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 23U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(51, ng0);
    t1 = (t0 + 1052U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t12 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t2, (unsigned char)3);
    t1 = (t0 + 2248);
    t4 = (t1 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    t8 = *((char **)t6);
    *((unsigned char *)t8) = t12;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(52, ng0);
    t1 = (t0 + 960U);
    t3 = *((char **)t1);
    t1 = (t0 + 4016U);
    t2 = ieee_p_3620187407_sub_2546382208_3965413181(IEEE_P_3620187407, t3, t1, 9);
    if (t2 != 0)
        goto LAB10;

LAB12:    xsi_set_current_line(55, ng0);
    t1 = xsi_get_transient_memory(4U);
    memset(t1, 0, 4U);
    t3 = t1;
    memset(t3, (unsigned char)2, 4U);
    t4 = (t0 + 2284);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    t8 = (t6 + 32U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 4U);
    xsi_driver_first_trans_fast(t4);

LAB11:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(48, ng0);
    t9 = (t0 + 868U);
    t14 = *((char **)t9);
    t9 = (t0 + 4000U);
    t15 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t13, t14, t9, 1);
    t16 = (t13 + 12U);
    t11 = *((unsigned int *)t16);
    t17 = (1U * t11);
    t18 = (23U != t17);
    if (t18 == 1)
        goto LAB8;

LAB9:    t19 = (t0 + 2212);
    t20 = (t19 + 32U);
    t21 = *((char **)t20);
    t22 = (t21 + 32U);
    t23 = *((char **)t22);
    memcpy(t23, t15, 23U);
    xsi_driver_first_trans_fast(t19);
    goto LAB6;

LAB8:    xsi_size_not_matching(23U, t17, 0);
    goto LAB9;

LAB10:    xsi_set_current_line(53, ng0);
    t4 = (t0 + 960U);
    t5 = *((char **)t4);
    t4 = (t0 + 4016U);
    t6 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t7, t5, t4, 1);
    t8 = (t7 + 12U);
    t11 = *((unsigned int *)t8);
    t17 = (1U * t11);
    t12 = (4U != t17);
    if (t12 == 1)
        goto LAB13;

LAB14:    t9 = (t0 + 2284);
    t14 = (t9 + 32U);
    t15 = *((char **)t14);
    t16 = (t15 + 32U);
    t19 = *((char **)t16);
    memcpy(t19, t6, 4U);
    xsi_driver_first_trans_fast(t9);
    goto LAB11;

LAB13:    xsi_size_not_matching(4U, t17, 0);
    goto LAB14;

}

static void work_a_4000226436_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(60, ng0);

LAB3:    t1 = (t0 + 960U);
    t2 = *((char **)t1);
    t1 = (t0 + 2320);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 4U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 2160);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_4000226436_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(61, ng0);

LAB3:    t1 = (t0 + 1052U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 2356);
    t4 = (t1 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 2168);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_4000226436_3212880686_init()
{
	static char *pe[] = {(void *)work_a_4000226436_3212880686_p_0,(void *)work_a_4000226436_3212880686_p_1,(void *)work_a_4000226436_3212880686_p_2};
	xsi_register_didat("work_a_4000226436_3212880686", "isim/counterTestbench_isim_beh.exe.sim/work/a_4000226436_3212880686.didat");
	xsi_register_executes(pe);
}
