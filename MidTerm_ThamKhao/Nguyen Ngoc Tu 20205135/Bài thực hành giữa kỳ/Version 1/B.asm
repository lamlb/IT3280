.data
A:	.word		0:100 		# declaring table
Msg:	.asciiz		"Nhap ky tu A["
Msg1:	.asciiz		"]: "
enter:	.asciiz		"\n"
Msg3: 	.asciiz		" va 2 so lien ke la "
Msg4:	.asciiz		"Tich 2 so nho nhat: "
Msg5:	.asciiz		"Nhap phan tu mang:"
space:	.asciiz		" "

.text
main:	
	li 	$t0, 0		# t0 = index(i) = 0
	la 	$s0, A		# s0 = address(A)
get_array:
	sll	$t1, $t0, 2	# t1 = 4*i
 	add	$t2, $t1, $s0	# t2 = address(A[i])
 	print:
 		li	$v0, 4
		la	$a0, Msg
		syscall
		
		li	$v0, 1
		add	$a0, $t0, $zero
		syscall
		
		li	$v0, 4
		la	$a0, Msg1
		syscall
		
		li	$v0, 51
		la	$a0, Msg5
		syscall
		
	sw	$a0, 0($t2)	# a0 = A[i]
	
		li	$v0, 4
		la	$a0, enter
		syscall
		
 	addi	$t0, $t0, 1	# i = i + 1
 	beq	$a1, -3, solve_mult	# No data has been typed
 	j 	get_array
 	
solve_mult:
 	subi	$t0, $t0, 2	# last index = n - 1
	li	$v0, 4
	la	$a0, Msg4
	syscall	
	li	$s1, 0		#  = 0
	li	$t4, 999	# min = 999
	li	$s5, 0		# Gia tri dau
	li	$s6, 0		# Gia tri thu hai
	li	$t5, 0	
	loop:
		beq	$s1, $t0, end_loop	# if i == n - 1 -> ket thuc vong lap
		sll	$t1, $s1, 2	# t1 = 4*i
 		add	$t2, $t1, $s0	# t2 = address(A[i])
		lw	$t3, 0($t2)	# t3 = A[i]
		add	$t5, $t3, $zero	# temp = A[i]
		add	$s7, $t3, $zero	# s5 = A[i]
		addi	$t2, $t2, 4
		lw	$t3, 0($t2)	# t3 = A[i + 1]
		mult	$t5, $t3	# tmp = A[i] * A[i + 1]
		mfhi	$s3
		mflo	$s4
		add	$t5, $zero, $s4	# tmp = A[i] * A[i + 1]
		slt	$t6, $t5, $t4	# if tem < min (t5 < t4) -> t6 = 1 else t6 = 0
		beq	$t6, 0, continue
		add	$t4, $t5, $zero	# min = temp
		add	$s5, $s7, $zero
		add	$s6, $t3, $zero
	continue:
		li	$t5, 0		# reset temp
		addi	$s1, $s1, 1	
		j 	loop
end_loop:
	li	$v0, 1
	add	$a0, $t4, $zero
	syscall
	
	li	$v0, 4
	la	$a0, Msg3
	syscall
	
	li	$v0, 1
	add	$a0, $s5, $zero
	syscall
	
	li	$v0, 4
	la	$a0, space
	syscall
	
	li	$v0, 1
	add	$a0, $s6, $zero
	syscall
end:
