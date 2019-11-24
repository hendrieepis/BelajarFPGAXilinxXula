<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="a" />
        <signal name="b" />
        <signal name="f" />
        <signal name="c" />
        <signal name="XLXN_11" />
        <port polarity="Input" name="a" />
        <port polarity="Input" name="b" />
        <port polarity="Output" name="f" />
        <port polarity="Input" name="c" />
        <blockdef name="and2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="144" ey="-144" sx="144" sy="-48" r="48" cx="144" cy="-96" />
            <line x2="64" y1="-48" y2="-48" x1="144" />
            <line x2="144" y1="-144" y2="-144" x1="64" />
            <line x2="64" y1="-48" y2="-144" x1="64" />
        </blockdef>
        <block symbolname="and2" name="XLXI_14">
            <blockpin signalname="b" name="I0" />
            <blockpin signalname="a" name="I1" />
            <blockpin signalname="XLXN_11" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_15">
            <blockpin signalname="c" name="I0" />
            <blockpin signalname="XLXN_11" name="I1" />
            <blockpin signalname="f" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1184" y="1296" name="XLXI_14" orien="R0" />
        <instance x="1584" y="1408" name="XLXI_15" orien="R0" />
        <branch name="a">
            <wire x2="1184" y1="1168" y2="1168" x1="1152" />
        </branch>
        <iomarker fontsize="28" x="1152" y="1168" name="a" orien="R180" />
        <branch name="b">
            <wire x2="1184" y1="1232" y2="1232" x1="1152" />
        </branch>
        <iomarker fontsize="28" x="1152" y="1232" name="b" orien="R180" />
        <branch name="f">
            <wire x2="1872" y1="1312" y2="1312" x1="1840" />
        </branch>
        <iomarker fontsize="28" x="1872" y="1312" name="f" orien="R0" />
        <branch name="c">
            <wire x2="1584" y1="1344" y2="1344" x1="1552" />
        </branch>
        <iomarker fontsize="28" x="1552" y="1344" name="c" orien="R180" />
        <branch name="XLXN_11">
            <wire x2="1504" y1="1200" y2="1200" x1="1440" />
            <wire x2="1504" y1="1200" y2="1280" x1="1504" />
            <wire x2="1584" y1="1280" y2="1280" x1="1504" />
        </branch>
    </sheet>
</drawing>