/* Kevin Vo
   CSC-11 (48982)
   12/7/15
   Assignment: Scaled Integer Assembly (Part 5)
*/

.data
.balign 4
disResult: .asciz "Terminal Velocity = %d\n"

.balign 4
disPres: .asciz "Dynamic Pressure = %d\n"

.balign 4
check: .asciz "\nCheck = %d\n"

.balign 4
hi: .asciz "hi\n"

.balign 4
return: .word 0

.text
	.global main
main:
	LDR R1, address_of_return
	STR LR, [R1]

	LDR R3, =0x3243F6A9	//PI
	LDR R4, =0x504816F0	//diaSQ
	LDR R5, =0x19Eb851E	//w
	LDR R6, =0x9B2EC51	//e

	//R1 = TERMINAL VELOCITY
	//R2 = DYNAMIC PRESSURE

	MOV R7, R5	//R7 = TOP

	MOV R3, R3, LSR#16
	MOV R6, R6, LSR#12
	MUL R8, R3, R6	//R8 = BOT

	MOV R8, R8, LSR#16	//BOT>>=16

	MOV R4, R4, LSR#16

	MUL R8, R4, R8

	MOV R8, R8, LSR#12

	MOV R1, #0	//Counter for divmod = V


divmod:
        SUB R7, R7, R8
        ADD R1, R1, #1

	CMP R7, R8
		BGE divmod


dynPressure:
	MUL R2, R1, R6
	MOV R2, R2, LSR#25
	MOV R9, R1
	MOV R1, R2
	LDR R0, address_of_disPres
	bl printf
	MOV R1, R9
	MOV R4, R1 //R4 = R1 = VtoSQRT

	@LDR R0, address_of_check
	@bl printf

sqrtBabylonian:
	MOV R1, R1, LSR#1	//R1 = v/2
	MOV R3, #0	//Counter for sqrtBabylonian
	@LDR R0, address_of_hi
	@bl printf
	@LDR R0, address_of_check
	@bl printf
	//R1 = 11112, good
	//Maybe R1 - 2 here soon

check_x_GE_one:
	//R1 = V/2 = 5556, good
	SUB R1, R1, #2
	ADD R3, R3, #1

	CMP R1, #1
		BGE check_x_GE_one


	MOV R1, R3 //R1 = count++
	MOV R5, #0

	LDR R0, address_of_check
	bl printf

while_R1_NEQ_R6:

	@LDR R0, address_of_hi
	@bl printf

	MOV R6, R1 //y = x.(n+1)
	ADD R1, R1, R4 //x = (x + VtoSQRT/x)
	MOV R1, R1, LSR#1

	@LDR R0, address_of_disPres
	@bl printf

VtoSQRT_over_x:
        @LDR R0, address_of_hi
        @bl printf

        SUB R4, R4, R1
        ADD R5, R5, #1
        CMP R4, R1
                BGT VtoSQRT_over_x
                b while_R1_NEQ_R6

	@CMP R6, R1
		@BEQ display

display:
	MOV R1, R1
	MOV R2, R2
	LDR R0, address_of_disResult
	bl printf

exit:
	LDR LR, address_of_return
	LDR LR, [LR]
	bx LR

address_of_disResult: .word disResult
address_of_return: .word return
address_of_disPres: .word disPres
address_of_hi: .word hi
address_of_check: .word check

//global
.global printf
