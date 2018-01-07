 .org 0x0
   .global _start
_start:
   ori  x3,x0,8
   addi  x3, x0, 16               # x3 = 16
   ori  x1,x0,1        # x1 = 1                
   j    s1
   ori  x1,x0,2        # x1 = 2
1:
   ori  x1,x0,111
   ori  x1,x0,110

   .org 0x20
s1:
   ori  x1,x0,3        # x1 = 3   
      .org 0x160
s6:
   ori x1,x0,14       # x1 = 14
   nop
   