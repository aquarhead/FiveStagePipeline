`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Team.TeaWhen
// Engineer:       AquarHEAD L.
// 
// Create Date:    16:29:36 04/23/2013 
// Design Name: 
// Module Name:    DataPath 
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
module DataPath(
	input wire clock,
	input wire reset,
	
	input wire CS_Branch,
	input wire CS_RegWrite,
	
	input wire [4:0] RegDisplay,
	output wire [31:0] RegDispData
    );
		
	// Wire up registers here to support double bump
	Registers Registers(
		.clock(clock),
		.reset(reset),
		.rs(RegAdd_rs),
		.rt(RegAdd_rt),
		.rd(RegAdd_rd),
		.rdin(),
		.we(CS_RegWrite),
		.douts(RegData_rs),
		.doutt(RegData_rt),
		.rdisp(RegDisplay),
		.ddisp(RegDispData)
	);
	
	// Wire up stages and pipeline registers
	Stage_IF Stage_IF(
		.clock(clock),
		.reset(reset),
		.PR_EXMEM_ALUOutput(ToWB_ALUOutput),
		.CS_Branch(CS_Branch),
		
		.EndStageIF_PC(FromIF_PC),
		.EndStageIF_NewPC(FromIF_NewPC),
		.EndStageIF_Inst(FromIF_Inst),
		.EndStageIF_InstNum(FromIF_InstNum),
		.EndStageIF_InstType(FromIF_InstType)
	);
	
	PipelineReg_IFID PipelineReg_IFID(
		.clock(clock),
		.reset(reset),
		
		.FromIF_Inst(FromIF_Inst),
		.FromIF_NewPC(FromIF_NewPC),
		.FromIF_InstNum(FromIF_InstNum),
		.FromIF_InstType(FromIF_InstType),
		
		.ToID_Inst(ToID_Inst),
		.ToID_NewPC(ToID_NewPC),
		.ToID_InstNum(StageID_InstNum),
		.ToID_InstType(StageID_InstType)
	);
	
	// Wires not changing
	wire [3:0] StageID_InstNum;
	wire [3:0] StageID_InstType;
	
	Stage_ID Stage_ID(
		.clock(clock),
		.reset(reset),
		
		.BeginStageID_Inst(ToID_Inst),
		.BeginStageID_NewPC(ToID_NewPC),
		
		.RegAdd_rs(RegAdd_rs),
		.RegAdd_rt(RegAdd_rt),
		.RegData_rs(RegData_rs),
		.RegData_rt(RegData_rt),
		
		.EndStageID_Inst(FromID_Inst),
		.EndStageID_RegDataA(FromID_RegDataA),
		.EndStageID_RegDataB(FromID_RegDataB),
		.EndStageID_Imm(FromID_Imm)
	);
	
	PipelineReg_IDEX PipelineReg_IDEX(
		.clock(clock),
		.reset(reset),
		
		.FromID_Inst(FromID_Inst),
		.FromID_NewPC(ToID_NewPC),
		.FromID_RegDataA(FromID_RegDataA),
		.FromID_RegDataB(FromID_RegDataB),
		.FromID_Imm(FromID_Imm),
		.FromID_InstNum(StageID_InstNum),
		.FromID_InstType(StageID_InstType),
		
		.ToEX_Inst(ToEX_Inst),
		.ToEX_NewPC(ToEX_NewPC),
		.ToEX_RegDataA(ToEX_RegDataA),
		.ToEX_RegDataB(ToEX_RegDataB),
		.ToEX_Imm(ToEX_Imm),
		.ToEX_InstNum(ToEX_InstNum),
		.ToEX_InstType(ToEX_InstType)
	);
	
	Stage_EX Stage_EX(
	);
	
	PipelineReg_EXMEM PipelineReg_EXMEM(
	);
	
	Stage_MEM Stage_MEM(
	);
	
	PipelineReg_MEMWB PipelineReg_MEMWB(
	);
	
	Stage_WB Stage_WB(
	);
	
endmodule
