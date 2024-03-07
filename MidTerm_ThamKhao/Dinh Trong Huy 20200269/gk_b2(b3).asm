.data
msg0: .asciiz "Nhap so phan tu: "
msg: .asciiz "Nhap phan tu: "
.align 2
list: .space 100

.text
main:
	# input len of array
	li $v0, 51
	la $a0, msg0
	syscall
	
	move $t0, $a0  #t0 is the length of array
	li $t1, 0      # iterator
	li $s0, 10     # use 10 to compute
	li $s1, 0
	j input
	
input:
	bge $t1, $t0, exit
	addi $t1, $t1, 1  
	# Nhap phan tu
	li $v0, 51
	la $a0, msg
	syscall
	
	div $a0, $s0
	mfhi $t2     # remainder
	bne $t2, 5, input    # Chia 10 khong du 5 => khong thoa man
	add $s1, $s1, $a0
	j input
exit:
	# Print the sum
	move $a0, $s1
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall