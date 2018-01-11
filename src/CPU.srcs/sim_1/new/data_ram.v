`timescale 1ns / 1ps
`include "defines.v"

module data_ram(

	input	wire										clk,
	input wire										ce,
	input wire										we,
	input wire[`DataAddrBus]			addr,
	input wire[3:0]								sel,
	input wire[`DataBus]						data_i,
	output reg[`DataBus]					data_o

);
	//reg[`ByteWidth]  data_mem0[0:`DataMemNum-1];
	//reg[`ByteWidth]  data_mem1[0:`DataMemNum-1];
	//reg[`ByteWidth]  data_mem2[0:`DataMemNum-1];
	//reg[`ByteWidth]  data_mem3[0:`DataMemNum-1];
	reg[7 : 0] data_mem[0: `DataMemNum - 1];

	always @ (posedge clk) begin
		if (ce == `ChipDisable) begin
			//data_o <= ZeroWord;
		end else if(we == `WriteEnable) begin
			  if (sel == 4'b0100) begin
		      //data_mem3[addr[15:0]] <= data_i[31:24];
			  //data_mem2[addr[15:0]] <= data_i[23:16];
			  //data_mem1[addr[15:0]] <= data_i[15:8];
			  //data_mem0[addr[15:0]] <= data_i[7:0];
			  {data_mem[addr + 3],
			  data_mem[addr + 2],
			  data_mem[addr + 1],
			  data_mem[addr]} <= data_i[31:0];
			end
			  else if (sel == 4'b0010) begin
		      //data_mem1[addr[15:0]] <= data_i[15:8];
			  //data_mem0[addr[15:0]] <= data_i[7:0];
			  {data_mem[addr + 1],
			  data_mem[addr]} <= data_i[15:0];
			end
		  	  else if (sel == 4'b0001) begin
		      //data_mem0[addr[15:0]] <= data_i[7:0];
			  {data_mem[addr]} <= data_i[7:0];
			end
		end
	end

	always @ (*) begin
		if (ce == `ChipDisable) begin
			data_o <= `ZeroWord;
	  end else if(we == `WriteDisable) begin
		    //data_o <= {data_mem3[addr[15:0]],
		     //          data_mem2[addr[15:0]],
		     //          data_mem1[addr[15:0]],
		     //          data_mem0[addr[15:0]]};
			 data_o <=  {data_mem[addr + 3],
 		              	 data_mem[addr + 2],
 		                 data_mem[addr + 1],
 		                 data_mem[addr]};
		end else begin
				data_o <= `ZeroWord;
		end
	end

endmodule
