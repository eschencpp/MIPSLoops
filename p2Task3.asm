#Name: Eric Chen
#Date 11/14/22
#Objective: Take user input and find the exponentiated value.
#Github: https://github.com/eschencpp/MIPSLoops
.data
enterX: .asciiz "Please enter the base (x): "
enterY: .asciiz "Please enter the exponent (y): "
result: .asciiz "The result of "
powerOf: .asciiz " to the power of "
is: .asciiz " is: "
exitMsg: .asciiz "\nProgram run successfully. Exiting"

.text
main:	
	
	li $v0 4	#Prompt user for X
	la $a0, enterX
	syscall
	li $v0 5	#Store x in s0
	syscall
	move $s0, $v0
	
	li $v0 4	#Prompt user for Y
	la $a0, enterY
	syscall
	li $v0 5	#Store y in s1
	syscall
	move $s1, $v0
	
	li $s2, 0	#Intialize the counter to 0
	la $s3, ($s0)	#Set s3 = x
	
	beq $s1, 0, expZero #If exponent is zero then
	j loop
	exitLoop:
	
	resume:
	j outResult
	
	j exit
	
expZero:	#Handle edge case if y = 0
	li $s3, 1
	j resume
loop:
	addi $s2, $s2, 1 #Increment counter by 1
	beq $s2, $s1, exitLoop	#If counter equals exponent exit
	
	mul $s3,$s3,$s0	 #Multiply s3 and the base(x)
	j loop

outResult: 		#Output the result to user
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1	#Print x
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, powerOf
	syscall
	li $v0, 1	#Print y
	move $a0, $s1
	syscall
	li $v0, 4
	la $a0, is
	syscall
	li $v0, 1	#Print result
	move $a0, $s3
	syscall
	
	j exit
	

exit:			#Exit Program
	li $v0, 4
	la $a0, exitMsg
	syscall
	li $v0, 10
	syscall
	
