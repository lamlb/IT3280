.data
msg1: .asciiz "N co chua 2 chu so trung nhau"
msg2: .asciiz "N khong chua 2 chu so trung nhau"
.text 
main:
	li $v0, 5
	syscall
	move $a0, $v0
	
	li $t0, -1
	li $t1, -1
	li $t2, -1
	li $t3, -1
	li $t4, -1
	li $t5, -1
	li $t6, -1
	li $t7, -1
	li $t8, -1
	li $t9, -1
	
	li $s0, 10
	
check:
	beqz $a0, complete
	div $a0, $s0
	mfhi $a1     # remainder
	mflo $a0     # quotient
	
	beq $a1, 0, p0
	beq $a1, 1, p1
	beq $a1, 2, p2
	beq $a1, 3, p3
	beq $a1, 4, p4
	beq $a1, 5, p5
	beq $a1, 6, p6
	beq $a1, 7, p7
	beq $a1, 8, p8
	beq $a1, 9, p9

p0:
	add $t0, $t0, 1
	j check
p1:
	add $t1, $t1, 1
	j check
p2:
	add $t2, $t2, 1
	j check
p3:
	add $t3, $t3, 1
	j check
p4:
	add $t4, $t4, 1
	j check
p5:
	add $t5, $t5, 1
	j check
p6:
	add $t6, $t6, 1
	j check
p7:
	add $t7, $t7, 1
	j check
p8:
	add $t8, $t8, 1
	j check
p9:
	add $t9, $t9, 1
	j check
	
complete:
	bgtz $t0, trung
	bgtz $t1, trung
	bgtz $t2, trung
	bgtz $t3, trung
	bgtz $t4, trung
	bgtz $t5, trung
	bgtz $t6, trung
	bgtz $t7, trung
	bgtz $t8, trung
	bgtz $t9, trung
	
	la $a0, msg2
	li $v0, 4
	syscall
	b exit
trung:
	la $a0, msg1
	li $v0, 4
	syscall
	b exit
exit:
	li $v0, 10
	syscall