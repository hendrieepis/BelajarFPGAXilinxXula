PS/2 KEYBOARD TEST APPLICATION

    These are the design files for a test application of the PS/2 keyboard
    interface that combines it with the LED digit to display numbers typed
    on the keyboard.

    You can find an application note on the keyboard interface at
    http://www.xess.com/appnotes/an-102104-keybrd.pdf.

SOURCE FILES

    XSA_LIB/ps2_kbd.vhd:
        This file describes the PS/2 keyboard interface circuit.

    XSA_LIB/common.vhd:
        Some functions and definitions useful in many applications are
        provided in this file.

    [50,100,200,3S1000]/test_kbd/test_kbd.vhd:
        This is the top-level file that combines the keyboard interface with
        a seven-segment LED driver to create the complete test application
        for the XSA-50, XSA-100, XSA-200 or XSA-3S1000 Board.

    [50,100,200,3S1000]/test_kbd/test_kbd.ucf:
        These are the pin assignments for mapping the keyboard test
        application to the XSA-50, XSA-100, XSA-200 or XSA-3S1000 Board.

    [50,100,200,3S1000]/test_kbd/test_kbd.npl:
        This project file tells WebPACK how to combine the source files to
        create the keyboard test application for the XSA-50, XSA-100,
        XSA-200 or XSA-3S1000 Board.

    [50,100,200,3S1000]/test_kbd/test_kbd.bit:
        This is a configuration bitstream that has already been generated
        for the XSA-50, XSA-100, XSA-200 or XSA-3S1000 Board based on the
        files listed above.

COMPILING AND RUNNING THE KEYBOARD TEST APPLICATION

    1.  Open the project file for the keyboard test application by
        double-clicking the test_kbd.npl file for your particular model of
        XSA Board. All the compilation options can be set through the
        Project Navigator interface of WebPACK, and the generic parameters
        that affect the operation of the keyboard test application can be
        set in the test_kbd.vhd file. (The options for compiling a working
        application are already set in the files provided.) Then
        double-click the "Generate Programming File" icon in the Process
        pane and the bitstream will be generated.

    2.  The keyboard test application needs a specific clock frequency to
        operate correctly. For the XSA-50 and XSA-100 Boards, use GXSSETCLK
        to set the clock divisor to 2 so that a 50 MHz clock is available.
        Nothing needs to be done for the XSA-200 or XSA-3S1000 Boards since
        they have a fixed frequency 100 MHz oscillator.

    3.  Open the GXSLOAD downloading tool. Drag-and-drop the test_kbd.bit
        bitstream file generated in step #1 into the FPGA pane of the
        GXSLOAD window. Then click on the Load button to download this file
        to the FPGA on the XSA Board.

    4.  Connect a PS/2 keyboard to the keyboard/mouse port of the XSA Board.
        Press-and-release any of the digits '0' - '9' on the keyboard and
        the corresponding numeral will appear on the seven-segment LED.
        Pressing any other key will cause an 'E' to be displayed.

AUTHOR

    Dave Vanden Bout, X Engineering Software Systems Corp.

    Send bug reports to bugs@xess.com.

COPYRIGHT AND LICENSE

    Copyright 2004 by X Engineering Software Systems Corporation.

    This library is free software; you may redistribute it and/or modify it
    as long as you do not remove the attributions to the author or his
    employer.

HISTORY

    10/21/04 - Version 1.0

