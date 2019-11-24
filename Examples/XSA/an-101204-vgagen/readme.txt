VGA GENERATOR TEST APPLICATION

    These are the design files for a test application of the VGA generator
    that combines it with an SDRAM controller to display an image stored in
    SDRAM.

    You can find an application note on the VGA generator at
    http://www.xess.com/appnotes/an-101204-vgagen.pdf.

SOURCE FILES

    XSA_LIB/vga.vhd:
        This file describes the VGA generator circuit.

    XSA_LIB/sdramcntl.vhd:
        This file describes the core state machine of the SDRAM controller.

    XSA_LIB/xsasdramcntl.vhd:
        This file creates a wrapper around the SDRAM controller core to
        customize it for the XSA Board.

    XSA_LIB/common.vhd:
        Some functions and definitions useful in many applications are
        provided in this file.

    [50,100,200,3S1000]/test_vga/test_vga.vhd:
        This is the top-level file that combines the SDRAM controller and
        the VGA generator to create the complete test application for the
        XSA-50, XSA-100, XSA-200 or XSA-3S1000 Board.

    [50,100,200,3S1000]/test_vga/test_vga.ucf:
        These are the pin assignments for mapping the VGA generator test
        application to the XSA-50, XSA-100, XSA-200 or XSA-3S1000 Board.

    [50,100,200,3S1000]/test_vga/test_vga.npl:
        This project file tells WebPACK how to combine the source files to
        create the VGA generator test application for the XSA-50, XSA-100,
        XSA-200 or XSA-3S1000 Board.

    [50,100,200,3S1000]/test_vga/test_vga.bit:
        This is a configuration bitstream that has already been generated
        for the XSA-50, XSA-100, XSA-200 or XSA-3S1000 Board based on the
        files listed above.

    image.xes:
        This is an image file that can be loaded into the SDRAM on the XSA
        Board which will then be displayed on a monitor by the VGA generator
        test application.

    XSA_LIB/vga-timing.xls:
        This is a simple spreadsheet that calculates the durations of the
        various portions of the horizontal and vertical sync signals given
        the height and width of the display and the pixel clock frequency.

COMPILING AND RUNNING THE VGA GENERATOR TEST APPLICATION

    1.  Open the project file for the VGA generator test application by
        double-clicking the test_vga.npl file for your particular model of
        XSA Board. All the compilation options can be set through the
        Project Navigator interface of WebPACK, and the generic parameters
        that affect the operation of the VGA generator can be set in the
        test_vga.vhd file. (The options for compiling a working application
        are already set in the files provided.) Then double-click the
        "Generate Programming File" icon in the Process pane and the
        bitstream will be generated.

    2.  The VGA generator test application needs a specific clock frequency
        to operate correctly. For the XSA-50 and XSA-100 Boards, use
        GXSSETCLK to set the clock divisor to 2 so that a 50 MHz clock is
        available. Nothing needs to be done for the XSA-200 or XSA-3S1000
        Boards since they have a fixed frequency 100 MHz oscillator.

    3.  Open the GXSLOAD downloading tool. Drag-and-drop the test_vga.bit
        bitstream file generated in step #1 into the FPGA pane of the
        GXSLOAD window. Drag-and-drop the image.xes file into the RAM pane.
        Then click on the Load button to download these files to the FPGA
        and SDRAM on the XSA Board.

    4.  Connect a monitor to the VGA port of the XSA Board. An image will
        appear on the monitor screen.

SEE ALSO

    Use the img2xes.pl Perl script to convert your own graphic files into a
    format that works with the VGA generator circuit. The most-current
    version of img2xes.pl can be found at http://wwww.xess.com/ho07000.html.

AUTHOR

    Dave Vanden Bout, X Engineering Software Systems Corp.

    Send bug reports to bugs@xess.com.

COPYRIGHT AND LICENSE

    Copyright 2004 by X Engineering Software Systems Corporation.

    This library is free software; you may redistribute it and/or modify it
    as long as you do not remove the attributions to the author or his
    employer.

HISTORY

    10/12/04 - Version 1.0

