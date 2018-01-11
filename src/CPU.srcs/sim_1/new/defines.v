//全局
`define RstEnable 1'b1
`define RstDisable 1'b0
`define ZeroWord 32'h00000000
`define WriteEnable 1'b1
`define WriteDisable 1'b0
`define ReadEnable 1'b1
`define ReadDisable 1'b0
`define AluOpBus 7:0
`define AluSelBus 7:0
`define InstValid 1'b0
`define InstInvalid 1'b1
`define Stop 1'b1
`define NoStop 1'b0
`define InDelaySlot 1'b1
`define NotInDelaySlot 1'b0
`define Branch 1'b1
`define NotBranch 1'b0
`define InterruptAssert 1'b1
`define InterruptNotAssert 1'b0
`define TrapAssert 1'b1
`define TrapNotAssert 1'b0
`define True_v 1'b1
`define False_v 1'b0
`define ChipEnable 1'b1
`define ChipDisable 1'b0


`define EXE_LUI 7'b0110111
`define EXE_AUIPC 7'b0010111
`define EXE_JAL 7'b1101111
`define EXE_JALR 7'b1100111
`define EXE_BRANCH 7'b1100011
`define EXE_LOAD 7'b0000011
`define EXE_STORE 7'b0100011
`define EXE_OP_IMM 7'b0010011
`define EXE_OP 7'b0110011
`define EXE_MISC_MEM 7'b0001111


//指令
`define EXE_BEQ 3'b000
`define EXE_BNE 3'b001
`define EXE_BLT 3'b100
`define EXE_BGE 3'b101
`define EXE_BLTU 3'b110
`define EXE_BGEU 3'b111
`define EXE_LB 3'b000
`define EXE_LH 3'b001
`define EXE_LW 3'b010
`define EXE_LBU 3'b100
`define EXE_LHU 3'b101
`define EXE_SB 3'b000
`define EXE_SH 3'b001
`define EXE_SW 3'b010
`define EXE_ADDI 3'b000
`define EXE_SLTI 3'b010
`define EXE_SLTIU 3'b011
`define EXE_XORI 3'b100
`define EXE_ORI  3'b110
`define EXE_ANDI  3'b111
`define EXE_SLLI 3'b001
`define EXE_SRLI 7'b0000000
`define EXE_SRAI 7'b0100000
`define EXE_ADD 7'b0000000
`define EXE_SUB 7'b0100000
`define EXE_SLL 3'b001
`define EXE_SLT 3'b010
`define EXE_SLTU 3'b011
`define EXE_XOR 3'b100
`define EXE_SRL 7'b0000000
`define EXE_SRA 7'b0100000
`define EXE_OR 3'b110
`define EXE_AND 3'b111
`define EXE_FENCE 3'b000
`define EXE_FENCE_I 3'b001


`define EXE_NOP 7'b0000000
`define SSNOP 32'b00000000000000000000000001000000

//AluOp
`define EXE_AND_OP   8'b00100100
`define EXE_OR_OP    8'b00100101
`define EXE_XOR_OP  8'b00100110
`define EXE_NOR_OP  8'b00100111
`define EXE_ANDI_OP  8'b01011001
`define EXE_ORI_OP  8'b01011010
`define EXE_XORI_OP  8'b01011011
`define EXE_LUI_OP  8'b01011100
`define EXE_AUIPC_OP  8'b01001111

`define EXE_SLL_OP  8'b01111100
`define EXE_SLLI_OP  8'b00000100
`define EXE_SRL_OP  8'b00000010
`define EXE_SRLI_OP  8'b00000110
`define EXE_SRA_OP  8'b00000011
`define EXE_SRAI_OP  8'b00000111

`define EXE_SLT_OP  8'b00101010
`define EXE_SLTU_OP  8'b00101011
`define EXE_SLTI_OP  8'b01010111
`define EXE_SLTIU_OP  8'b01011000
`define EXE_ADD_OP  8'b00100000
`define EXE_SUB_OP  8'b00100010
`define EXE_ADDI_OP  8'b01010101

`define EXE_JAL_OP  8'b01010000
`define EXE_JALR_OP  8'b00001001
`define EXE_BEQ_OP  8'b01010001
`define EXE_BGE_OP  8'b01000001
`define EXE_BGEU_OP  8'b01001011
`define EXE_BLT_OP  8'b01000000
`define EXE_BLTU_OP  8'b01001010
`define EXE_BNE_OP  8'b01010010

`define EXE_LB_OP  8'b11100000
`define EXE_LBU_OP  8'b11100100
`define EXE_LH_OP  8'b11100001
`define EXE_LHU_OP  8'b11100101
`define EXE_LW_OP  8'b11100011
`define EXE_SB_OP  8'b11101000
`define EXE_SH_OP  8'b11101001
`define EXE_SW_OP  8'b11101011

`define EXE_FENCE_I_OP  8'b10101010
`define EXE_FENCE_OP  8'b10101011

`define EXE_NOP_OP    8'b00000000
//AluSel
`define EXE_RES_LOGIC 8'b00011000
`define EXE_RES_SHIFT 8'b00011001
`define EXE_RES_MOVE 8'b10101001
`define EXE_RES_ARITHMETIC 8'b10100110
`define EXE_RES_MUL 8'b10101000
`define EXE_RES_JUMP_BRANCH 8'b11110011
`define EXE_RES_LOAD 8'b00011011
`define EXE_RES_STORE 8'b00011010
`define EXE_RES_LOAD_STORE 3'b111

`define EXE_RES_NOP 8'b00000000

//指令存储器inst_rom
`define InstAddrBus 31:0
`define InstBus 31:0
`define InstMemNum 1024
`define InstMemNumLog2 17


//数据存储器data_ram
`define DataAddrBus 31:0
`define DataBus 31:0
`define DataMemNum 1024
`define DataMemNumLog2 17
`define ByteWidth 7:0


//通用寄存器regfile
`define RegAddrBus 4:0
`define RegZero 4'h0000
`define RegBus 31:0
`define RegWidth 32
`define DoubleRegWidth 64
`define DoubleRegBus 63:0
`define RegNum 32
`define RegNumLog2 5
`define NOPRegAddr 5'b00000
