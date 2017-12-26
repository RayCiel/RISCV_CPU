.org 0x0
        .global _start
_start:
        ori x1, x0, 0x210 # x1 = h210
        ori x2, x1, 0x021 # x2 = h231
        ori x5, x0, 0x68a # x5 = h68a
		
		or x1, x1, x2
		andi x3, x1, 0x68a
and x1, x3, x1
xori x4, x1, 0x110
xor x1, x4, x1
