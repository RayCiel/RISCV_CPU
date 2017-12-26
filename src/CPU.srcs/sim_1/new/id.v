

`include "defines.v"


module id(

	input wire										rst,
	input wire[`InstAddrBus]			pc_i,
	input wire[`InstBus]          inst_i,

	//处于执行阶段的指令要写入的目的寄存器信息
	input wire										ex_wreg_i,
	input wire[`RegBus]						ex_wdata_i,
	input wire[`RegAddrBus]       ex_wd_i,

	//处于访存阶段的指令要写入的目的寄存器信息
	input wire										mem_wreg_i,
	input wire[`RegBus]						mem_wdata_i,
	input wire[`RegAddrBus]       mem_wd_i,

	input wire[`RegBus]           reg1_data_i,
	input wire[`RegBus]           reg2_data_i,

	//送到regfile的信息
	output reg                    reg1_read_o,
	output reg                    reg2_read_o,
	output reg[`RegAddrBus]       reg1_addr_o,
	output reg[`RegAddrBus]       reg2_addr_o,

	//送到执行阶段的信息
	output reg[`AluOpBus]         aluop_o,
	output reg[`AluSelBus]        alusel_o,
	output reg[`RegBus]           reg1_o,
	output reg[`RegBus]           reg2_o,
	output reg[`RegAddrBus]       wd_o,
	output reg                    wreg_o
);

  wire[6:0] op = inst_i[6:0];
	wire[2:0] op2 = inst_i[14:12];
	wire[6:0] op3 = inst_i[31:25];
  reg[`RegBus]	imm;
  reg instvalid;


	always @ (*) begin
		if (rst == `RstEnable) begin
			aluop_o <= `EXE_NOP_OP;
			alusel_o <= `EXE_RES_NOP;
			wd_o <= `NOPRegAddr;
			wreg_o <= `WriteDisable;
			instvalid <= `InstValid;
			reg1_read_o <= 1'b0;
			reg2_read_o <= 1'b0;
			reg1_addr_o <= `NOPRegAddr;
			reg2_addr_o <= `NOPRegAddr;
			imm <= 32'h0;
	  end else begin
			aluop_o <= `EXE_NOP_OP;
			alusel_o <= `EXE_RES_NOP;
			wd_o <= inst_i[11:7];
			wreg_o <= `WriteDisable;
			instvalid <= `InstInvalid;
			reg1_read_o <= 1'b0;
			reg2_read_o <= 1'b0;
			reg1_addr_o <= inst_i[19:15];
      		reg2_addr_o <= inst_i[24:20];
			imm <= `ZeroWord;
		  case (op)
				`EXE_OP_IMM:
				begin
					case(op2)
		  			`EXE_ORI:			begin                        //ORI指令
		  					wreg_o <= `WriteEnable;		aluop_o <= `EXE_OR_OP;
		  					alusel_o <= `EXE_RES_LOGIC; reg1_read_o <= 1'b1;	reg2_read_o <= 1'b0;
								imm <= {{21{inst_i[31]}}, inst_i[30:20]};		wd_o <= inst_i[11:7];
								instvalid <= `InstValid;
		  			end
						`EXE_ANDI:
						begin
							wreg_o <= `WriteEnable;        aluop_o <= `EXE_AND_OP;
							alusel_o <= `EXE_RES_LOGIC;    reg1_read_o <= 1'b1;    reg2_read_o <= 1'b0;
							imm <= {{21{inst_i[31]}}, inst_i[30:20]};
							wd_o <= inst_i[11:7];
							instvalid <= `InstValid;
						end
						`EXE_XORI:
						begin
							wreg_o <= `WriteEnable;        aluop_o <= `EXE_XOR_OP;
							alusel_o <= `EXE_RES_LOGIC;    reg1_read_o <= 1'b1;    reg2_read_o <= 1'b0;
							imm <= {{21{inst_i[31]}}, inst_i[30:20]};
							wd_o <= inst_i[11:7];
							instvalid <= `InstValid;
						end
						`EXE_SLTI:
						begin
							wreg_o <= `WriteEnable;        aluop_o <= `EXE_SLT_OP;
							alusel_o <= `EXE_RES_ARITHMETIC; reg1_read_o <= 1'b1;    reg2_read_o <= 1'b0;
							imm <= {{21{inst_i[31]}}, inst_i[30:20]};        wd_o <= inst_i[11:7];
							instvalid <= `InstValid;
						end
						`EXE_SLTIU:
						begin
							wreg_o <= `WriteEnable;        aluop_o <= `EXE_SLTU_OP;
							alusel_o <= `EXE_RES_ARITHMETIC; reg1_read_o <= 1'b1;    reg2_read_o <= 1'b0;
							imm <= {{21{inst_i[31]}}, inst_i[30:20]};        wd_o <= inst_i[11:7];
							instvalid <= `InstValid;
						end
						`EXE_ADDI:
						begin
							wreg_o <= `WriteEnable;        aluop_o <= `EXE_ADD_OP;
							alusel_o <= `EXE_RES_ARITHMETIC; reg1_read_o <= 1'b1;    reg2_read_o <= 1'b0;
							imm <= {{21{inst_i[31]}}, inst_i[30:20]};        wd_o <= inst_i[11:7];
							instvalid <= `InstValid;
						end
            			`EXE_SLLI:
						begin
							wreg_o <= `WriteEnable;		aluop_o <= `EXE_SLL_OP;
							alusel_o <= `EXE_RES_SHIFT; reg1_read_o <= 1'b1;    reg2_read_o <= 1'b0;
							imm <= inst_i[24:20];        wd_o <= inst_i[11:7];
							instvalid <= `InstValid;
						end
						3'b101:
						begin
							case(op3)
								`EXE_SRLI:
								begin
									wreg_o <= `WriteEnable;		aluop_o <= `EXE_SRL_OP;
									alusel_o <= `EXE_RES_SHIFT; reg1_read_o <= 1'b1;    reg2_read_o <= 1'b0;
									imm <= inst_i[24:20];		wd_o <= inst_i[11:7];
									instvalid <= `InstValid;
								end
								`EXE_SRAI:
								begin
									wreg_o <= `WriteEnable;		aluop_o <= `EXE_SRA_OP;
									alusel_o <= `EXE_RES_SHIFT; reg1_read_o <= 1'b1;    reg2_read_o <= 1'b0;
									imm <= inst_i[24:20];		wd_o <= inst_i[11:7];
									instvalid <= `InstValid;
								end
							endcase
						end
		    	default:			begin
		    	end
		    endcase
			end
			`EXE_OP:
			begin
				case (op2)
					`EXE_OR:
					begin
						wreg_o <= `WriteEnable;        aluop_o <= `EXE_OR_OP;
						alusel_o <= `EXE_RES_LOGIC;     reg1_read_o <= 1'b1;    reg2_read_o <= 1'b1;
						instvalid <= `InstValid;
					end
					`EXE_AND:
					begin
						wreg_o <= `WriteEnable;        aluop_o <= `EXE_AND_OP;
						alusel_o <= `EXE_RES_LOGIC;      reg1_read_o <= 1'b1;    reg2_read_o <= 1'b1;
						instvalid <= `InstValid;
					end
					`EXE_XOR:
					begin
						wreg_o <= `WriteEnable;        aluop_o <= `EXE_XOR_OP;
						alusel_o <= `EXE_RES_LOGIC;        reg1_read_o <= 1'b1;    reg2_read_o <= 1'b1;
						instvalid <= `InstValid;
					end
					`EXE_SLL:
					begin
						wreg_o <= `WriteEnable;		aluop_o <= `EXE_SLL_OP;
						alusel_o <= `EXE_RES_SHIFT; reg1_read_o <= 1'b1;    reg2_read_o <= 1'b1;
						instvalid <= `InstValid;
					end
					`EXE_SLT:
					begin
						wreg_o <= `WriteEnable;        aluop_o <= `EXE_SLT_OP;
						alusel_o <= `EXE_RES_ARITHMETIC;        reg1_read_o <= 1'b1;    reg2_read_o <= 1'b1;
						instvalid <= `InstValid;
					end
					`EXE_SLTU:
					begin
						wreg_o <= `WriteEnable;        aluop_o <= `EXE_SLTU_OP;
						alusel_o <= `EXE_RES_ARITHMETIC;        reg1_read_o <= 1'b1;    reg2_read_o <= 1'b1;
						instvalid <= `InstValid;
					end
					3'b000:
					begin
						case(op3)
							`EXE_ADD:
							begin
								wreg_o <= `WriteEnable;        aluop_o <= `EXE_ADD_OP;
								alusel_o <= `EXE_RES_ARITHMETIC;        reg1_read_o <= 1'b1;    reg2_read_o <= 1'b1;
								instvalid <= `InstValid;
							end
							`EXE_SUB:
							begin
								wreg_o <= `WriteEnable;        aluop_o <= `EXE_SUB_OP;
								alusel_o <= `EXE_RES_ARITHMETIC;        reg1_read_o <= 1'b1;    reg2_read_o <= 1'b1;
								instvalid <= `InstValid;
							end
						endcase
					end
					3'b101:
					begin
						case(op3)
							`EXE_SRL:
							begin
								wreg_o <= `WriteEnable;		aluop_o <= `EXE_SRL_OP;
								alusel_o <= `EXE_RES_SHIFT; reg1_read_o <= 1'b1;    reg2_read_o <= 1'b1;
								instvalid <= `InstValid;
							end
							`EXE_SRA:
							begin
								wreg_o <= `WriteEnable;		aluop_o <= `EXE_SRA_OP;
								alusel_o <= `EXE_RES_SHIFT; reg1_read_o <= 1'b1;    reg2_read_o <= 1'b1;
								instvalid <= `InstValid;
							end
						endcase
					end
					default:
					begin
					end
				endcase
				end
				default:            begin
				end
		  endcase		  //case op
		end       //if
	end         //always


		always @ (*) begin
			if(rst == `RstEnable) begin
				reg1_o <= `ZeroWord;
			end else if((reg1_read_o == 1'b1) && (ex_wreg_i == 1'b1)
									&& (ex_wd_i == reg1_addr_o)) begin
				reg1_o <= ex_wdata_i;
			end else if((reg1_read_o == 1'b1) && (mem_wreg_i == 1'b1)
									&& (mem_wd_i == reg1_addr_o)) begin
				reg1_o <= mem_wdata_i;
		  end else if(reg1_read_o == 1'b1) begin
		  	reg1_o <= reg1_data_i;
		  end else if(reg1_read_o == 1'b0) begin
		  	reg1_o <= imm;
		  end else begin
		    reg1_o <= `ZeroWord;
		  end
		end


		always @ (*) begin
			if(rst == `RstEnable) begin
				reg2_o <= `ZeroWord;
			end else if((reg2_read_o == 1'b1) && (ex_wreg_i == 1'b1)
									&& (ex_wd_i == reg2_addr_o)) begin
				reg2_o <= ex_wdata_i;
			end else if((reg2_read_o == 1'b1) && (mem_wreg_i == 1'b1)
									&& (mem_wd_i == reg2_addr_o)) begin
				reg2_o <= mem_wdata_i;
		  end else if(reg2_read_o == 1'b1) begin
		  	reg2_o <= reg2_data_i;
		  end else if(reg2_read_o == 1'b0) begin
		  	reg2_o <= imm;
		  end else begin
		    reg2_o <= `ZeroWord;
		  end
		end
endmodule
