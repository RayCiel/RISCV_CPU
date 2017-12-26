

`include "defines.v"

module regfile(

	input	wire										clk,
	input wire										rst,

	//Ð´¶Ë¿Ú
	input wire										we,
	input wire[`RegAddrBus]				waddr,
	input wire[`RegBus]						wdata,

	//¶Á¶Ë¿Ú1
	input wire										re1,
	input wire[`RegAddrBus]			  raddr1,
	output reg[`RegBus]           rdata1,

	//¶Á¶Ë¿Ú2
	input wire										re2,
	input wire[`RegAddrBus]			  raddr2,
	output reg[`RegBus]           rdata2

);

	reg[`RegBus]  regs[0:`RegNum-1];
	always @(posedge clk)
	begin
		if (rst == `RstEnable)
		begin
			regs[0] <= 32'b0;
			regs[1] <= 32'b0;
			regs[2] <= 32'b0;
			regs[3] <= 32'b0;
			regs[4] <= 32'b0;
			regs[5] <= 32'b0;
			regs[6] <= 32'b0;
			regs[7] <= 32'b0;
			regs[8] <= 32'b0;
			regs[9] <= 32'b0;
			regs[10] <= 32'b0;
			regs[11] <= 32'b0;
			regs[12] <= 32'b0;
			regs[13] <= 32'b0;
			regs[14] <= 32'b0;
			regs[15] <= 32'b0;
			regs[16] <= 32'b0;
			regs[17] <= 32'b0;
			regs[18] <= 32'b0;
			regs[19] <= 32'b0;
			regs[20] <= 32'b0;
			regs[21] <= 32'b0;
			regs[22] <= 32'b0;
			regs[23] <= 32'b0;
			regs[24] <= 32'b0;
			regs[25] <= 32'b0;
			regs[26] <= 32'b0;
			regs[27] <= 32'b0;
			regs[28] <= 32'b0;
			regs[29] <= 32'b0;
			regs[30] <= 32'b0;
			regs[31] <= 32'b0;


		end
	end

		always @ (posedge clk) begin
			if (rst == `RstDisable) begin
				if((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) begin
					regs[waddr] <= wdata;
				end
			end
		end

		always @ (*) begin
			if(rst == `RstEnable) begin
				  rdata1 <= `ZeroWord;
		  end else if(raddr1 == `RegNumLog2'h0) begin
		  		rdata1 <= `ZeroWord;
		  end else if((raddr1 == waddr) && (we == `WriteEnable)
		  	            && (re1 == `ReadEnable)) begin
		  	  rdata1 <= wdata;
		  end else if(re1 == `ReadEnable) begin
		      rdata1 <= regs[raddr1];
		  end else begin
		      rdata1 <= `ZeroWord;
		  end
		end

		always @ (*) begin
			if(rst == `RstEnable) begin
				  rdata2 <= `ZeroWord;
		  end else if(raddr2 == `RegNumLog2'h0) begin
		  		rdata2 <= `ZeroWord;
		  end else if((raddr2 == waddr) && (we == `WriteEnable)
		  	            && (re2 == `ReadEnable)) begin
		  	  rdata2 <= wdata;
		  end else if(re2 == `ReadEnable) begin
		      rdata2 <= regs[raddr2];
		  end else begin
		      rdata2 <= `ZeroWord;
		  end
		end

	endmodule
