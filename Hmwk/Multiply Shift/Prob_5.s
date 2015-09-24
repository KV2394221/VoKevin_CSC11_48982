/*
	Kevin Vo
	Sept 23 2015
	CSC-11 48982
	5) Calculate area given raidus = 6.5
	R1 -> radius = 6.5
	R2 -> PI
	R3 -> R1^2
	R0 -> area (result)
*/

	.global _start
_start:
	LDR R1, =0x68     @BP -4 WD8
	LDR R2, =0x3242   @BP-12 WD16
	MUL R3, R1, R1    @BP -8 WD16
	MUL R0, R2, R3    @PB-20 WD32
	LSR R0, #20       @PB  0 WD8 
	MOV R7, #1
	SWI 0
