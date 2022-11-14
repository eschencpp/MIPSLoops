#Name: Eric Chen
#Date 11/14/22
#Objective: Take a score (integer > 0) from the user and output the corresponding letter grade.
#Github: https://github.com/eschencpp/MIPSLoops
.data
mainMenu: .asciiz "\n--------------------Main Menu--------------------"
options: .asciiz "\n(1) Get Letter grade \n(2) Exit program\n"
buffer: .space 20
optionPrompt: .asciiz "Enter either 1 or 2 as an option: "
inputPrompt: .asciiz "Enter score as integer: "
invalidInput: .asciiz "\nInput is invalid. Please enter your input again.\n"
exitMsg: .asciiz "\nProgram run successfully. Exiting"
outGradeAEC: .asciiz "\nYour grade is: A with Extra Credit\n"
outGradeA: .asciiz "Your grade is an: A"
outGradeB: .asciiz "Your grade is a: B"
outGradeC: .asciiz "Your grade is a: C"
outGradeD: .asciiz "Your grade is a: D"
outGradeF: .asciiz "Your grade is an: F"
repromptUser: .asciiz "Would you like to enter a new score?\n(Y)Yes  (N)No"
rePrompt: .asciiz "\nEnter 'Y' or 'N': "
line: .asciiz "\n---------------------------------------------------------\n"
.text

.macro seperator
li $v0, 4
la $a0, line
syscall
.end_macro

main:
	li $v0, 4	#Print main menu
	la $a0, mainMenu
	syscall
	
	inputLoop:
	li $v0, 4	#Print options menu
	la $a0, options
	syscall
	
	li $v0, 4	#Print options menu
	la $a0, optionPrompt
	syscall
	li $v0,8 #take in string input
        la $a0, buffer #load byte space into address
        li $a1, 20 # allot the byte space for string
        move $t0,$a0 #save string to t0
        syscall
        lb $t1, ($t0) #load first byte to t1
	
	beq $t1, '1', continue	#Check if input is 1 or 2
	bne $t1, '2', invInp
continue:
	beq $t1, '1', takeUserScore
	beq $t1, '2', exit
	
	takeUserScore:
	li $v0, 4	#Prompt user for input
	la $a0, inputPrompt
	syscall
	
	li $v0, 5	#Take score input
	syscall
	move $s1, $v0	
	
	seperator
	
	blt $s1, 0 , invalidScore	#Check input score for grade
	blt $s1, 60, gradeF	
	blt $s1, 70, gradeD
	blt $s1, 80, gradeC
	blt $s1, 90, gradeB
	ble $s1, 100, gradeA
	bgt $s1, 100, gradeAEC
	
	gradeReturn:
	repromptLoop:
	seperator
	li $v0, 4	#Prompt user if they want enter another score
	la $a0, repromptUser
	syscall
	
	li $v0, 4	#Show options
	la $a0, rePrompt
	syscall
	
	li $v0, 12	#Take char Y or N input
	syscall
	move $s2, $v0
	
	beq $s2, 'Y', main	#Check user input and jump accordingly
	beq $s2, 'y', main
	beq $s2, 'N', exit
	beq $s2, 'n', exit
	j invInp2
	
	
	j exit
	
exit:			#Exit Program
	li $v0, 4
	la $a0, exitMsg
	syscall
	
	li $v0, 10
	syscall
	
gradeAEC:
	li $v0, 4	#Print menu if grade > 100 (A with Extra Credit)
	la $a0, outGradeAEC
	syscall
	j gradeReturn
gradeA:
	li $v0, 4	#Print main menu
	la $a0, outGradeA
	syscall
	j gradeReturn
gradeB:
	li $v0, 4	#Print main menu
	la $a0, outGradeB
	syscall
	j gradeReturn
gradeC:
	li $v0, 4	#Print main menu
	la $a0, outGradeC
	syscall
	j gradeReturn
gradeD:
	li $v0, 4	#Print main menu
	la $a0, outGradeD
	syscall
	j gradeReturn
gradeF:
	li $v0, 4	#Print main menu
	la $a0, outGradeF
	syscall
	j gradeReturn
invInp:
	li $v0, 4	#Tell user if invalid input for user menu
	la $a0, invalidInput
	syscall
	j main
invInp2:
	li $v0, 4	#Tell user if invalid input for program continue
	la $a0, invalidInput
	syscall
	j repromptLoop
invalidScore:		#Tell user if invalid score input
	li $v0, 4
	la $a0, invalidInput
	syscall
	j takeUserScore
