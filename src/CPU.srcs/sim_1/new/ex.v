

`include "defines.v"

module ex(

	input wire										rst,

	//送到执行阶段的信息
	input wire[`AluOpBus]         aluop_i,
	input wire[`AluSelBus]        alusel_i,
	input wire[`RegBus]           reg1_i,
	input wire[`RegBus]           reg2_i,
	input wire[`RegAddrBus]       wd_i,
	input wire                    wreg_i,


	output reg[`RegAddrBus]       wd_o,
	output reg                    wreg_o,
	output reg[`RegBus]						wdata_o

);

	reg[`RegBus] logicout;
	reg[`RegBus] shiftres;
		
	always @ (*) begin
		if(rst == `RstEnable) begin
			logicout <= `ZeroWord;
		end else begin
			case (aluop_i)
				`EXE_OR_OP:			begin
					logicout <= reg1_i | reg2_i;
				end
				`EXE_AND_OP:		begin
					logicout <= reg1_i & reg2_i;
				end
				`EXE_XOR_OP:		begin
					logicout <= reg1_i ^ reg2_i;
				end
				`EXE_LUI_OP:		begin
					logicout <= reg1_i;
				end
				`EXE_AUIPC_OP:	begin
					logicout <= reg1_i;
				end
				default:				begin
					logicout <= `ZeroWord;
				end
			endcase
		end    //if
	end      //always
	always @ (*) begin
		if(rst == `RstEnable) begin
			shiftres <= `ZeroWord;
		end else begin
			case (aluop_i)
				`EXE_SLL_OP:			begin
					shiftres <= reg1_i << reg2_i[4:0] ;
				end
				`EXE_SLLI_OP:
				begin
					shiftres <= reg1_i << reg2_i[4:0];
				end
				`EXE_SRL_OP:		begin
					shiftres <= reg1_i >> reg2_i[4:0];
				end
				`EXE_SRLI_OP:
				begin
					shiftres <= reg1_i >> reg2_i[4:0];
				end
				`EXE_SRA_OP:		begin
					shiftres <= ({32{reg1_i[31]}} << (6'd32-{1'b0, reg2_i[4:0]}))
												| reg1_i >> reg2_i[4:0];
				end
				`EXE_SRAI_OP:
				begin
					shiftres <= ({32{reg1_i[31]}} << (6'd32-{1'b0, reg2_i[4:0]})) | reg1_i >> reg2_i[4:0];
				end
				default:				begin
					shiftres <= `ZeroWord;
				end
			endcase
		end    //if
	end      //always

	always @ (*) begin
		wd_o <= wd_i;
		wreg_o <= wreg_i;
		case ( alusel_i )
		 `EXE_RES_LOGIC:		begin
			 wdata_o <= logicout;
		 end
		 `EXE_RES_SHIFT:		begin
			 wdata_o <= shiftres;
		 end
		 default:					begin
			 wdata_o <= `ZeroWord;
		 end
		endcase
	end

endmodule
