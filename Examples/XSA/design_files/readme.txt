XSA BOARD DESIGN FILES

    These are the design files for various XSA Board test applications.

    You can find application notes on some of these applications at
    http://www.xess.com/ho03000.html.

APPLICATION DIRECTORIES

    The test applications for each XSA Board model are stored in a separate
    directory. Each directory has subdirectories, each containing a
    particular test application. The VHDL source files and pin assignments
    for each application are provided along with a WebPACK project
    description file so you can rebuild each application yourself.

    The function of the application in each subdirectory is listed below.

    dwnldpar:
        This is the parallel port interface for the CPLD on the XSA Board.

    dwnldpa2:
        This is the parallel port interface for the CPLD on the XSA-50 or
        XSA-100 Board when it is inserted into an XStend Board.

    fcnfg:
        This allows the CPLD to configure the FPGA with a bitstream stored
        in the Flash.

    fintf:
        This programs the CPLD or FPGA to create a parallel port-to-Flash
        upload/download interface.

    p3jtag:
        This is the Xilinx Parallel Cable III interface for the CPLD that
        lets you use iMPACT to download bitstreams to the XSA Board.

    p4jtag:
        This is the Xilinx Parallel Cable IV interface for the CPLD that
        lets you use iMPACT and a Parallel Cable IV to download bitstreams
        to the XSA-3S1000 Board.

    ramintfc:
        This programs the FPGA to create a parallel port-to-SDRAM
        upload/download interface.

    test_board:
        This programs the FPGA to perform a read/write test of the SDRAM.

    test_codec:
        This programs the FPGA to perform a loopback test of the codec on
        the XStend Board.

    test_kbd:
        This programs the FPGA to perform a test where keypresses of the
        digit keys on a PS/2 keyboard are displayed on the seven-segment
        LED.

    test_switches:
        This programs the FPGA to perform an uninteresting test where the
        DIP switch and pushbutton states affect the illumination of the
        seven-segment LED.

    test_timer:
        This programs the FPGA to perform an uninteresting test where the
        top segment of the seven-segment LED pulses at approximately a 1 Hz
        rate.

    test_vga:
        This programs the FPGA to with a VGA generator that will display an
        image stored in the SDRAM on a VGA monitor.

AUTHOR

    Dave Vanden Bout, X Engineering Software Systems Corp.

    Send bug reports to bugs@xess.com.

COPYRIGHT AND LICENSE

    Copyright 2004 by X Engineering Software Systems Corporation.

    These applications can be freely distributed and modified as long as you
    do not remove the attributions to the author or his employer.

HISTORY

    11/18/04 - Initial release.

