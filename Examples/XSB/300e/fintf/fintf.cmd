call vhdltidy fintf.vhd
xst -intstyle ise -ifn __projnav/fintf.xst -ofn fintf.syr
ngdbuild -dd _ngo -uc fintf.ucf -p xc9500xl fintf.ngc fintf.ngd
cpldfit -p xc9572xl-10-VQ64 -ofmt vhdl -optimize speed -htmlrpt -loc on -slew fast -init low -inputs 54 -pterms 25 -unused float -power std -terminate keeper fintf.ngd
hprep6 -s IEEE1149 -n "<1>!" -i fintf
impact -batch impactcmd.txt

