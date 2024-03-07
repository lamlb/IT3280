.data
A:	.word		0:100 		# declaring table
Msg:	.asciiz		"Nhap ky tu A["
Msg1:	.asciiz		"]: "
enter:	.asciiz		"\n"
Msg3: 	.asciiz		"Nhap so N: "
Msg4:	.asciiz		"Tong cac so le chia het cho 5: "
Msg5:	.asciiz		"Nhap phan tu mang:"
space:	.asciiz		" "

.text
main:	
	li 	$t0, 0		# t0 = index(i) = 0
	la 	$s0, A		# s0 = address(A)
	
	li	$v0, 51
	la	$a0, Msg3
	syscall
	
	# a0 is now number of elements of the array
	add	$t5, $a0, $zero	# t5 = n
	
get_array:
	beq	$t0, $t5, end_input	# if i == n stop looping
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
		
	sw	$a0, 0($t2)	# a0 = input number = A[i]
	
		li	$v0, 4
		la	$a0, enter
		syscall
		
 	addi	$t0, $t0, 1	# i = i + 1
 	j 	get_array
 
end_input:
 	# subi	$t0, $t0, 2	# last index = n - 1
	
solve:
	li	$s1, 0		# s1 = index(i) = 0
	li	$s2, 0		# sum = s2 = 0
	li	$s3, 2		# divide for 2
	li	$s4, 5		# divide for 5
	loop:
		beq	$s1, $t0, end_loop	# if i == n then quit
		sll	$t1, $s1, 2		# t1 = 4*i
 		add	$t2, $t1, $s0		# t2 = address(A[i])
		lw	$t3, 0($t2)		# t3 = A[i]
		div	$t3, $s3		# Check A[i] odd
		mfhi	$t4			# Get remainder 
		beq	$t4, 0, continue	# even => skipping
		div	$t3, $s4		# Check A[i] % 5 == 0
		mfhi	$t4			# Get remainder 
		bne	$t4, 0, continue	# A[i] % 5 !== 0 => skip
		add	$s2, $s2, $t3		# sum += A[i]
	continue: 
		addi	$s1, $s1, 1		# i = i + 1	
		j 	loop
	end_loop:
	
print_result:
	li	$v0, 4
	la	$a0, Msg4
	syscall	
	
	li 	$v0, 1
	add	$a0, $zero, $s2
	syscall
end:
