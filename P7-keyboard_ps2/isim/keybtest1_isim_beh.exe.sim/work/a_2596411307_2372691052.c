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
extern char *IEEE_P_2592010699;
static const char *ng1 = "/home/hendri/Documents/workspaceXilinx/keyboard_ps2/keybtest1.vhd";

unsigned char ieee_p_2592010699_sub_1690584930_503743352(char *, unsigned char );
unsigned char ieee_p_2592010699_sub_2507238156_503743352(char *, unsigned char , unsigned char );


void work_a_2596411307_2372691052_sub_3368731001_4163069965(char *t0, char *t1, char *t2, char *t3, unsigned int t4, unsigned int t5, char *t6, char *t7, unsigned int t8, unsigned int t9, char *t10)
{
    char t12[16];
    char t13[16];
    char *t14;
    char *t15;
    int t16;
    unsigned int t17;
    unsigned char t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    int64 t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    int t32;
    int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    int t37;
    int t38;
    int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned char t42;
    unsigned char t43;
    int t44;
    int t45;
    int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned char t50;
    unsigned char t51;
    int t52;
    int t53;
    int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned char t58;
    unsigned char t59;
    char *t60;
    int t61;
    char *t62;
    int t63;
    int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    char *t68;
    unsigned char t69;
    unsigned char t70;
    char *t71;
    int t72;
    char *t73;
    int t74;
    int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    char *t79;
    unsigned char t80;
    unsigned char t81;
    char *t82;
    int t83;
    char *t84;
    int t85;
    int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    char *t90;
    unsigned char t91;
    unsigned char t92;
    char *t93;
    int t94;
    char *t95;
    int t96;
    int t97;
    unsigned int t98;
    unsigned int t99;
    unsigned int t100;
    char *t101;
    unsigned char t102;
    unsigned char t103;
    unsigned char t104;
    unsigned int t105;
    char *t106;
    char *t107;
    char *t108;
    char *t109;

LAB0:    t14 = (t13 + 0U);
    t15 = (t14 + 0U);
    *((int *)t15) = 7;
    t15 = (t14 + 4U);
    *((int *)t15) = 0;
    t15 = (t14 + 8U);
    *((int *)t15) = -1;
    t16 = (0 - 7);
    t17 = (t16 * -1);
    t17 = (t17 + 1);
    t15 = (t14 + 12U);
    *((unsigned int *)t15) = t17;
    t15 = (t12 + 4U);
    t18 = (t2 != 0);
    if (t18 == 1)
        goto LAB3;

LAB2:    t19 = (t12 + 8U);
    *((char **)t19) = t13;
    t17 = (0 + t4);
    t20 = (t6 + 32U);
    t21 = *((char **)t20);
    t22 = (t21 + 32U);
    t23 = *((char **)t22);
    *((unsigned char *)t23) = (unsigned char)2;
    xsi_driver_first_trans_delta(t6, t17, 1, 0LL);
    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB7:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB8;

LAB9:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB5:
LAB6:
LAB4:    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)3;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB13:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB14;

LAB15:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB11:
LAB12:
LAB10:    t14 = (t13 + 0U);
    t16 = *((int *)t14);
    t20 = (t13 + 8U);
    t32 = *((int *)t20);
    t33 = (7 - t16);
    t17 = (t33 * t32);
    t34 = (1U * t17);
    t35 = (0 + t34);
    t21 = (t2 + t35);
    t18 = *((unsigned char *)t21);
    t36 = (0 + t4);
    t22 = (t6 + 32U);
    t23 = *((char **)t22);
    t25 = (t23 + 32U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = t18;
    xsi_driver_first_trans_delta(t6, t36, 1, 0LL);
    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB19:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB20;

LAB21:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB17:
LAB18:
LAB16:    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)3;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB25:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB26;

LAB27:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB23:
LAB24:
LAB22:    t14 = (t13 + 0U);
    t16 = *((int *)t14);
    t20 = (t13 + 8U);
    t32 = *((int *)t20);
    t33 = (6 - t16);
    t17 = (t33 * t32);
    t34 = (1U * t17);
    t35 = (0 + t34);
    t21 = (t2 + t35);
    t18 = *((unsigned char *)t21);
    t36 = (0 + t4);
    t22 = (t6 + 32U);
    t23 = *((char **)t22);
    t25 = (t23 + 32U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = t18;
    xsi_driver_first_trans_delta(t6, t36, 1, 0LL);
    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB31:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB32;

LAB33:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB29:
LAB30:
LAB28:    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)3;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB37:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB38;

LAB39:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB35:
LAB36:
LAB34:    t14 = (t13 + 0U);
    t16 = *((int *)t14);
    t20 = (t13 + 8U);
    t32 = *((int *)t20);
    t33 = (5 - t16);
    t17 = (t33 * t32);
    t34 = (1U * t17);
    t35 = (0 + t34);
    t21 = (t2 + t35);
    t18 = *((unsigned char *)t21);
    t36 = (0 + t4);
    t22 = (t6 + 32U);
    t23 = *((char **)t22);
    t25 = (t23 + 32U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = t18;
    xsi_driver_first_trans_delta(t6, t36, 1, 0LL);
    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB43:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB44;

LAB45:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB41:
LAB42:
LAB40:    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)3;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB49:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB50;

LAB51:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB47:
LAB48:
LAB46:    t14 = (t13 + 0U);
    t16 = *((int *)t14);
    t20 = (t13 + 8U);
    t32 = *((int *)t20);
    t33 = (4 - t16);
    t17 = (t33 * t32);
    t34 = (1U * t17);
    t35 = (0 + t34);
    t21 = (t2 + t35);
    t18 = *((unsigned char *)t21);
    t36 = (0 + t4);
    t22 = (t6 + 32U);
    t23 = *((char **)t22);
    t25 = (t23 + 32U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = t18;
    xsi_driver_first_trans_delta(t6, t36, 1, 0LL);
    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB55:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB56;

LAB57:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB53:
LAB54:
LAB52:    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)3;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB61:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB62;

LAB63:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB59:
LAB60:
LAB58:    t14 = (t13 + 0U);
    t16 = *((int *)t14);
    t20 = (t13 + 8U);
    t32 = *((int *)t20);
    t33 = (3 - t16);
    t17 = (t33 * t32);
    t34 = (1U * t17);
    t35 = (0 + t34);
    t21 = (t2 + t35);
    t18 = *((unsigned char *)t21);
    t36 = (0 + t4);
    t22 = (t6 + 32U);
    t23 = *((char **)t22);
    t25 = (t23 + 32U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = t18;
    xsi_driver_first_trans_delta(t6, t36, 1, 0LL);
    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB67:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB68;

LAB69:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB65:
LAB66:
LAB64:    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)3;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB73:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB74;

LAB75:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB71:
LAB72:
LAB70:    t14 = (t13 + 0U);
    t16 = *((int *)t14);
    t20 = (t13 + 8U);
    t32 = *((int *)t20);
    t33 = (2 - t16);
    t17 = (t33 * t32);
    t34 = (1U * t17);
    t35 = (0 + t34);
    t21 = (t2 + t35);
    t18 = *((unsigned char *)t21);
    t36 = (0 + t4);
    t22 = (t6 + 32U);
    t23 = *((char **)t22);
    t25 = (t23 + 32U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = t18;
    xsi_driver_first_trans_delta(t6, t36, 1, 0LL);
    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB79:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB80;

LAB81:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB77:
LAB78:
LAB76:    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)3;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB85:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB86;

LAB87:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB83:
LAB84:
LAB82:    t14 = (t13 + 0U);
    t16 = *((int *)t14);
    t20 = (t13 + 8U);
    t32 = *((int *)t20);
    t33 = (1 - t16);
    t17 = (t33 * t32);
    t34 = (1U * t17);
    t35 = (0 + t34);
    t21 = (t2 + t35);
    t18 = *((unsigned char *)t21);
    t36 = (0 + t4);
    t22 = (t6 + 32U);
    t23 = *((char **)t22);
    t25 = (t23 + 32U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = t18;
    xsi_driver_first_trans_delta(t6, t36, 1, 0LL);
    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB91:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB92;

LAB93:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB89:
LAB90:
LAB88:    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)3;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB97:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB98;

LAB99:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB95:
LAB96:
LAB94:    t14 = (t13 + 0U);
    t16 = *((int *)t14);
    t20 = (t13 + 8U);
    t32 = *((int *)t20);
    t33 = (0 - t16);
    t17 = (t33 * t32);
    t34 = (1U * t17);
    t35 = (0 + t34);
    t21 = (t2 + t35);
    t18 = *((unsigned char *)t21);
    t36 = (0 + t4);
    t22 = (t6 + 32U);
    t23 = *((char **)t22);
    t25 = (t23 + 32U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = t18;
    xsi_driver_first_trans_delta(t6, t36, 1, 0LL);
    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB103:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB104;

LAB105:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB101:
LAB102:
LAB100:    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)3;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB109:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB110;

LAB111:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB107:
LAB108:
LAB106:    t14 = (t13 + 0U);
    t16 = *((int *)t14);
    t20 = (t13 + 8U);
    t32 = *((int *)t20);
    t33 = (0 - t16);
    t17 = (t33 * t32);
    t34 = (1U * t17);
    t35 = (0 + t34);
    t21 = (t2 + t35);
    t18 = *((unsigned char *)t21);
    t22 = (t13 + 0U);
    t37 = *((int *)t22);
    t23 = (t13 + 8U);
    t38 = *((int *)t23);
    t39 = (1 - t37);
    t36 = (t39 * t38);
    t40 = (1U * t36);
    t41 = (0 + t40);
    t25 = (t2 + t41);
    t42 = *((unsigned char *)t25);
    t43 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t18, t42);
    t26 = (t13 + 0U);
    t44 = *((int *)t26);
    t27 = (t13 + 8U);
    t45 = *((int *)t27);
    t46 = (2 - t44);
    t47 = (t46 * t45);
    t48 = (1U * t47);
    t49 = (0 + t48);
    t28 = (t2 + t49);
    t50 = *((unsigned char *)t28);
    t51 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t43, t50);
    t29 = (t13 + 0U);
    t52 = *((int *)t29);
    t30 = (t13 + 8U);
    t53 = *((int *)t30);
    t54 = (3 - t52);
    t55 = (t54 * t53);
    t56 = (1U * t55);
    t57 = (0 + t56);
    t31 = (t2 + t57);
    t58 = *((unsigned char *)t31);
    t59 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t51, t58);
    t60 = (t13 + 0U);
    t61 = *((int *)t60);
    t62 = (t13 + 8U);
    t63 = *((int *)t62);
    t64 = (4 - t61);
    t65 = (t64 * t63);
    t66 = (1U * t65);
    t67 = (0 + t66);
    t68 = (t2 + t67);
    t69 = *((unsigned char *)t68);
    t70 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t59, t69);
    t71 = (t13 + 0U);
    t72 = *((int *)t71);
    t73 = (t13 + 8U);
    t74 = *((int *)t73);
    t75 = (5 - t72);
    t76 = (t75 * t74);
    t77 = (1U * t76);
    t78 = (0 + t77);
    t79 = (t2 + t78);
    t80 = *((unsigned char *)t79);
    t81 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t70, t80);
    t82 = (t13 + 0U);
    t83 = *((int *)t82);
    t84 = (t13 + 8U);
    t85 = *((int *)t84);
    t86 = (6 - t83);
    t87 = (t86 * t85);
    t88 = (1U * t87);
    t89 = (0 + t88);
    t90 = (t2 + t89);
    t91 = *((unsigned char *)t90);
    t92 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t81, t91);
    t93 = (t13 + 0U);
    t94 = *((int *)t93);
    t95 = (t13 + 8U);
    t96 = *((int *)t95);
    t97 = (7 - t94);
    t98 = (t97 * t96);
    t99 = (1U * t98);
    t100 = (0 + t99);
    t101 = (t2 + t100);
    t102 = *((unsigned char *)t101);
    t103 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t92, t102);
    t104 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t103);
    t105 = (0 + t4);
    t106 = (t6 + 32U);
    t107 = *((char **)t106);
    t108 = (t107 + 32U);
    t109 = *((char **)t108);
    *((unsigned char *)t109) = t104;
    xsi_driver_first_trans_delta(t6, t105, 1, 0LL);
    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB115:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB116;

LAB117:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB113:
LAB114:
LAB112:    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)3;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB121:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB122;

LAB123:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB119:
LAB120:
LAB118:    t17 = (0 + t4);
    t14 = (t6 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)3;
    xsi_driver_first_trans_delta(t6, t17, 1, 0LL);
    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);
    t24 = (65 * 1000000LL);
    xsi_process_wait(t1, t24);

LAB127:    t14 = (t1 + 48U);
    t20 = *((char **)t14);
    t21 = (t20 + 704U);
    *((unsigned int *)t21) = 1U;
    t22 = (t1 + 48U);
    t23 = *((char **)t22);
    t25 = (t23 + 0U);
    getcontext(t25);
    t26 = (t1 + 48U);
    t27 = *((char **)t26);
    t28 = (t27 + 704U);
    t17 = *((unsigned int *)t28);
    if (t17 == 1)
        goto LAB128;

LAB129:    t29 = (t1 + 48U);
    t30 = *((char **)t29);
    t31 = (t30 + 704U);
    *((unsigned int *)t31) = 3U;

LAB125:
LAB126:
LAB124:    t17 = (0 + t8);
    t14 = (t10 + 32U);
    t20 = *((char **)t14);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = (unsigned char)3;
    xsi_driver_first_trans_delta(t10, t17, 1, 0LL);

LAB1:    return;
LAB3:    *((char **)t15) = t2;
    goto LAB2;

LAB8:    xsi_saveStackAndSuspend(t1);
    goto LAB9;

LAB14:    xsi_saveStackAndSuspend(t1);
    goto LAB15;

LAB20:    xsi_saveStackAndSuspend(t1);
    goto LAB21;

LAB26:    xsi_saveStackAndSuspend(t1);
    goto LAB27;

LAB32:    xsi_saveStackAndSuspend(t1);
    goto LAB33;

LAB38:    xsi_saveStackAndSuspend(t1);
    goto LAB39;

LAB44:    xsi_saveStackAndSuspend(t1);
    goto LAB45;

LAB50:    xsi_saveStackAndSuspend(t1);
    goto LAB51;

LAB56:    xsi_saveStackAndSuspend(t1);
    goto LAB57;

LAB62:    xsi_saveStackAndSuspend(t1);
    goto LAB63;

LAB68:    xsi_saveStackAndSuspend(t1);
    goto LAB69;

LAB74:    xsi_saveStackAndSuspend(t1);
    goto LAB75;

LAB80:    xsi_saveStackAndSuspend(t1);
    goto LAB81;

LAB86:    xsi_saveStackAndSuspend(t1);
    goto LAB87;

LAB92:    xsi_saveStackAndSuspend(t1);
    goto LAB93;

LAB98:    xsi_saveStackAndSuspend(t1);
    goto LAB99;

LAB104:    xsi_saveStackAndSuspend(t1);
    goto LAB105;

LAB110:    xsi_saveStackAndSuspend(t1);
    goto LAB111;

LAB116:    xsi_saveStackAndSuspend(t1);
    goto LAB117;

LAB122:    xsi_saveStackAndSuspend(t1);
    goto LAB123;

LAB128:    xsi_saveStackAndSuspend(t1);
    goto LAB129;

}

static void work_a_2596411307_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    int64 t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    t1 = (t0 + 1516U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(156, ng1);
    t3 = (100 * 1000LL);
    t2 = (t0 + 1416);
    xsi_process_wait(t2, t3);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(157, ng1);
    t2 = (t0 + 1868);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(158, ng1);
    t3 = (100 * 1000LL);
    t2 = (t0 + 1416);
    xsi_process_wait(t2, t3);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(159, ng1);
    t2 = (t0 + 1868);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(160, ng1);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    goto LAB2;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

}

static void work_a_2596411307_2372691052_p_1(char *t0)
{
    char *t1;
    char *t2;
    int64 t3;
    char *t4;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    t1 = (t0 + 1652U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(167, ng1);
    t3 = (1 * 1000000000LL);
    t2 = (t0 + 1552);
    xsi_process_wait(t2, t3);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(168, ng1);
    t2 = (t0 + 1552);
    t4 = (t0 + 3523);
    t6 = (t0 + 752U);
    t7 = (t0 + 1904);
    t8 = (t0 + 660U);
    t9 = (t0 + 1940);
    work_a_2596411307_2372691052_sub_3368731001_4163069965(t0, t2, t4, t6, 0U, 0U, t7, t8, 0U, 0U, t9);
    xsi_set_current_line(171, ng1);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}


extern void work_a_2596411307_2372691052_init()
{
	static char *pe[] = {(void *)work_a_2596411307_2372691052_p_0,(void *)work_a_2596411307_2372691052_p_1};
	static char *se[] = {(void *)work_a_2596411307_2372691052_sub_3368731001_4163069965};
	xsi_register_didat("work_a_2596411307_2372691052", "isim/keybtest1_isim_beh.exe.sim/work/a_2596411307_2372691052.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
