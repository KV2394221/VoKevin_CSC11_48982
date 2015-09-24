/*
	Kevin Vo
	Sept 23, 2015
	CSC-11 48982
	4) Calculate area given radius
	R1 -> radius = 6
	R2 -> Calculation for area
	R3 -> radius^2 (R3=R1*R1)
	R0 -> area
*/

	.global _start
_start:
	MOV R1, #6        @BP  0 WD8
	LDR R2, =0x324275 @BP-20 WD24
	MUL R3, R1, R1   
	MUL R0, R2, R3    @BP-20 WD32
	LSR R0, #20       @BP  0 WD8
	MOV R7, #1
	SWI 0
