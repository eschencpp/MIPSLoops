#Name: Eric Chen
#Date 11/14/22
#Objective: Evaluate an array of test scores and print out the corresponding letter grades.
#Github: https://github.com/eschencpp/MIPSLoops
.data
scores: .word 32,56,78,66,88,90,93,100,101,82
size: .word 10
scoreTemplate: .asciiz "\nYour score is: "
outGradeAEC: .asciiz "\nYour grade is: A with Extra Credit\n"
outGradeA: .asciiz "\nYour grade is: A\n"
outGradeB: .asciiz "\nYour grade is: B\n"
outGradeC: .asciiz "\nYour grade is: C\n"
outGradeD: .asciiz "\nYour grade is: D\n"
outGradeF: .asciiz "\nYour grade is: F\n"
exitMsg: .asciiz "\nProgram run successfully. Exiting"
.text
main:
	la $s0, scores	#Pointer to score array
	li $s1, 0	#Counter
	lw $s2, size	#Size of the score array
	j loop
	j exit
	
loop:
	beq $s1, $s2, exit	#If counter equals array size then exit
	lw $s3, ($s0)
	
	li $v0, 4		#Print out score that is being evaluated
	la $a0, scoreTemplate
	syscall
	li $v0, 1
	move $a0, $s3
	syscall
	
	blt $s3, 60, gradeF	#Compare score to grades in ascending order
	blt $s3, 70, gradeD
	blt $s3, 80, gradeC
	blt $s3, 90, gradeB
	ble $s3, 100, gradeA
	bgt $s3, 100, gradeAEC
	syscall
	
	gradeReturn:		#Label to return to after grade is found
	
	addi $s1, $s1, 1	#Increment size counter by 1
	addi $s0, $s0, 4	#Increment array counter by 4 byte
	j loop
	
gradeAEC:
	li $v0, 4	#Print menu if grade > 100 (A with Extra Credit)
	la $a0, outGradeAEC
	syscall
	j gradeReturn
gradeA:
	li $v0, 4	#Print menu if grade >= 90 (A)
	la $a0, outGradeA
	syscall
	j gradeReturn
gradeB:
	li $v0, 4	#Print menu if grade >= 80 (B)
	la $a0, outGradeB
	syscall
	j gradeReturn
gradeC:
	li $v0, 4	#Print menu if grade >= 70 (C)
	la $a0, outGradeC
	syscall
	j gradeReturn
gradeD:
	li $v0, 4	#Print menu if grade >= 60 (D)
	la $a0, outGradeD
	syscall
	j gradeReturn
gradeF:
	li $v0, 4	#Print menu if grade >0 50 (F)
	la $a0, outGradeF
	syscall
	j gradeReturn

exit:			#Exit the program
	li $v0, 4
	la $a0, exitMsg
	syscall
	li $v0, 10
	syscall
	
