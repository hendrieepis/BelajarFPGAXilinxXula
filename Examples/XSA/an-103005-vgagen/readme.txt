VGA GENERATOR TEST APPLICATION WITH AN EMBEDDED PARALLEL PORT INTERFACE

    This is a modification of the application originally described in
    http://www.xess.com/appnotes/an-101204-vgagen.pdf . The original
    application was a combination of a VGA generator with an SDRAM
    controller that could display an image stored in SDRAM on a VGA monitor.
    The image had to be pre-loaded into the SDRAM on the XSA Board before
    the VGA generator was activated.

    The current design removes that restriction and allows you to upload and
    download images while the VGA generator is active. This is achieved by
    combining the SDRAM controller with the dualport interface described in
    http://www.xess.com/appnotes/an-071205-dualport.pdf . A parallel port
    interface is attached to one of the ports and the VGA generator is
    attached to the other. Images can be transferred through the parallel
    port of a PC to the SDRAM without disturbing the VGA generator as it
    accesses the SDRAM.

SOURCE FILES

    XSA_LIB/vga.vhd:
        This file describes the VGA generator circuit.

    XSA_LIB/sdramcntl.vhd:
        This file describes the core state machine of the SDRAM controller
        and the dualport module that attaches to it to provide dual
        independent channels to/from the SDRAM. See application note
        http://www.xess.com/appnotes/an-071205-dualport.pdf for details.

    XSA_LIB/xsasdramcntl.vhd:
        This file creates a wrapper around the SDRAM controller core to
        customize it for the XSA Board. See application note
        http://www.xess.com/appnotes/an-071205-xsasdramcntl.pdf for details.

    XSA_LIB/ramintfc_core.vhd:
        This file describes an interface that allows SDRAM address and data
        to be sent over the parallel port.

    XSA_LIB/xsasdramcntl_ppintfc.vhd:
        This file combines the XSA SDRAM controller, the dualport interface,
        and the parallel port interface. The resulting module has a single
        SDRAM interface that is identical to that of the xsasdramcntl.vhd
        module, and an additional port that connects to a few pins of the
        parallel port to provide access to the SDRAM from an attached PC.

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
        These files also show the correct attachment of the pins from the
        parallel port to the FPGA in order to upload/download the SDRAM
        using the GXSLOAD program.

    [50,100,200,3S1000]/test_vga/test_vga.npl:
        This project file tells WebPACK how to combine the source files to
        create the VGA generator test application for the XSA-50, XSA-100,
        XSA-200 or XSA-3S1000 Board.

    [50,100,200,3S1000]/test_vga/test_vga.bit:
        This is a configuration bitstream that has already been generated
        for the XSA-50, XSA-100, XSA-200 or XSA-3S1000 Board based on the
        files listed above.

    image.xes:
        This is an image file that can be downloaded into the SDRAM on the
        XSA Board which will then be displayed on a monitor by the VGA
        generator test application.

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

    3.  Open the modified GXSLOAD downloading tool that was provided.
        Drag-and-drop the test_vga.bit bitstream file generated in step #1
        into the FPGA pane of the GXSLOAD window. Then click on the Load
        button to download this file to the FPGA on the XSA Board.

    4.  Connect a monitor to the VGA port of the XSA Board. A random pattern
        of "snow" will appear on the monitor screen because the SDRAM has
        not been initialized with image data, yet.

    5.  Double-click the test_vga.bit file in the GXSLOAD FPGA pane to
        de-select it. Then drag-and-drop the image.xes file into the RAM
        pane. Uncheck the "Download RAM/Flash Interface" box below the RAM
        pane to stop GXSLOAD from overwriting the FPGA with the default
        SDRAM interface bitstream. Then click on the Load button to download
        the image data to the SDRAM.

    6.  An image will appear on the monitor screen (beginning at the top of
        the screen and proceeding to the bottom) as GXSLOAD downloads the
        contents of image.xes to the SDRAM.

EMBEDDING A PARALLEL PORT INTERFACE IN OTHER APPLICATIONS

    You can use the files in this application to provide access between the
    parallel port and the SDRAM in your own application. The necessary
    design files to include in your design are: sdramcntl.vhd,
    xsasdramcntl.vhd, ramintfc_core.vhd, xsasdramcntl_ppintfc.vhd, and
    common.vhd. You can also look in the test_vga.ucf file for your
    particular model of XSA Board to find the appropriate pin assignments to
    the SDRAM and parallel port. Then connect the logic for your application
    to the host-side interface shown in the xsasdramcntl_ppintfc.vhd file in
    the same manner as you would the standard SDRAM controller in the
    xsasdramcntl.vhd file. (Look at
    http://www.xess.com/appnotes/an-071205-xsasdramcntl.pdf for details on
    how to use the SDRAM controller.)

SEE ALSO

    Use the img2xes.pl Perl script to convert your own graphic files into a
    format that works with the VGA generator circuit. The most-current
    version of img2xes.pl can be found at http://wwww.xess.com/ho07000.html
    .

AUTHOR

    Dave Vanden Bout, X Engineering Software Systems Corp.

    Send bug reports to bugs@xess.com.

COPYRIGHT AND LICENSE

    Copyright 2005 by X Engineering Software Systems Corporation.

    This library is free software; you may redistribute it and/or modify it
    as long as you do not remove the attributions to the author or his
    employer.

HISTORY

    12/20/07 - Version 1.1 - Updated ramintfc_core.vhd to filter-out
    glitches on the downloading clock passed through the parallel port.

    10/30/05 - Version 1.0

