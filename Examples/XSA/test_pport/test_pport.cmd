REM Test the parallel port interface to an XSA-200 or XSA-3S1000 Board.

@CLS

@SET /P BOARD="Enter the model number for your board (XSA-200 or XSA-3S1000): "

:RUN_TEST
@echo Testing parallel port of %BOARD% 
@echo off

call xsload -b %BOARD% -fpga %BOARD%\test_pport_fpga.bit

call xsport 000001
call xsport 000011 -s
call xsport 000101
call xsport 000111 -s
call xsport 001001
call xsport 001011 -s
call xsport 001101
call xsport 001111 -s
call xsport 010001
call xsport 010011 -s
call xsport 010101
call xsport 010111 -s
call xsport 011001
call xsport 011011 -s
call xsport 011101
call xsport 011111 -s
call xsport 100001
call xsport 100011 -s
call xsport 100101
call xsport 100111 -s
call xsport 101001
call xsport 101011 -s
call xsport 101101
call xsport 101111 -s
call xsport 110001
call xsport 110011 -s
call xsport 110101
call xsport 110111 -s
call xsport 111001
call xsport 111011 -s
call xsport 111101
call xsport 111111 -s
call xsport 000001
call xsport 000011 -s

call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s
call xsport 000000
call xsport 000010 -s

call xsload -b %BOARD% -cpld %BOARD%\test_pport_cpld.svf

call xsport 000010
call xsport 000000 -s
call xsport 000110
call xsport 000100 -s
call xsport 001010
call xsport 001000 -s
call xsport 001110
call xsport 001100 -s
call xsport 010010
call xsport 010000 -s
call xsport 010110
call xsport 010100 -s
call xsport 011010
call xsport 011000 -s
call xsport 011110
call xsport 011100 -s
call xsport 100010
call xsport 100000 -s
call xsport 100110
call xsport 100100 -s
call xsport 101010
call xsport 101000 -s
call xsport 101110
call xsport 101100 -s
call xsport 110010
call xsport 110000 -s
call xsport 110110
call xsport 110100 -s
call xsport 111010
call xsport 111000 -s
call xsport 111110
call xsport 111100 -s
call xsport 000010
call xsport 000000 -s

call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s
call xsport 000011
call xsport 000001 -s

call xstest -b %BOARD%

SET /P DONE="Press ENTER to close this window..."
