==========================================
XuLA-200 FPGA Design Examples
==========================================

Each of these directories contains a complete Xilinx ISE WebPACK 13 design project for the XuLA-200 board.

    blinker/:
        A simple LED blinker design from chapter 4 of the book "FPGAs!? Now What?".

    counter/:
        A simple 26-bit counter that is driven by a 100 MHz clock and whose bits are output
        throuogh the prototyping header. This is a good design to check the functioning of
        the XuLA board. *Check the setting for the startup-clock - either JTAGCLK or CCLK -
        to make sure it complies with how you are using the XuLA board - either USB-connected
        or standalone.*

    fast_blinker/:
        The LED blinker design sped-up by using a DCM from chapter 5 of the book "FPGAs!? Now What?".

    fintf_jtag/:
        This design is used by GXSLOAD when it needs to read or write the contents of the
        serial flash configuration memory on the XuLA board.

    fjmem_intfc/:
        This design is used to interface the XuLA board to the UrJtag tools.
        It is not yet ready for general release, so it is currently not supported.

    hostio_test/:
        This design is used to test the ability of the HostIo modules to pass
        data back-and-forth between the FPGA and the host PC.

    logic_analyzer/:
        This is a version of the Sump logic analyzer for the XuLA board.
        It is not yet completely functional.

    ramintfc_jtag/:
        This design is used by GXSLOAD when it needs to read or write the contents of the
        SDRAM on the XuLA board.

    rand_test/:
        This design uses the hostio module to gather samples from the random-number generator module.

    sdram_test/:
        This design is a simple tester for the SDRAM that reports success or failure
        through the prototyping header rather than sending the status through the JTAG
        and USB links.

    test_board_jtag/:
        This design is used by GXSTEST to test the SDRAM and report the success or failure
        through the JTAG and USB links.

    vga_bram/:
        This is a character-based VGA module. *It uses a third-party VGA controller and not the 
        VGA module in the XuLA_lib directory.*

=back
