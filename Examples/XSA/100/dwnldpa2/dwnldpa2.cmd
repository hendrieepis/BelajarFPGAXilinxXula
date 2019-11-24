call vhdltidy dwnldpa2.vhd
call ucftidy -i dwnldpa2.ucf -o dwnldpa2.ucf
xst -intstyle ise -ifn __projnav/dwnldpa2.xst -ofn dwnldpa2.syr
ngdbuild -dd _ngo -uc dwnldpa2.ucf -aul -p xc9500xl dwnldpa2.ngc dwnldpa2.ngd
cpldfit -p xc9572xl-10-VQ64 -ofmt vhdl -optimize speed -htmlrpt -loc on -slew fast -init low -inputs 54 -pterms 25 -unused float -power std -terminate keeper dwnldpa2.ngd
hprep6 -s IEEE1149 -n "<4>!" -i dwnldpa2
impact -batch impactcmd.txt

