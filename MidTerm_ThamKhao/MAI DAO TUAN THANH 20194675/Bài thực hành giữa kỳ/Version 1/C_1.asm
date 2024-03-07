.data
	xau: 	.space	32	#Luu xau da nhap
	Dodai:	.space	100
	msg:	.asciiz	"\nNhap xau: "
	message:	.asciiz	"\nTu ngan nhat: "
	enter:	.asciiz	"\n"

.text
start:	
	li	$v0, 4
	la	$a0, msg
	syscall

	li	$v0, 8
	la	$a0, Dodai
	la	$a1, 100 
	syscall

	li	$s0, 0		#i = 0
	li	$s2, 0		#j = 0
	li	$s4, 1111	# do dai ngan nhat, s4 luu do dai xau
	li	$s6, 0		# k = 0
	la	$a2, xau		#load dia chia xau

main:	jal	check		#vong lap qua chuoi dau vao
	
	li	$v0, 4		#in xau
	la	$a0, message	
	syscall

	la	$a1, Dodai
	j	printWord

exit:
	li	$v0, 10
	syscall

check:
	add	$t4, $s0, $a0	#gan dia chi cua A[i] vao $t4
	lb	$s1, 0($t4)	#load gia tri cua A[i] vao $s1

	slti	$t1, $s1, 65 	# nếu ascii nhỏ hơn 48 thì gán $t1 = 1
	bne	$t1, $zero, checkLength # lấy từ

	slti	$t1, $s1, 91	# nếu ascii lớn hơn 90 thì gán $t1 = 0 
	
	slti	$t2, $s1, 97	# nếu ascii nhỏ hơn 97
	slt	$t3, $t1, $t2	
	bne	$t3, $zero, checkLength	# lấy từ

	slti	$t1, $s1, 123	# nếu ascii lớn hơn 123
	beq	$t1, $zero, checkLength

	addi	$s0
	
