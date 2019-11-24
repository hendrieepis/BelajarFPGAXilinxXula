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
extern char *IEEE_P_2717149903;
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_2507238156_503743352(char *, unsigned char , unsigned char );
void ieee_p_2717149903_sub_2486506143_2101202839(char *, char *, char *, unsigned int , unsigned int , char *, char *, char *, char *, unsigned char , char *, char *, char *, unsigned char , unsigned char , unsigned char , unsigned char , unsigned char , unsigned char , unsigned char );
void ieee_p_2717149903_sub_539877840_2101202839(char *, char *, char *, unsigned int , unsigned int , char *, char *, unsigned int , unsigned int , char *);


static void simprim_a_1387470219_3879906181_p_0(char *t0)
{
    char t7[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;

LAB0:    t1 = (t0 + 2276);
    t2 = (t0 + 984U);
    t3 = (t0 + 2896);
    t4 = (t0 + 800U);
    t5 = (t0 + 1408U);
    t6 = *((char **)t5);
    memcpy(t7, t6, 16U);
    ieee_p_2717149903_sub_539877840_2101202839(IEEE_P_2717149903, t1, t2, 0U, 0U, t3, t4, 0U, 0U, t7);
    t5 = (t0 + 2828);
    *((int *)t5) = 1;

LAB1:    return;
}

static void simprim_a_1387470219_3879906181_p_1(char *t0)
{
    char t7[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;

LAB0:    t1 = (t0 + 2412);
    t2 = (t0 + 1076U);
    t3 = (t0 + 2932);
    t4 = (t0 + 892U);
    t5 = (t0 + 1476U);
    t6 = *((char **)t5);
    memcpy(t7, t6, 16U);
    ieee_p_2717149903_sub_539877840_2101202839(IEEE_P_2717149903, t1, t2, 0U, 0U, t3, t4, 0U, 0U, t7);
    t5 = (t0 + 2836);
    *((int *)t5) = 1;

LAB1:    return;
}

static void simprim_a_1387470219_3879906181_p_2(char *t0)
{
    char t10[16];
    char t36[16];
    char t42[16];
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t11;
    char *t12;
    int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    int t17;
    unsigned int t18;
    char *t19;
    char *t20;
    char *t21;
    int64 t22;
    char *t23;
    char *t24;
    char *t25;
    int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    char *t31;
    int64 t32;
    char *t33;
    char *t34;
    char *t35;
    char *t37;
    char *t38;
    int t39;
    unsigned int t40;
    char *t41;
    char *t43;
    char *t44;

LAB0:    t1 = (t0 + 1008U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 1100U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t6 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t3, t5);
    t1 = (t0 + 1680U);
    t7 = *((char **)t1);
    t1 = (t7 + 0);
    *((unsigned char *)t1) = t6;
    t1 = (t0 + 2548);
    t2 = (t0 + 708U);
    t4 = (t0 + 2968);
    t7 = (t0 + 1748U);
    t8 = *((char **)t7);
    t7 = (t0 + 5412);
    t11 = (t10 + 0U);
    t12 = (t11 + 0U);
    *((int *)t12) = 1;
    t12 = (t11 + 4U);
    *((int *)t12) = 1;
    t12 = (t11 + 8U);
    *((int *)t12) = 1;
    t13 = (1 - 1);
    t14 = (t13 * 1);
    t14 = (t14 + 1);
    t12 = (t11 + 12U);
    *((unsigned int *)t12) = t14;
    t12 = (t0 + 1680U);
    t15 = *((char **)t12);
    t3 = *((unsigned char *)t15);
    t12 = xsi_get_transient_memory(64U);
    memset(t12, 0, 64U);
    t16 = t12;
    t17 = (0 - 0);
    t14 = (t17 * 1);
    t18 = (32U * t14);
    t19 = (t16 + t18);
    t20 = t19;
    t21 = (t0 + 984U);
    t22 = xsi_signal_get_last_event(t21);
    *((int64 *)t20) = t22;
    t23 = (t19 + 8U);
    t24 = (t0 + 1544U);
    t25 = *((char **)t24);
    memcpy(t23, t25, 16U);
    t24 = (t19 + 24U);
    *((unsigned char *)t24) = (unsigned char)1;
    t26 = (1 - 0);
    t27 = (t26 * 1);
    t28 = (32U * t27);
    t29 = (t16 + t28);
    t30 = t29;
    t31 = (t0 + 1076U);
    t32 = xsi_signal_get_last_event(t31);
    *((int64 *)t30) = t32;
    t33 = (t29 + 8U);
    t34 = (t0 + 1612U);
    t35 = *((char **)t34);
    memcpy(t33, t35, 16U);
    t34 = (t29 + 24U);
    *((unsigned char *)t34) = (unsigned char)1;
    t37 = (t36 + 0U);
    t38 = (t37 + 0U);
    *((int *)t38) = 0;
    t38 = (t37 + 4U);
    *((int *)t38) = 1;
    t38 = (t37 + 8U);
    *((int *)t38) = 1;
    t39 = (1 - 0);
    t40 = (t39 * 1);
    t40 = (t40 + 1);
    t38 = (t37 + 12U);
    *((unsigned int *)t38) = t40;
    t38 = ((IEEE_P_2717149903) + 740U);
    t41 = *((char **)t38);
    memcpy(t42, t41, 16U);
    t38 = (t0 + 1272U);
    t43 = *((char **)t38);
    t5 = *((unsigned char *)t43);
    t38 = (t0 + 1340U);
    t44 = *((char **)t38);
    t6 = *((unsigned char *)t44);
    ieee_p_2717149903_sub_2486506143_2101202839(IEEE_P_2717149903, t1, t2, 0U, 0U, t4, t8, t7, t10, t3, t12, t36, t42, (unsigned char)3, t5, t6, (unsigned char)1, (unsigned char)0, (unsigned char)0, (unsigned char)0);
    t1 = (t0 + 2844);
    *((int *)t1) = 1;

LAB1:    return;
}


extern void simprim_a_1387470219_3879906181_3513591752_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_3513591752", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_3513591752.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_3660669173_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_3660669173", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_3660669173.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_3690138306_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_3690138306", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_3690138306.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2609113104_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2609113104", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2609113104.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2587984423_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2587984423", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2587984423.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2550611070_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2550611070", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2550611070.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2579846729_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2579846729", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2579846729.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2626306252_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2626306252", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2626306252.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2638752507_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2638752507", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2638752507.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2668532898_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2668532898", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2668532898.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2664234645_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2664234645", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2664234645.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2509289896_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2509289896", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2509289896.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2488456095_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2488456095", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2488456095.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2302035966_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2302035966", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2302035966.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2297703881_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2297703881", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2297703881.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_2326958992_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_2326958992", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_2326958992.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_1711467869_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_1711467869", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_1711467869.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_1740670826_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_1740670826", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_1740670826.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_1703295283_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_1703295283", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_1703295283.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_1682199300_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_1682199300", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_1682199300.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_1628128641_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_1628128641", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_1628128641.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_1623797686_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_1623797686", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_1623797686.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_1653576175_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_1653576175", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_1653576175.didat");
	xsi_register_executes(pe);
}

extern void simprim_a_1387470219_3879906181_1666055128_init()
{
	static char *pe[] = {(void *)simprim_a_1387470219_3879906181_p_0,(void *)simprim_a_1387470219_3879906181_p_1,(void *)simprim_a_1387470219_3879906181_p_2};
	xsi_register_didat("simprim_a_1387470219_3879906181_1666055128", "isim/ROMtestbench_isim_par.exe.sim/simprim/a_1387470219_3879906181_1666055128.didat");
	xsi_register_executes(pe);
}
