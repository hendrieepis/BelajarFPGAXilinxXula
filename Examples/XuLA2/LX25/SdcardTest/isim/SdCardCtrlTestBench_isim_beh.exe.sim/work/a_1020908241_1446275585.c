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

/* This file is designed for use with ISim build 0xc3576ebc */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/xesscorp/PRODUCTS/XuLA/FPGA/XuLA_lib/SDCard.vhdl";
extern char *IEEE_P_2592010699;
extern char *WORK_P_2759204433;
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_1919365254_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_2592010699_sub_1690584930_503743352(char *, unsigned char );
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_1020908241_1446275585_p_0(char *t0)
{
    char t15[16];
    char t17[16];
    char t19[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned char t10;
    int t11;
    int t12;
    int t13;
    char *t14;
    char *t16;
    char *t18;
    char *t20;
    char *t21;
    unsigned int t22;
    char *t23;
    char *t24;
    unsigned int t25;
    char *t26;
    unsigned int t27;
    unsigned char t28;
    unsigned char t29;
    unsigned char t30;
    unsigned char t31;
    unsigned int t32;
    unsigned char t33;
    static char *nl0[] = {&&LAB11, &&LAB12, &&LAB13, &&LAB14, &&LAB15, &&LAB16, &&LAB17, &&LAB18, &&LAB19, &&LAB20, &&LAB21, &&LAB22, &&LAB23, &&LAB24, &&LAB25, &&LAB26};

LAB0:    xsi_set_current_line(166, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 8120);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(168, ng0);
    t3 = ((WORK_P_2759204433) + 1288U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t3 = (t0 + 8216);
    t6 = (t3 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t5;
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(170, ng0);
    t1 = (t0 + 1192U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = ((WORK_P_2759204433) + 1168U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t10 = (t2 == t5);
    if (t10 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 4408U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t2 = (t11 != 0);
    if (t2 != 0)
        goto LAB8;

LAB9:    xsi_set_current_line(183, ng0);
    t1 = ((WORK_P_2759204433) + 1168U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 8280);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(185, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (char *)((nl0) + t2);
    goto **((char **)t1);

LAB5:    xsi_set_current_line(171, ng0);
    t1 = (t0 + 3928U);
    t6 = *((char **)t1);
    t1 = (t6 + 0);
    *((unsigned char *)t1) = (unsigned char)0;
    xsi_set_current_line(172, ng0);
    t1 = (t0 + 4408U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(173, ng0);
    t1 = ((WORK_P_2759204433) + 1168U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 8280);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t2;
    xsi_driver_first_trans_fast_port(t1);

LAB6:    goto LAB3;

LAB8:    xsi_set_current_line(178, ng0);
    t1 = (t0 + 4408U);
    t4 = *((char **)t1);
    t12 = *((int *)t4);
    t13 = (t12 - 1);
    t1 = (t0 + 4408U);
    t6 = *((char **)t1);
    t1 = (t6 + 0);
    *((int *)t1) = t13;
    goto LAB6;

LAB10:    goto LAB6;

LAB11:    xsi_set_current_line(188, ng0);
    t4 = ((WORK_P_2759204433) + 1528U);
    t6 = *((char **)t4);
    t5 = *((unsigned char *)t6);
    t4 = (t0 + 8344);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t14 = *((char **)t9);
    *((unsigned char *)t14) = t5;
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(189, ng0);
    t1 = ((WORK_P_2759204433) + 1408U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 8408);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(190, ng0);
    t1 = (t0 + 6328U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)0;
    xsi_set_current_line(191, ng0);
    t1 = (t0 + 6448U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)0;
    xsi_set_current_line(192, ng0);
    t1 = xsi_get_transient_memory(32U);
    memset(t1, 0, 32U);
    t3 = t1;
    t4 = ((WORK_P_2759204433) + 1768U);
    t6 = *((char **)t4);
    t2 = *((unsigned char *)t6);
    memset(t3, t2, 32U);
    t4 = (t0 + 5728U);
    t7 = *((char **)t4);
    t4 = (t7 + 0);
    memcpy(t4, t1, 32U);
    xsi_set_current_line(193, ng0);
    t1 = xsi_get_transient_memory(48U);
    memset(t1, 0, 48U);
    t3 = t1;
    t4 = ((WORK_P_2759204433) + 1648U);
    t6 = *((char **)t4);
    t2 = *((unsigned char *)t6);
    memset(t3, t2, 48U);
    t4 = (t0 + 5968U);
    t7 = *((char **)t4);
    t4 = (t7 + 0);
    t8 = (t4 + 0);
    memcpy(t8, t1, 48U);
    t9 = (t0 + 5912U);
    xsi_variable_act(t9);
    xsi_set_current_line(195, ng0);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = 10;
    xsi_set_current_line(196, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)12;
    xsi_set_current_line(197, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)1;
    goto LAB10;

LAB12:    xsi_set_current_line(200, ng0);
    t1 = ((WORK_P_2759204433) + 1528U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 8408);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(201, ng0);
    t1 = (t0 + 5128U);
    t3 = *((char **)t1);
    t1 = (t0 + 5728U);
    t4 = *((char **)t1);
    t6 = ((IEEE_P_2592010699) + 4024);
    t7 = (t0 + 13876U);
    t8 = (t0 + 13956U);
    t1 = xsi_base_array_concat(t1, t15, t6, (char)97, t3, t7, (char)97, t4, t8, (char)101);
    t9 = (t0 + 14312);
    t18 = ((IEEE_P_2592010699) + 4024);
    t20 = (t19 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = 0;
    t21 = (t20 + 4U);
    *((int *)t21) = 7;
    t21 = (t20 + 8U);
    *((int *)t21) = 1;
    t11 = (7 - 0);
    t22 = (t11 * 1);
    t22 = (t22 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t22;
    t16 = xsi_base_array_concat(t16, t17, t18, (char)97, t1, t15, (char)97, t9, t19, (char)101);
    t21 = (t0 + 5968U);
    t23 = *((char **)t21);
    t21 = (t23 + 0);
    t24 = (t21 + 0);
    t22 = (8U + 32U);
    t25 = (t22 + 8U);
    memcpy(t24, t16, t25);
    t26 = (t0 + 5912U);
    xsi_variable_act(t26);
    xsi_set_current_line(202, ng0);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = 48U;
    xsi_set_current_line(203, ng0);
    t1 = (t0 + 6328U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)1;
    xsi_set_current_line(204, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)12;
    xsi_set_current_line(205, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)2;
    goto LAB10;

LAB13:    xsi_set_current_line(208, ng0);
    t1 = (t0 + 5248U);
    t3 = *((char **)t1);
    t1 = (t0 + 5728U);
    t4 = *((char **)t1);
    t6 = ((IEEE_P_2592010699) + 4024);
    t7 = (t0 + 13892U);
    t8 = (t0 + 13956U);
    t1 = xsi_base_array_concat(t1, t15, t6, (char)97, t3, t7, (char)97, t4, t8, (char)101);
    t9 = (t0 + 5848U);
    t14 = *((char **)t9);
    t16 = ((IEEE_P_2592010699) + 4024);
    t18 = (t0 + 13972U);
    t9 = xsi_base_array_concat(t9, t17, t16, (char)97, t1, t15, (char)97, t14, t18, (char)101);
    t20 = (t0 + 5968U);
    t21 = *((char **)t20);
    t20 = (t21 + 0);
    t23 = (t20 + 0);
    t22 = (8U + 32U);
    t25 = (t22 + 8U);
    memcpy(t23, t9, t25);
    t24 = (t0 + 5912U);
    xsi_variable_act(t24);
    xsi_set_current_line(209, ng0);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = 48U;
    xsi_set_current_line(210, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)12;
    xsi_set_current_line(211, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)3;
    goto LAB10;

LAB14:    xsi_set_current_line(214, ng0);
    t1 = (t0 + 5368U);
    t3 = *((char **)t1);
    t1 = (t0 + 5728U);
    t4 = *((char **)t1);
    t6 = ((IEEE_P_2592010699) + 4024);
    t7 = (t0 + 13908U);
    t8 = (t0 + 13956U);
    t1 = xsi_base_array_concat(t1, t15, t6, (char)97, t3, t7, (char)97, t4, t8, (char)101);
    t9 = (t0 + 5848U);
    t14 = *((char **)t9);
    t16 = ((IEEE_P_2592010699) + 4024);
    t18 = (t0 + 13972U);
    t9 = xsi_base_array_concat(t9, t17, t16, (char)97, t1, t15, (char)97, t14, t18, (char)101);
    t20 = (t0 + 5968U);
    t21 = *((char **)t20);
    t20 = (t21 + 0);
    t23 = (t20 + 0);
    t22 = (8U + 32U);
    t25 = (t22 + 8U);
    memcpy(t23, t9, t25);
    t24 = (t0 + 5912U);
    xsi_variable_act(t24);
    xsi_set_current_line(215, ng0);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = 48U;
    xsi_set_current_line(216, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)12;
    xsi_set_current_line(217, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)4;
    goto LAB10;

LAB15:    xsi_set_current_line(222, ng0);
    t1 = (t0 + 6088U);
    t3 = *((char **)t1);
    t1 = (t0 + 6208U);
    t4 = *((char **)t1);
    t11 = *((int *)t4);
    t12 = (t11 - 7);
    t22 = (t12 * -1);
    t25 = (1U * t22);
    t27 = (0 + t25);
    t1 = (t3 + t27);
    t2 = *((unsigned char *)t1);
    t6 = ((WORK_P_2759204433) + 1768U);
    t7 = *((char **)t6);
    t5 = *((unsigned char *)t7);
    t10 = (t2 == t5);
    if (t10 != 0)
        goto LAB28;

LAB30:    xsi_set_current_line(225, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)2;

LAB29:    goto LAB10;

LAB16:    xsi_set_current_line(229, ng0);
    t1 = (t0 + 6328U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)1;
    xsi_set_current_line(230, ng0);
    t1 = (t0 + 1352U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = ((WORK_P_2759204433) + 1168U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t10 = (t2 == t5);
    if (t10 != 0)
        goto LAB31;

LAB33:    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = ((WORK_P_2759204433) + 1168U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t10 = (t2 == t5);
    if (t10 != 0)
        goto LAB37;

LAB38:    xsi_set_current_line(256, ng0);
    t1 = ((WORK_P_2759204433) + 1408U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 8408);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(257, ng0);
    t1 = ((WORK_P_2759204433) + 1288U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 8280);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(258, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)5;

LAB32:    goto LAB10;

LAB17:    xsi_set_current_line(264, ng0);
    t1 = (t0 + 3272U);
    t3 = *((char **)t1);
    t5 = *((unsigned char *)t3);
    t1 = ((WORK_P_2759204433) + 1408U);
    t4 = *((char **)t1);
    t10 = *((unsigned char *)t4);
    t28 = (t5 == t10);
    if (t28 == 1)
        goto LAB45;

LAB46:    t2 = (unsigned char)0;

LAB47:    if (t2 != 0)
        goto LAB42;

LAB44:
LAB43:    xsi_set_current_line(268, ng0);
    t1 = (t0 + 3272U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t2);
    t1 = (t0 + 8344);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t5;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(269, ng0);
    t1 = (t0 + 4168U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t12 = (t11 / 2);
    t13 = (t12 - 1);
    t1 = (t0 + 4408U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t13;
    goto LAB10;

LAB18:    xsi_set_current_line(272, ng0);
    t1 = (t0 + 6448U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)1;
    xsi_set_current_line(273, ng0);
    t11 = (8U - 1);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = t11;
    xsi_set_current_line(274, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)15;
    xsi_set_current_line(275, ng0);
    t1 = (t0 + 5008U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t2 = (t11 != 0);
    if (t2 != 0)
        goto LAB48;

LAB50:    xsi_set_current_line(279, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)8;
    xsi_set_current_line(280, ng0);
    t1 = (t0 + 4768U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t12 = (t11 - 1);
    t1 = (t0 + 5008U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t12;

LAB49:    goto LAB10;

LAB19:    xsi_set_current_line(284, ng0);
    t1 = (t0 + 6448U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)0;
    xsi_set_current_line(285, ng0);
    t11 = (8U - 1);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = t11;
    xsi_set_current_line(286, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)15;
    xsi_set_current_line(287, ng0);
    t1 = (t0 + 5008U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t2 = (t11 != 0);
    if (t2 != 0)
        goto LAB51;

LAB53:    xsi_set_current_line(291, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)11;

LAB52:    goto LAB10;

LAB20:    xsi_set_current_line(295, ng0);
    t1 = (t0 + 6328U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)0;
    xsi_set_current_line(296, ng0);
    t1 = (t0 + 5008U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t2 = (t11 != 0);
    if (t2 != 0)
        goto LAB54;

LAB56:    xsi_set_current_line(311, ng0);
    t11 = (8U - 1);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = t11;
    xsi_set_current_line(312, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)15;
    xsi_set_current_line(313, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)10;

LAB55:    goto LAB10;

LAB21:    xsi_set_current_line(317, ng0);
    t1 = (t0 + 3272U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t2);
    t1 = (t0 + 8344);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t5;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(318, ng0);
    t1 = (t0 + 4288U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t1 = (t0 + 4408U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t11;
    xsi_set_current_line(319, ng0);
    t1 = (t0 + 3272U);
    t3 = *((char **)t1);
    t5 = *((unsigned char *)t3);
    t1 = ((WORK_P_2759204433) + 1408U);
    t4 = *((char **)t1);
    t10 = *((unsigned char *)t4);
    t28 = (t5 == t10);
    if (t28 == 1)
        goto LAB89;

LAB90:    t2 = (unsigned char)0;

LAB91:    if (t2 != 0)
        goto LAB86;

LAB88:
LAB87:    goto LAB10;

LAB22:    xsi_set_current_line(326, ng0);
    t1 = ((WORK_P_2759204433) + 1408U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 8408);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(327, ng0);
    t1 = (t0 + 6568U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t1 = (t0 + 4408U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t11;
    xsi_set_current_line(328, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)5;
    goto LAB10;

LAB23:    xsi_set_current_line(333, ng0);
    t1 = ((WORK_P_2759204433) + 1528U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 8344);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(334, ng0);
    t1 = (t0 + 4288U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t1 = (t0 + 4408U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t11;
    xsi_set_current_line(335, ng0);
    t1 = (t0 + 5968U);
    t3 = *((char **)t1);
    if (47 > 0)
        goto LAB92;

LAB93:    if (-1 == -1)
        goto LAB97;

LAB98:    t11 = 0;

LAB94:    t12 = (t11 - 47);
    t22 = (t12 * -1);
    t25 = (1U * t22);
    t27 = (0 + t25);
    t1 = (t3 + t27);
    t2 = *((unsigned char *)t1);
    t4 = (t0 + 8472);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t2;
    xsi_driver_first_trans_fast_port(t4);
    xsi_set_current_line(336, ng0);
    t1 = (t0 + 5968U);
    t3 = *((char **)t1);
    if (47 > 0)
        goto LAB99;

LAB100:    if (-1 == -1)
        goto LAB104;

LAB105:    t11 = 0;

LAB101:    t12 = (t11 - 1);
    t22 = (47 - t12);
    t25 = (t22 * 1U);
    t27 = (0 + t25);
    t1 = (t3 + t27);
    t4 = ((WORK_P_2759204433) + 1648U);
    t6 = *((char **)t4);
    t2 = *((unsigned char *)t6);
    t7 = ((IEEE_P_2592010699) + 4024);
    t8 = (t17 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 46;
    t9 = (t8 + 4U);
    *((int *)t9) = 0;
    t9 = (t8 + 8U);
    *((int *)t9) = -1;
    t13 = (0 - 46);
    t32 = (t13 * -1);
    t32 = (t32 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t32;
    t4 = xsi_base_array_concat(t4, t15, t7, (char)97, t1, t17, (char)99, t2, (char)101);
    t9 = (t0 + 5968U);
    t14 = *((char **)t9);
    t9 = (t14 + 0);
    t32 = (47U + 1U);
    memcpy(t9, t4, t32);
    xsi_set_current_line(337, ng0);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t12 = (t11 - 1);
    t1 = (t0 + 4648U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t12;
    xsi_set_current_line(338, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)13;
    goto LAB10;

LAB24:    xsi_set_current_line(341, ng0);
    t1 = (t0 + 3272U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t2);
    t1 = (t0 + 8344);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t5;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(342, ng0);
    t1 = (t0 + 4288U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t1 = (t0 + 4408U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t11;
    xsi_set_current_line(343, ng0);
    t1 = (t0 + 3272U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = ((WORK_P_2759204433) + 1408U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t10 = (t2 == t5);
    if (t10 != 0)
        goto LAB106;

LAB108:
LAB107:    goto LAB10;

LAB25:    xsi_set_current_line(362, ng0);
    t1 = (t0 + 3272U);
    t3 = *((char **)t1);
    t5 = *((unsigned char *)t3);
    t1 = ((WORK_P_2759204433) + 1408U);
    t4 = *((char **)t1);
    t10 = *((unsigned char *)t4);
    t28 = (t5 == t10);
    if (t28 == 1)
        goto LAB132;

LAB133:    t2 = (unsigned char)0;

LAB134:    if (t2 != 0)
        goto LAB129;

LAB131:
LAB130:    xsi_set_current_line(368, ng0);
    t1 = (t0 + 3272U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t2);
    t1 = (t0 + 8344);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t5;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(369, ng0);
    t1 = (t0 + 4288U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t1 = (t0 + 4408U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t11;
    goto LAB10;

LAB26:    xsi_set_current_line(372, ng0);
    t1 = (t0 + 3272U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = ((WORK_P_2759204433) + 1408U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t10 = (t2 == t5);
    if (t10 != 0)
        goto LAB142;

LAB144:
LAB143:    xsi_set_current_line(387, ng0);
    t1 = (t0 + 3272U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t2);
    t1 = (t0 + 8344);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t5;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(388, ng0);
    t1 = (t0 + 4288U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t1 = (t0 + 4408U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t11;
    goto LAB10;

LAB27:    xsi_set_current_line(391, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)5;
    goto LAB10;

LAB28:    xsi_set_current_line(223, ng0);
    t6 = (t0 + 3928U);
    t8 = *((char **)t6);
    t6 = (t8 + 0);
    *((unsigned char *)t6) = (unsigned char)5;
    goto LAB29;

LAB31:    xsi_set_current_line(231, ng0);
    t1 = ((WORK_P_2759204433) + 1528U);
    t6 = *((char **)t1);
    t28 = *((unsigned char *)t6);
    t1 = (t0 + 8408);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t14 = *((char **)t9);
    *((unsigned char *)t14) = t28;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(232, ng0);
    t1 = (t0 + 1672U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = ((WORK_P_2759204433) + 1168U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t10 = (t2 == t5);
    if (t10 != 0)
        goto LAB34;

LAB36:    xsi_set_current_line(236, ng0);
    t1 = (t0 + 5488U);
    t3 = *((char **)t1);
    t1 = (t0 + 1832U);
    t4 = *((char **)t1);
    t6 = ((IEEE_P_2592010699) + 4024);
    t7 = (t0 + 13924U);
    t8 = (t0 + 13780U);
    t1 = xsi_base_array_concat(t1, t15, t6, (char)97, t3, t7, (char)97, t4, t8, (char)101);
    t9 = (t0 + 14320);
    t18 = ((IEEE_P_2592010699) + 4024);
    t20 = (t19 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = 0;
    t21 = (t20 + 4U);
    *((int *)t21) = 7;
    t21 = (t20 + 8U);
    *((int *)t21) = 1;
    t11 = (7 - 0);
    t22 = (t11 * 1);
    t22 = (t22 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t22;
    t16 = xsi_base_array_concat(t16, t17, t18, (char)97, t1, t15, (char)97, t9, t19, (char)101);
    t21 = (t0 + 5968U);
    t23 = *((char **)t21);
    t21 = (t23 + 0);
    t24 = (t21 + 0);
    t22 = (8U + 32U);
    t25 = (t22 + 8U);
    memcpy(t24, t16, t25);
    t26 = (t0 + 5912U);
    xsi_variable_act(t26);
    xsi_set_current_line(237, ng0);
    t1 = (t0 + 1832U);
    t3 = *((char **)t1);
    t1 = (t0 + 5728U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    memcpy(t1, t3, 32U);

LAB35:    xsi_set_current_line(239, ng0);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = 48U;
    xsi_set_current_line(240, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)12;
    xsi_set_current_line(241, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)6;
    goto LAB32;

LAB34:    xsi_set_current_line(233, ng0);
    t1 = (t0 + 5728U);
    t6 = *((char **)t1);
    t1 = (t0 + 13956U);
    t7 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t15, t6, t1, 1);
    t8 = (t0 + 5728U);
    t9 = *((char **)t8);
    t8 = (t9 + 0);
    t14 = (t15 + 12U);
    t22 = *((unsigned int *)t14);
    t25 = (1U * t22);
    memcpy(t8, t7, t25);
    xsi_set_current_line(234, ng0);
    t1 = (t0 + 5488U);
    t3 = *((char **)t1);
    t1 = (t0 + 5728U);
    t4 = *((char **)t1);
    t6 = ((IEEE_P_2592010699) + 4024);
    t7 = (t0 + 13924U);
    t8 = (t0 + 13956U);
    t1 = xsi_base_array_concat(t1, t15, t6, (char)97, t3, t7, (char)97, t4, t8, (char)101);
    t9 = (t0 + 5848U);
    t14 = *((char **)t9);
    t16 = ((IEEE_P_2592010699) + 4024);
    t18 = (t0 + 13972U);
    t9 = xsi_base_array_concat(t9, t17, t16, (char)97, t1, t15, (char)97, t14, t18, (char)101);
    t20 = (t0 + 5968U);
    t21 = *((char **)t20);
    t20 = (t21 + 0);
    t23 = (t20 + 0);
    t22 = (8U + 32U);
    t25 = (t22 + 8U);
    memcpy(t23, t9, t25);
    t24 = (t0 + 5912U);
    xsi_variable_act(t24);
    goto LAB35;

LAB37:    xsi_set_current_line(243, ng0);
    t1 = ((WORK_P_2759204433) + 1528U);
    t6 = *((char **)t1);
    t28 = *((unsigned char *)t6);
    t1 = (t0 + 8408);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t14 = *((char **)t9);
    *((unsigned char *)t14) = t28;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(244, ng0);
    t1 = (t0 + 1672U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = ((WORK_P_2759204433) + 1168U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t10 = (t2 == t5);
    if (t10 != 0)
        goto LAB39;

LAB41:    xsi_set_current_line(248, ng0);
    t1 = (t0 + 5608U);
    t3 = *((char **)t1);
    t1 = (t0 + 1832U);
    t4 = *((char **)t1);
    t6 = ((IEEE_P_2592010699) + 4024);
    t7 = (t0 + 13940U);
    t8 = (t0 + 13780U);
    t1 = xsi_base_array_concat(t1, t15, t6, (char)97, t3, t7, (char)97, t4, t8, (char)101);
    t9 = (t0 + 14328);
    t18 = ((IEEE_P_2592010699) + 4024);
    t20 = (t19 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = 0;
    t21 = (t20 + 4U);
    *((int *)t21) = 7;
    t21 = (t20 + 8U);
    *((int *)t21) = 1;
    t11 = (7 - 0);
    t22 = (t11 * 1);
    t22 = (t22 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t22;
    t16 = xsi_base_array_concat(t16, t17, t18, (char)97, t1, t15, (char)97, t9, t19, (char)101);
    t21 = (t0 + 5968U);
    t23 = *((char **)t21);
    t21 = (t23 + 0);
    t24 = (t21 + 0);
    t22 = (8U + 32U);
    t25 = (t22 + 8U);
    memcpy(t24, t16, t25);
    t26 = (t0 + 5912U);
    xsi_variable_act(t26);
    xsi_set_current_line(249, ng0);
    t1 = (t0 + 1832U);
    t3 = *((char **)t1);
    t1 = (t0 + 5728U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    memcpy(t1, t3, 32U);

LAB40:    xsi_set_current_line(251, ng0);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = 48U;
    xsi_set_current_line(252, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)12;
    xsi_set_current_line(253, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)9;
    xsi_set_current_line(254, ng0);
    t1 = (t0 + 4888U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t1 = (t0 + 5008U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t11;
    goto LAB32;

LAB39:    xsi_set_current_line(245, ng0);
    t1 = (t0 + 5728U);
    t6 = *((char **)t1);
    t1 = (t0 + 13956U);
    t7 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t15, t6, t1, 1);
    t8 = (t0 + 5728U);
    t9 = *((char **)t8);
    t8 = (t9 + 0);
    t14 = (t15 + 12U);
    t22 = *((unsigned int *)t14);
    t25 = (1U * t22);
    memcpy(t8, t7, t25);
    xsi_set_current_line(246, ng0);
    t1 = (t0 + 5608U);
    t3 = *((char **)t1);
    t1 = (t0 + 5728U);
    t4 = *((char **)t1);
    t6 = ((IEEE_P_2592010699) + 4024);
    t7 = (t0 + 13940U);
    t8 = (t0 + 13956U);
    t1 = xsi_base_array_concat(t1, t15, t6, (char)97, t3, t7, (char)97, t4, t8, (char)101);
    t9 = (t0 + 5848U);
    t14 = *((char **)t9);
    t16 = ((IEEE_P_2592010699) + 4024);
    t18 = (t0 + 13972U);
    t9 = xsi_base_array_concat(t9, t17, t16, (char)97, t1, t15, (char)97, t14, t18, (char)101);
    t20 = (t0 + 5968U);
    t21 = *((char **)t20);
    t20 = (t21 + 0);
    t23 = (t20 + 0);
    t22 = (8U + 32U);
    t25 = (t22 + 8U);
    memcpy(t23, t9, t25);
    t24 = (t0 + 5912U);
    xsi_variable_act(t24);
    goto LAB40;

LAB42:    xsi_set_current_line(265, ng0);
    t11 = (5 - 1);
    t1 = (t0 + 5008U);
    t8 = *((char **)t1);
    t1 = (t8 + 0);
    *((int *)t1) = t11;
    xsi_set_current_line(266, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)7;
    goto LAB43;

LAB45:    t1 = (t0 + 3112U);
    t6 = *((char **)t1);
    t29 = *((unsigned char *)t6);
    t1 = ((WORK_P_2759204433) + 1528U);
    t7 = *((char **)t1);
    t30 = *((unsigned char *)t7);
    t31 = (t29 == t30);
    t2 = t31;
    goto LAB47;

LAB48:    xsi_set_current_line(276, ng0);
    t1 = (t0 + 5008U);
    t4 = *((char **)t1);
    t12 = *((int *)t4);
    t13 = (t12 - 1);
    t1 = (t0 + 5008U);
    t6 = *((char **)t1);
    t1 = (t6 + 0);
    *((int *)t1) = t13;
    xsi_set_current_line(277, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)7;
    goto LAB49;

LAB51:    xsi_set_current_line(288, ng0);
    t1 = (t0 + 5008U);
    t4 = *((char **)t1);
    t12 = *((int *)t4);
    t13 = (t12 - 1);
    t1 = (t0 + 5008U);
    t6 = *((char **)t1);
    t1 = (t6 + 0);
    *((int *)t1) = t13;
    xsi_set_current_line(289, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)8;
    goto LAB52;

LAB54:    xsi_set_current_line(297, ng0);
    t1 = xsi_get_transient_memory(48U);
    memset(t1, 0, 48U);
    t4 = t1;
    t6 = ((WORK_P_2759204433) + 1648U);
    t7 = *((char **)t6);
    t5 = *((unsigned char *)t7);
    memset(t4, t5, 48U);
    t6 = (t0 + 5968U);
    t8 = *((char **)t6);
    t6 = (t8 + 0);
    memcpy(t6, t1, 48U);
    xsi_set_current_line(298, ng0);
    t1 = (t0 + 5008U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t1 = (t0 + 4888U);
    t4 = *((char **)t1);
    t12 = *((int *)t4);
    t2 = (t11 == t12);
    if (t2 != 0)
        goto LAB57;

LAB59:    t1 = (t0 + 5008U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t5 = (t11 == 2);
    if (t5 == 1)
        goto LAB69;

LAB70:    t1 = (t0 + 5008U);
    t4 = *((char **)t1);
    t12 = *((int *)t4);
    t10 = (t12 == 1);
    t2 = t10;

LAB71:    if (t2 != 0)
        goto LAB67;

LAB68:    xsi_set_current_line(303, ng0);
    t1 = (t0 + 1992U);
    t3 = *((char **)t1);
    t1 = (t0 + 5968U);
    t4 = *((char **)t1);
    if (47 > 0)
        goto LAB79;

LAB80:    if (-1 == -1)
        goto LAB84;

LAB85:    t11 = 0;

LAB81:    t22 = (47 - t11);
    t25 = (t22 * 1U);
    t27 = (0 + t25);
    t1 = (t4 + t27);
    t6 = (t1 + 0);
    memcpy(t6, t3, 8U);
    t7 = (t0 + 5912U);
    xsi_variable_act(t7);
    xsi_set_current_line(304, ng0);
    t1 = ((WORK_P_2759204433) + 1168U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 8216);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t2;
    xsi_driver_first_trans_fast_port(t1);

LAB58:    xsi_set_current_line(306, ng0);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = 8U;
    xsi_set_current_line(307, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)12;
    xsi_set_current_line(308, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)9;
    xsi_set_current_line(309, ng0);
    t1 = (t0 + 5008U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t12 = (t11 - 1);
    t1 = (t0 + 5008U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t12;
    goto LAB55;

LAB57:    xsi_set_current_line(299, ng0);
    t1 = (t0 + 14336);
    t7 = (t0 + 5968U);
    t8 = *((char **)t7);
    if (47 > 0)
        goto LAB60;

LAB61:    if (-1 == -1)
        goto LAB65;

LAB66:    t13 = 0;

LAB62:    t22 = (47 - t13);
    t25 = (t22 * 1U);
    t27 = (0 + t25);
    t7 = (t8 + t27);
    t9 = (t7 + 0);
    memcpy(t9, t1, 8U);
    t14 = (t0 + 5912U);
    xsi_variable_act(t14);
    goto LAB58;

LAB60:    if (-1 == 1)
        goto LAB63;

LAB64:    t13 = 47;
    goto LAB62;

LAB63:    t13 = 0;
    goto LAB62;

LAB65:    t13 = 47;
    goto LAB62;

LAB67:    xsi_set_current_line(301, ng0);
    t1 = (t0 + 14344);
    t7 = (t0 + 5968U);
    t8 = *((char **)t7);
    if (47 > 0)
        goto LAB72;

LAB73:    if (-1 == -1)
        goto LAB77;

LAB78:    t13 = 0;

LAB74:    t22 = (47 - t13);
    t25 = (t22 * 1U);
    t27 = (0 + t25);
    t7 = (t8 + t27);
    t9 = (t7 + 0);
    memcpy(t9, t1, 8U);
    t14 = (t0 + 5912U);
    xsi_variable_act(t14);
    goto LAB58;

LAB69:    t2 = (unsigned char)1;
    goto LAB71;

LAB72:    if (-1 == 1)
        goto LAB75;

LAB76:    t13 = 47;
    goto LAB74;

LAB75:    t13 = 0;
    goto LAB74;

LAB77:    t13 = 47;
    goto LAB74;

LAB79:    if (-1 == 1)
        goto LAB82;

LAB83:    t11 = 47;
    goto LAB81;

LAB82:    t11 = 0;
    goto LAB81;

LAB84:    t11 = 47;
    goto LAB81;

LAB86:    xsi_set_current_line(321, ng0);
    t1 = (t0 + 4408U);
    t8 = *((char **)t1);
    t1 = (t8 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(322, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)11;
    goto LAB87;

LAB89:    t1 = (t0 + 3112U);
    t6 = *((char **)t1);
    t29 = *((unsigned char *)t6);
    t1 = ((WORK_P_2759204433) + 1408U);
    t7 = *((char **)t1);
    t30 = *((unsigned char *)t7);
    t31 = (t29 == t30);
    t2 = t31;
    goto LAB91;

LAB92:    if (-1 == 1)
        goto LAB95;

LAB96:    t11 = 47;
    goto LAB94;

LAB95:    t11 = 0;
    goto LAB94;

LAB97:    t11 = 47;
    goto LAB94;

LAB99:    if (-1 == 1)
        goto LAB102;

LAB103:    t11 = 47;
    goto LAB101;

LAB102:    t11 = 0;
    goto LAB101;

LAB104:    t11 = 47;
    goto LAB101;

LAB106:    xsi_set_current_line(346, ng0);
    t1 = (t0 + 4648U);
    t6 = *((char **)t1);
    t11 = *((int *)t6);
    t28 = (t11 != 0);
    if (t28 != 0)
        goto LAB109;

LAB111:    xsi_set_current_line(351, ng0);
    t1 = (t0 + 6328U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    if (t2 != 0)
        goto LAB126;

LAB128:    xsi_set_current_line(355, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 3928U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((unsigned char *)t1) = t2;
    xsi_set_current_line(356, ng0);
    t1 = (t0 + 4408U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = 0;

LAB127:
LAB110:    goto LAB107;

LAB109:    xsi_set_current_line(347, ng0);
    t1 = (t0 + 5968U);
    t7 = *((char **)t1);
    if (47 > 0)
        goto LAB112;

LAB113:    if (-1 == -1)
        goto LAB117;

LAB118:    t12 = 0;

LAB114:    t13 = (t12 - 47);
    t22 = (t13 * -1);
    t25 = (1U * t22);
    t27 = (0 + t25);
    t1 = (t7 + t27);
    t29 = *((unsigned char *)t1);
    t8 = (t0 + 8472);
    t9 = (t8 + 56U);
    t14 = *((char **)t9);
    t16 = (t14 + 56U);
    t18 = *((char **)t16);
    *((unsigned char *)t18) = t29;
    xsi_driver_first_trans_fast_port(t8);
    xsi_set_current_line(348, ng0);
    t1 = (t0 + 5968U);
    t3 = *((char **)t1);
    if (47 > 0)
        goto LAB119;

LAB120:    if (-1 == -1)
        goto LAB124;

LAB125:    t11 = 0;

LAB121:    t12 = (t11 - 1);
    t22 = (47 - t12);
    t25 = (t22 * 1U);
    t27 = (0 + t25);
    t1 = (t3 + t27);
    t4 = ((WORK_P_2759204433) + 1648U);
    t6 = *((char **)t4);
    t2 = *((unsigned char *)t6);
    t7 = ((IEEE_P_2592010699) + 4024);
    t8 = (t17 + 0U);
    t9 = (t8 + 0U);
    *((int *)t9) = 46;
    t9 = (t8 + 4U);
    *((int *)t9) = 0;
    t9 = (t8 + 8U);
    *((int *)t9) = -1;
    t13 = (0 - 46);
    t32 = (t13 * -1);
    t32 = (t32 + 1);
    t9 = (t8 + 12U);
    *((unsigned int *)t9) = t32;
    t4 = xsi_base_array_concat(t4, t15, t7, (char)97, t1, t17, (char)99, t2, (char)101);
    t9 = (t0 + 5968U);
    t14 = *((char **)t9);
    t9 = (t14 + 0);
    t32 = (47U + 1U);
    memcpy(t9, t4, t32);
    xsi_set_current_line(349, ng0);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t12 = (t11 - 1);
    t1 = (t0 + 4648U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t12;
    goto LAB110;

LAB112:    if (-1 == 1)
        goto LAB115;

LAB116:    t12 = 47;
    goto LAB114;

LAB115:    t12 = 0;
    goto LAB114;

LAB117:    t12 = 47;
    goto LAB114;

LAB119:    if (-1 == 1)
        goto LAB122;

LAB123:    t11 = 47;
    goto LAB121;

LAB122:    t11 = 0;
    goto LAB121;

LAB124:    t11 = 47;
    goto LAB121;

LAB126:    xsi_set_current_line(352, ng0);
    t1 = (t0 + 3928U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((unsigned char *)t1) = (unsigned char)14;
    xsi_set_current_line(353, ng0);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((int *)t1) = 7;
    goto LAB127;

LAB129:    xsi_set_current_line(364, ng0);
    t1 = (t0 + 6088U);
    t8 = *((char **)t1);
    if (7 > 0)
        goto LAB135;

LAB136:    if (-1 == -1)
        goto LAB140;

LAB141:    t11 = 0;

LAB137:    t12 = (t11 - 1);
    t22 = (7 - t12);
    t25 = (t22 * 1U);
    t27 = (0 + t25);
    t1 = (t8 + t27);
    t9 = (t0 + 3112U);
    t14 = *((char **)t9);
    t33 = *((unsigned char *)t14);
    t16 = ((IEEE_P_2592010699) + 4024);
    t18 = (t17 + 0U);
    t20 = (t18 + 0U);
    *((int *)t20) = 6;
    t20 = (t18 + 4U);
    *((int *)t20) = 0;
    t20 = (t18 + 8U);
    *((int *)t20) = -1;
    t13 = (0 - 6);
    t32 = (t13 * -1);
    t32 = (t32 + 1);
    t20 = (t18 + 12U);
    *((unsigned int *)t20) = t32;
    t9 = xsi_base_array_concat(t9, t15, t16, (char)97, t1, t17, (char)99, t33, (char)101);
    t20 = (t0 + 6088U);
    t21 = *((char **)t20);
    t20 = (t21 + 0);
    t32 = (7U + 1U);
    memcpy(t20, t9, t32);
    xsi_set_current_line(365, ng0);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t12 = (t11 - 1);
    t1 = (t0 + 4648U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t12;
    xsi_set_current_line(366, ng0);
    t1 = (t0 + 3928U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    *((unsigned char *)t1) = (unsigned char)15;
    goto LAB130;

LAB132:    t1 = (t0 + 3112U);
    t6 = *((char **)t1);
    t29 = *((unsigned char *)t6);
    t1 = ((WORK_P_2759204433) + 1528U);
    t7 = *((char **)t1);
    t30 = *((unsigned char *)t7);
    t31 = (t29 == t30);
    t2 = t31;
    goto LAB134;

LAB135:    if (-1 == 1)
        goto LAB138;

LAB139:    t11 = 7;
    goto LAB137;

LAB138:    t11 = 0;
    goto LAB137;

LAB140:    t11 = 7;
    goto LAB137;

LAB142:    xsi_set_current_line(373, ng0);
    t1 = (t0 + 6088U);
    t6 = *((char **)t1);
    if (7 > 0)
        goto LAB145;

LAB146:    if (-1 == -1)
        goto LAB150;

LAB151:    t11 = 0;

LAB147:    t12 = (t11 - 1);
    t22 = (7 - t12);
    t25 = (t22 * 1U);
    t27 = (0 + t25);
    t1 = (t6 + t27);
    t7 = (t0 + 3112U);
    t8 = *((char **)t7);
    t28 = *((unsigned char *)t8);
    t9 = ((IEEE_P_2592010699) + 4024);
    t14 = (t17 + 0U);
    t16 = (t14 + 0U);
    *((int *)t16) = 6;
    t16 = (t14 + 4U);
    *((int *)t16) = 0;
    t16 = (t14 + 8U);
    *((int *)t16) = -1;
    t13 = (0 - 6);
    t32 = (t13 * -1);
    t32 = (t32 + 1);
    t16 = (t14 + 12U);
    *((unsigned int *)t16) = t32;
    t7 = xsi_base_array_concat(t7, t15, t9, (char)97, t1, t17, (char)99, t28, (char)101);
    t16 = (t0 + 6088U);
    t18 = *((char **)t16);
    t16 = (t18 + 0);
    t32 = (7U + 1U);
    memcpy(t16, t7, t32);
    xsi_set_current_line(374, ng0);
    t1 = (t0 + 4648U);
    t3 = *((char **)t1);
    t11 = *((int *)t3);
    t2 = (t11 != 0);
    if (t2 != 0)
        goto LAB152;

LAB154:    xsi_set_current_line(377, ng0);
    t1 = (t0 + 6448U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    if (t2 != 0)
        goto LAB155;

LAB157:
LAB156:    xsi_set_current_line(381, ng0);
    t1 = (t0 + 6328U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    if (t2 != 0)
        goto LAB158;

LAB160:
LAB159:    xsi_set_current_line(384, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 3928U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((unsigned char *)t1) = t2;

LAB153:    goto LAB143;

LAB145:    if (-1 == 1)
        goto LAB148;

LAB149:    t11 = 7;
    goto LAB147;

LAB148:    t11 = 0;
    goto LAB147;

LAB150:    t11 = 7;
    goto LAB147;

LAB152:    xsi_set_current_line(375, ng0);
    t1 = (t0 + 4648U);
    t4 = *((char **)t1);
    t12 = *((int *)t4);
    t13 = (t12 - 1);
    t1 = (t0 + 4648U);
    t6 = *((char **)t1);
    t1 = (t6 + 0);
    *((int *)t1) = t13;
    goto LAB153;

LAB155:    xsi_set_current_line(378, ng0);
    t1 = (t0 + 6088U);
    t4 = *((char **)t1);
    t1 = (t0 + 8536);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t4, 8U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(379, ng0);
    t1 = ((WORK_P_2759204433) + 1168U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 8216);
    t4 = (t1 + 56U);
    t6 = *((char **)t4);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB156;

LAB158:    goto LAB159;

}

static void work_a_1020908241_1446275585_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(397, ng0);

LAB3:    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 8600);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 8136);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_1020908241_1446275585_init()
{
	static char *pe[] = {(void *)work_a_1020908241_1446275585_p_0,(void *)work_a_1020908241_1446275585_p_1};
	xsi_register_didat("work_a_1020908241_1446275585", "isim/SdCardCtrlTestBench_isim_beh.exe.sim/work/a_1020908241_1446275585.didat");
	xsi_register_executes(pe);
}
