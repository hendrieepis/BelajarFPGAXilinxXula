XSA BOARD <-> PC PARALLEL PORT TESTER

These programs and configuration bitstreams will test the parallel port interface
between your PC and the XSA-200 or XSA-3S1000 Board.

The test_pport_fpga.bit/test_pport_cpld.svf files configure the FPGA/CPLD with a 
simple loadable counter.  The test_pport.cmd batch file toggles the parallel port 
data pins in a sequence that loads the counter and then toggles the clock.  
The value in the counter is sent back on the parallel port status pins
where the PC checks it for correctness.

To run the parallel port test:

1) Connect your XSA Board to the parallel port of your PC.
2) Unpack the test_port.zip file.
3) Double-click the test_pport.cmd icon in the top-level folder.
4) At the prompt in the command widow that appears, enter the model of XSA Board you are using.

As the test runs, you should see the sequence 

   0 1 2 3 4 5 6 7 8 9 a b c d e f 0 1 2 3 4 5 6 7 8 9 a b c d e f 0

followed by the sequence

   0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0

If you see the sequences shown above, then your parallel port is probably working correctly.
If there is an error, either the parallel port is malfunctioning and the signals are not getting 
to the board, or the CPLD (which sits between the FPGA and the parallel port) is having a problem 
and is stopping the parallel port signals from getting to the FPGA.  Please take a screenshot 
of the result and send it to help@xess.com.

You may use an FTP client(e.g. ws_ftp) to download test_pport.zip from our anonymous FTP server 
using the following login information:
 
FTP hostname: xess.com 
userid: anonymous 
password: guest 

You will find the test_pport.zip file in the pub subdirectory. 
