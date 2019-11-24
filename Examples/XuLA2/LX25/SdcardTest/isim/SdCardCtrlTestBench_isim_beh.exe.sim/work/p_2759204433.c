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
extern char *IEEE_P_2592010699;
extern char *STD_STANDARD;

unsigned char ieee_p_2592010699_sub_2507238156_503743352(char *, unsigned char , unsigned char );


unsigned char work_p_2759204433_sub_728693717_1989670373(char *t1, unsigned char t2)
{
    char t3[128];
    char t4[8];
    char t8[8];
    unsigned char t0;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    unsigned char t14;

LAB0:    t5 = (t3 + 4U);
    t6 = ((IEEE_P_2592010699) + 3320);
    t7 = (t5 + 88U);
    *((char **)t7) = t6;
    t9 = (t5 + 56U);
    *((char **)t9) = t8;
    xsi_type_set_default_value(t6, t8, 0);
    t10 = (t5 + 80U);
    *((unsigned int *)t10) = 1U;
    t11 = (t4 + 4U);
    *((unsigned char *)t11) = t2;
    if (t2 != 0)
        goto LAB2;

LAB4:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((unsigned char *)t6) = (unsigned char)2;

LAB3:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t14 = *((unsigned char *)t7);
    t0 = t14;

LAB1:    return t0;
LAB2:    t12 = (t5 + 56U);
    t13 = *((char **)t12);
    t12 = (t13 + 0);
    *((unsigned char *)t12) = (unsigned char)3;
    goto LAB3;

LAB5:;
}

int work_p_2759204433_sub_1928526409_1989670373(char *t1, int t2)
{
    char t3[248];
    char t4[8];
    char t8[8];
    char t14[8];
    int t0;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    int t20;
    int t21;
    int t22;
    unsigned char t23;
    int t24;

LAB0:    t5 = (t3 + 4U);
    t6 = ((STD_STANDARD) + 832);
    t7 = (t5 + 88U);
    *((char **)t7) = t6;
    t9 = (t5 + 56U);
    *((char **)t9) = t8;
    xsi_type_set_default_value(t6, t8, 0);
    t10 = (t5 + 80U);
    *((unsigned int *)t10) = 4U;
    t11 = (t3 + 124U);
    t12 = ((STD_STANDARD) + 832);
    t13 = (t11 + 88U);
    *((char **)t13) = t12;
    t15 = (t11 + 56U);
    *((char **)t15) = t14;
    xsi_type_set_default_value(t12, t14, 0);
    t16 = (t11 + 80U);
    *((unsigned int *)t16) = 4U;
    t17 = (t4 + 4U);
    *((int *)t17) = t2;
    t18 = (t5 + 56U);
    t19 = *((char **)t18);
    t18 = (t19 + 0);
    *((int *)t18) = 1;
    t20 = 0;
    t21 = 128;

LAB2:    if (t20 <= t21)
        goto LAB3;

LAB5:    t6 = (t11 + 56U);
    t7 = *((char **)t6);
    t20 = *((int *)t7);
    t0 = t20;

LAB1:    return t0;
LAB3:    t6 = (t11 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = t20;
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t22 = *((int *)t7);
    t23 = (t22 >= t2);
    if (t23 != 0)
        goto LAB5;

LAB6:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t22 = *((int *)t7);
    t24 = (t22 * 2);
    t6 = (t5 + 56U);
    t9 = *((char **)t6);
    t6 = (t9 + 0);
    *((int *)t6) = t24;

LAB4:    if (t20 == t21)
        goto LAB5;

LAB7:    t22 = (t20 + 1);
    t20 = t22;
    goto LAB2;

LAB8:;
}

int work_p_2759204433_sub_1537010684_1989670373(char *t1, unsigned char t2, int t3, int t4)
{
    char t6[16];
    int t0;
    char *t7;
    char *t8;
    char *t9;

LAB0:    t7 = (t6 + 4U);
    *((unsigned char *)t7) = t2;
    t8 = (t6 + 5U);
    *((int *)t8) = t3;
    t9 = (t6 + 9U);
    *((int *)t9) = t4;
    if (t2 != 0)
        goto LAB2;

LAB4:    t0 = t4;

LAB1:    return t0;
LAB2:    t0 = t3;
    goto LAB1;

LAB3:    t0 = t3;
    goto LAB1;

LAB5:    goto LAB3;

LAB6:    goto LAB3;

LAB7:;
}

double work_p_2759204433_sub_522640242_1989670373(char *t1, unsigned char t2, double t3, double t4)
{
    char t6[24];
    double t0;
    char *t7;
    char *t8;
    char *t9;

LAB0:    t7 = (t6 + 4U);
    *((unsigned char *)t7) = t2;
    t8 = (t6 + 5U);
    *((double *)t8) = t3;
    t9 = (t6 + 13U);
    *((double *)t9) = t4;
    if (t2 != 0)
        goto LAB2;

LAB4:    t0 = t4;

LAB1:    return t0;
LAB2:    t0 = t3;
    goto LAB1;

LAB3:    t0 = t3;
    goto LAB1;

LAB5:    goto LAB3;

LAB6:    goto LAB3;

LAB7:;
}

char *work_p_2759204433_sub_560388962_1989670373(char *t1, char *t2, char *t3, char *t4)
{
    char t5[128];
    char t6[24];
    char t9[16];
    char *t0;
    char *t7;
    unsigned int t8;
    char *t10;
    int t11;
    char *t12;
    int t13;
    char *t14;
    int t15;
    char *t16;
    char *t17;
    int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    unsigned char t27;
    char *t28;
    int t29;
    char *t30;
    int t31;
    char *t32;
    int t33;
    char *t34;
    int t35;
    int t36;
    int t37;
    char *t38;
    int t39;
    char *t40;
    int t41;
    char *t42;
    int t43;
    int t44;
    int t45;
    char *t46;
    int t47;
    char *t48;
    int t49;
    int t50;
    char *t51;
    int t52;
    unsigned int t53;
    unsigned int t54;
    char *t55;
    unsigned char t56;
    int t57;
    char *t58;
    int t59;
    char *t60;
    int t61;
    int t62;
    unsigned int t63;
    char *t64;
    int t65;
    unsigned int t66;
    unsigned int t67;
    char *t68;
    unsigned char t69;
    unsigned char t70;
    char *t71;
    char *t72;
    int t73;
    char *t74;
    int t75;
    int t76;
    unsigned int t77;
    char *t78;
    int t79;
    unsigned int t80;
    unsigned int t81;
    char *t82;

LAB0:    t7 = (t4 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t10 = (t4 + 0U);
    t11 = *((int *)t10);
    t12 = (t4 + 4U);
    t13 = *((int *)t12);
    t14 = (t4 + 8U);
    t15 = *((int *)t14);
    t16 = (t9 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = t11;
    t17 = (t16 + 4U);
    *((int *)t17) = t13;
    t17 = (t16 + 8U);
    *((int *)t17) = t15;
    t18 = (t13 - t11);
    t19 = (t18 * t15);
    t19 = (t19 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t19;
    t17 = (t5 + 4U);
    t20 = ((IEEE_P_2592010699) + 4024);
    t21 = (t17 + 88U);
    *((char **)t21) = t20;
    t22 = (char *)alloca(t8);
    t23 = (t17 + 56U);
    *((char **)t23) = t22;
    xsi_type_set_default_value(t20, t22, t9);
    t24 = (t17 + 64U);
    *((char **)t24) = t9;
    t25 = (t17 + 80U);
    *((unsigned int *)t25) = t8;
    t26 = (t6 + 4U);
    t27 = (t3 != 0);
    if (t27 == 1)
        goto LAB3;

LAB2:    t28 = (t6 + 12U);
    *((char **)t28) = t4;
    t30 = (t4 + 0U);
    t31 = *((int *)t30);
    t32 = (t4 + 4U);
    t33 = *((int *)t32);
    t34 = (t4 + 8U);
    t35 = *((int *)t34);
    if (t31 > t33)
        goto LAB8;

LAB9:    if (t35 == -1)
        goto LAB13;

LAB14:    t29 = t33;

LAB10:    t36 = (t29 - 1);
    t38 = (t4 + 0U);
    t39 = *((int *)t38);
    t40 = (t4 + 4U);
    t41 = *((int *)t40);
    t42 = (t4 + 8U);
    t43 = *((int *)t42);
    if (t39 > t41)
        goto LAB15;

LAB16:    if (t43 == -1)
        goto LAB20;

LAB21:    t37 = t39;

LAB17:    t44 = t37;
    t45 = t36;

LAB4:    if (t44 <= t45)
        goto LAB5;

LAB7:    t7 = (t4 + 0U);
    t13 = *((int *)t7);
    t10 = (t4 + 4U);
    t15 = *((int *)t10);
    t12 = (t4 + 8U);
    t18 = *((int *)t12);
    if (t13 > t15)
        goto LAB23;

LAB24:    if (t18 == -1)
        goto LAB28;

LAB29:    t11 = t15;

LAB25:    t14 = (t4 + 0U);
    t29 = *((int *)t14);
    t16 = (t4 + 8U);
    t31 = *((int *)t16);
    t33 = (t11 - t29);
    t8 = (t33 * t31);
    t19 = (1U * t8);
    t53 = (0 + t19);
    t20 = (t3 + t53);
    t27 = *((unsigned char *)t20);
    t21 = (t17 + 56U);
    t23 = *((char **)t21);
    t21 = (t4 + 0U);
    t36 = *((int *)t21);
    t24 = (t4 + 4U);
    t37 = *((int *)t24);
    t25 = (t4 + 8U);
    t39 = *((int *)t25);
    if (t36 > t37)
        goto LAB30;

LAB31:    if (t39 == -1)
        goto LAB35;

LAB36:    t35 = t37;

LAB32:    t30 = (t9 + 0U);
    t41 = *((int *)t30);
    t32 = (t9 + 8U);
    t43 = *((int *)t32);
    t44 = (t35 - t41);
    t54 = (t44 * t43);
    t34 = (t9 + 4U);
    t45 = *((int *)t34);
    xsi_vhdl_check_range_of_index(t41, t45, t43, t35);
    t63 = (1U * t54);
    t66 = (0 + t63);
    t38 = (t23 + t66);
    *((unsigned char *)t38) = t27;
    t7 = (t17 + 56U);
    t10 = *((char **)t7);
    t7 = (t9 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t0 = xsi_get_transient_memory(t8);
    memcpy(t0, t10, t8);
    t12 = (t9 + 0U);
    t11 = *((int *)t12);
    t14 = (t9 + 4U);
    t13 = *((int *)t14);
    t16 = (t9 + 8U);
    t15 = *((int *)t16);
    t20 = (t2 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = t11;
    t21 = (t20 + 4U);
    *((int *)t21) = t13;
    t21 = (t20 + 8U);
    *((int *)t21) = t15;
    t18 = (t13 - t11);
    t19 = (t18 * t15);
    t19 = (t19 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t19;

LAB1:    return t0;
LAB3:    *((char **)t26) = t3;
    goto LAB2;

LAB5:    t46 = (t4 + 0U);
    t47 = *((int *)t46);
    t48 = (t4 + 8U);
    t49 = *((int *)t48);
    t50 = (t44 - t47);
    t19 = (t50 * t49);
    t51 = (t4 + 4U);
    t52 = *((int *)t51);
    xsi_vhdl_check_range_of_index(t47, t52, t49, t44);
    t53 = (1U * t19);
    t54 = (0 + t53);
    t55 = (t3 + t54);
    t56 = *((unsigned char *)t55);
    t57 = (t44 + 1);
    t58 = (t4 + 0U);
    t59 = *((int *)t58);
    t60 = (t4 + 8U);
    t61 = *((int *)t60);
    t62 = (t57 - t59);
    t63 = (t62 * t61);
    t64 = (t4 + 4U);
    t65 = *((int *)t64);
    xsi_vhdl_check_range_of_index(t59, t65, t61, t57);
    t66 = (1U * t63);
    t67 = (0 + t66);
    t68 = (t3 + t67);
    t69 = *((unsigned char *)t68);
    t70 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t56, t69);
    t71 = (t17 + 56U);
    t72 = *((char **)t71);
    t71 = (t9 + 0U);
    t73 = *((int *)t71);
    t74 = (t9 + 8U);
    t75 = *((int *)t74);
    t76 = (t44 - t73);
    t77 = (t76 * t75);
    t78 = (t9 + 4U);
    t79 = *((int *)t78);
    xsi_vhdl_check_range_of_index(t73, t79, t75, t44);
    t80 = (1U * t77);
    t81 = (0 + t80);
    t82 = (t72 + t81);
    *((unsigned char *)t82) = t70;

LAB6:    if (t44 == t45)
        goto LAB7;

LAB22:    t11 = (t44 + 1);
    t44 = t11;
    goto LAB4;

LAB8:    if (t35 == 1)
        goto LAB11;

LAB12:    t29 = t31;
    goto LAB10;

LAB11:    t29 = t33;
    goto LAB10;

LAB13:    t29 = t31;
    goto LAB10;

LAB15:    if (t43 == 1)
        goto LAB18;

LAB19:    t37 = t41;
    goto LAB17;

LAB18:    t37 = t39;
    goto LAB17;

LAB20:    t37 = t41;
    goto LAB17;

LAB23:    if (t18 == 1)
        goto LAB26;

LAB27:    t11 = t13;
    goto LAB25;

LAB26:    t11 = t15;
    goto LAB25;

LAB28:    t11 = t13;
    goto LAB25;

LAB30:    if (t39 == 1)
        goto LAB33;

LAB34:    t35 = t36;
    goto LAB32;

LAB33:    t35 = t37;
    goto LAB32;

LAB35:    t35 = t36;
    goto LAB32;

LAB37:;
}

char *work_p_2759204433_sub_1232863408_1989670373(char *t1, char *t2, char *t3, char *t4)
{
    char t5[128];
    char t6[24];
    char t9[16];
    char *t0;
    char *t7;
    unsigned int t8;
    char *t10;
    int t11;
    char *t12;
    int t13;
    char *t14;
    int t15;
    char *t16;
    char *t17;
    int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    unsigned char t27;
    char *t28;
    int t29;
    char *t30;
    int t31;
    char *t32;
    int t33;
    char *t34;
    int t35;
    char *t36;
    int t37;
    char *t38;
    int t39;
    int t40;
    char *t41;
    int t42;
    unsigned int t43;
    unsigned int t44;
    char *t45;
    unsigned char t46;
    char *t47;
    char *t48;
    int t49;
    int t50;
    char *t51;
    int t52;
    char *t53;
    int t54;
    char *t55;
    int t56;
    char *t57;
    int t58;
    int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    char *t63;
    int t64;
    unsigned char t65;
    int t66;
    int t67;
    int t68;
    int t69;
    unsigned int t70;
    unsigned int t71;

LAB0:    t7 = (t4 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t10 = (t4 + 0U);
    t11 = *((int *)t10);
    t12 = (t4 + 4U);
    t13 = *((int *)t12);
    t14 = (t4 + 8U);
    t15 = *((int *)t14);
    t16 = (t9 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = t11;
    t17 = (t16 + 4U);
    *((int *)t17) = t13;
    t17 = (t16 + 8U);
    *((int *)t17) = t15;
    t18 = (t13 - t11);
    t19 = (t18 * t15);
    t19 = (t19 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t19;
    t17 = (t5 + 4U);
    t20 = ((IEEE_P_2592010699) + 4024);
    t21 = (t17 + 88U);
    *((char **)t21) = t20;
    t22 = (char *)alloca(t8);
    t23 = (t17 + 56U);
    *((char **)t23) = t22;
    xsi_type_set_default_value(t20, t22, t9);
    t24 = (t17 + 64U);
    *((char **)t24) = t9;
    t25 = (t17 + 80U);
    *((unsigned int *)t25) = t8;
    t26 = (t6 + 4U);
    t27 = (t3 != 0);
    if (t27 == 1)
        goto LAB3;

LAB2:    t28 = (t6 + 12U);
    *((char **)t28) = t4;
    t30 = (t9 + 0U);
    t31 = *((int *)t30);
    t32 = (t9 + 4U);
    t33 = *((int *)t32);
    t34 = (t9 + 8U);
    t35 = *((int *)t34);
    if (t31 > t33)
        goto LAB4;

LAB5:    if (t35 == -1)
        goto LAB9;

LAB10:    t29 = t33;

LAB6:    t36 = (t4 + 0U);
    t37 = *((int *)t36);
    t38 = (t4 + 8U);
    t39 = *((int *)t38);
    t40 = (t29 - t37);
    t19 = (t40 * t39);
    t41 = (t4 + 4U);
    t42 = *((int *)t41);
    xsi_vhdl_check_range_of_index(t37, t42, t39, t29);
    t43 = (1U * t19);
    t44 = (0 + t43);
    t45 = (t3 + t44);
    t46 = *((unsigned char *)t45);
    t47 = (t17 + 56U);
    t48 = *((char **)t47);
    t47 = (t9 + 0U);
    t50 = *((int *)t47);
    t51 = (t9 + 4U);
    t52 = *((int *)t51);
    t53 = (t9 + 8U);
    t54 = *((int *)t53);
    if (t50 > t52)
        goto LAB11;

LAB12:    if (t54 == -1)
        goto LAB16;

LAB17:    t49 = t52;

LAB13:    t55 = (t9 + 0U);
    t56 = *((int *)t55);
    t57 = (t9 + 8U);
    t58 = *((int *)t57);
    t59 = (t49 - t56);
    t60 = (t59 * t58);
    t61 = (1U * t60);
    t62 = (0 + t61);
    t63 = (t48 + t62);
    *((unsigned char *)t63) = t46;
    t7 = (t4 + 0U);
    t13 = *((int *)t7);
    t10 = (t4 + 4U);
    t15 = *((int *)t10);
    t12 = (t4 + 8U);
    t18 = *((int *)t12);
    if (t13 > t15)
        goto LAB22;

LAB23:    if (t18 == -1)
        goto LAB27;

LAB28:    t11 = t13;

LAB24:    t14 = (t4 + 0U);
    t31 = *((int *)t14);
    t16 = (t4 + 4U);
    t33 = *((int *)t16);
    t20 = (t4 + 8U);
    t35 = *((int *)t20);
    if (t31 > t33)
        goto LAB29;

LAB30:    if (t35 == -1)
        goto LAB34;

LAB35:    t29 = t33;

LAB31:    t37 = (t29 - 1);
    t39 = t37;
    t40 = t11;

LAB18:    if (t39 >= t40)
        goto LAB19;

LAB21:    t7 = (t17 + 56U);
    t10 = *((char **)t7);
    t7 = (t9 + 12U);
    t8 = *((unsigned int *)t7);
    t8 = (t8 * 1U);
    t0 = xsi_get_transient_memory(t8);
    memcpy(t0, t10, t8);
    t12 = (t9 + 0U);
    t11 = *((int *)t12);
    t14 = (t9 + 4U);
    t13 = *((int *)t14);
    t16 = (t9 + 8U);
    t15 = *((int *)t16);
    t20 = (t2 + 0U);
    t21 = (t20 + 0U);
    *((int *)t21) = t11;
    t21 = (t20 + 4U);
    *((int *)t21) = t13;
    t21 = (t20 + 8U);
    *((int *)t21) = t15;
    t18 = (t13 - t11);
    t19 = (t18 * t15);
    t19 = (t19 + 1);
    t21 = (t20 + 12U);
    *((unsigned int *)t21) = t19;

LAB1:    return t0;
LAB3:    *((char **)t26) = t3;
    goto LAB2;

LAB4:    if (t35 == 1)
        goto LAB7;

LAB8:    t29 = t31;
    goto LAB6;

LAB7:    t29 = t33;
    goto LAB6;

LAB9:    t29 = t31;
    goto LAB6;

LAB11:    if (t54 == 1)
        goto LAB14;

LAB15:    t49 = t50;
    goto LAB13;

LAB14:    t49 = t52;
    goto LAB13;

LAB16:    t49 = t50;
    goto LAB13;

LAB19:    t21 = (t17 + 56U);
    t23 = *((char **)t21);
    t42 = (t39 + 1);
    t21 = (t9 + 0U);
    t49 = *((int *)t21);
    t24 = (t9 + 8U);
    t50 = *((int *)t24);
    t52 = (t42 - t49);
    t8 = (t52 * t50);
    t25 = (t9 + 4U);
    t54 = *((int *)t25);
    xsi_vhdl_check_range_of_index(t49, t54, t50, t42);
    t19 = (1U * t8);
    t43 = (0 + t19);
    t30 = (t23 + t43);
    t27 = *((unsigned char *)t30);
    t32 = (t17 + 56U);
    t34 = *((char **)t32);
    t32 = (t9 + 0U);
    t56 = *((int *)t32);
    t36 = (t9 + 8U);
    t58 = *((int *)t36);
    t59 = (t39 - t56);
    t44 = (t59 * t58);
    t38 = (t9 + 4U);
    t64 = *((int *)t38);
    xsi_vhdl_check_range_of_index(t56, t64, t58, t39);
    t60 = (1U * t44);
    t61 = (0 + t60);
    t41 = (t34 + t61);
    t46 = *((unsigned char *)t41);
    t65 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t27, t46);
    t45 = (t17 + 56U);
    t47 = *((char **)t45);
    t45 = (t9 + 0U);
    t66 = *((int *)t45);
    t48 = (t9 + 8U);
    t67 = *((int *)t48);
    t68 = (t39 - t66);
    t62 = (t68 * t67);
    t51 = (t9 + 4U);
    t69 = *((int *)t51);
    xsi_vhdl_check_range_of_index(t66, t69, t67, t39);
    t70 = (1U * t62);
    t71 = (0 + t70);
    t53 = (t47 + t71);
    *((unsigned char *)t53) = t65;

LAB20:    if (t39 == t40)
        goto LAB21;

LAB36:    t11 = (t39 + -1);
    t39 = t11;
    goto LAB18;

LAB22:    if (t18 == 1)
        goto LAB25;

LAB26:    t11 = t15;
    goto LAB24;

LAB25:    t11 = t13;
    goto LAB24;

LAB27:    t11 = t15;
    goto LAB24;

LAB29:    if (t35 == 1)
        goto LAB32;

LAB33:    t29 = t31;
    goto LAB31;

LAB32:    t29 = t33;
    goto LAB31;

LAB34:    t29 = t31;
    goto LAB31;

LAB37:;
}

int work_p_2759204433_sub_1001445153_1989670373(char *t1, int t2, int t3)
{
    char t5[16];
    int t0;
    char *t6;
    char *t7;
    unsigned char t8;

LAB0:    t6 = (t5 + 4U);
    *((int *)t6) = t2;
    t7 = (t5 + 8U);
    *((int *)t7) = t3;
    t8 = (t2 > t3);
    if (t8 != 0)
        goto LAB2;

LAB4:    t0 = t3;

LAB1:    return t0;
LAB2:    t0 = t2;
    goto LAB1;

LAB3:    t0 = t2;
    goto LAB1;

LAB5:    goto LAB3;

LAB6:    goto LAB3;

LAB7:;
}


extern void work_p_2759204433_init()
{
	static char *se[] = {(void *)work_p_2759204433_sub_728693717_1989670373,(void *)work_p_2759204433_sub_1928526409_1989670373,(void *)work_p_2759204433_sub_1537010684_1989670373,(void *)work_p_2759204433_sub_522640242_1989670373,(void *)work_p_2759204433_sub_560388962_1989670373,(void *)work_p_2759204433_sub_1232863408_1989670373,(void *)work_p_2759204433_sub_1001445153_1989670373};
	xsi_register_didat("work_p_2759204433", "isim/SdCardCtrlTestBench_isim_beh.exe.sim/work/p_2759204433.didat");
	xsi_register_subprogram_executes(se);
}
