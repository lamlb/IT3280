.data 
str: .asciiz " Ch"
space: .ascii " "
message: .space 100
.text
main:
	# Read the string S from the user
	la $a0, message
	li $a1, 100
	li $v0, 8
	syscall
	
	la $t1, message
	la $t2, str
	subi $t1, $t1, 1
	
	li $a0, 0     # sum
	lb $s0, 0($t2)  # t0 = " "
	lb $s1, 1($t2)  # t1 = "C"
	lb $s2, 2($t2)  # t2 = "h"
	
comp:# load 3 character of the message continuously
	lb $t3, 0($t1)
	lb $t4, 1($t1)
	lb $t5, 2($t1) 
	beqz $t4, exit
	addi $t1, $t1, 1
	
	bne $s0, $t3, comp
	bne $s1, $t4, comp
	bne $s2, $t5, comp
	
	add $a0, $a0, 1
	j comp
exit:
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall