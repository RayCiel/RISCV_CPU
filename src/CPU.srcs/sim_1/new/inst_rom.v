

`include "defines.v"

module inst_rom(

//	input	wire										clk,
	input wire                    ce,
	input wire[`InstAddrBus]			addr,
	output reg[`InstBus]					inst
	
);

	reg[7:0]  inst_mem[0:`InstMemNum-1];

	initial $readmemh ( "ori.mem", inst_mem );

	always @ (*) begin
		if (ce == `ChipDisable) begin
			inst <= `ZeroWord;
	  end else begin
		  inst <= {inst_mem[addr[31:0]+3], inst_mem[addr[31:0]+2], inst_mem[addr[31:0]+1], inst_mem[addr[31:0]]};
		end
	end

endmodule