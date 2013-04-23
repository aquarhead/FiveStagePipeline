`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Team.TeaWhen
// Engineer:       AquarHEAD L.
// 
// Create Date:    16:27:38 04/23/2013 
// Design Name: 
// Module Name:    CPU 
// Project Name:   Five Stage Pipeline CPU
// Target Devices: Spartan3E Starter Kit
// Tool versions:  Xilinx ISE 14.1
// Description:    I love @Lilian_Ye
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CPU(
	);
	
	Control Control (
	);
	
	DataPath DataPath (
		.clock(StepButton),
		.reset(ResetButton)
	);
	
endmodule
