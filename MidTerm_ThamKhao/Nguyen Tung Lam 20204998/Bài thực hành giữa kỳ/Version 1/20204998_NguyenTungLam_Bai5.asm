.data
Msg:		.asciiz			"Nhap so nguyen duong N: "
Msg1: 		.asciiz			"Tong so chan: "
Msg2:		.asciiz			"Tong so le: "
enter:		.asciiz			"\n"
space: 		.asciiz 		" " 
commas:		.asciiz			", "
A:		.word			0:100		# create a table with 100 elements = 0

.text
# read integer with pop up
main:
	li	$v0, 51
	la	$a0, Msg
	syscall
	
	add	$s0, $a0, $zero 	# s0 = input number
	
	la 	$a0, A			# a0 = address(A[0])
	li	$t0, 0			# set iterator = 0
	li	$t1, 10 		# set divider
	add	$t2, $zero, $s0		# set temp = t2 = input number
	
	loop:
		beq	$t2, 0, out_loop
		div	$t2, $t1	# temp / 10 to get quotient and remainder
		mflo	$t3		# t3 = quotient 
		mfhi	$t4		# t4 = remainder
		sll	$s1, $t0, 2	# s1 = 4*i
 		add	$s2, $s1, $a0	# s2 = address(A[i])
 		sw	$t4, 0($s2)	# A[i] = t4 = remainder
 		add	$t2, $t3, $zero	# temp = temp / 10
		addi	$t0, $t0, 1	# increase iterator
		j 	loop
	out_loop:
		jal	getSum
		
	print:
		li 	$v0, 4
		la 	$a0, Msg1
		syscall
		
		li	$v0, 1
		add	$a0, $s2, $zero
		syscall
		
		li	$v0, 4
		la	$a0, enter
		syscall
		
		li 	$v0, 4
		la 	$a0, Msg2
		syscall

		li	$v0, 1
		add	$a0, $s5, $zero
		syscall

		# stop the program
		li 	$v0, 10
		syscall

getSum:
	li	$s1, 0			# i = 0
	li	$s2, 0			# sum1 = 0 - even
	li 	$s5, 0			# sum2 = 0 - odd
	li	$t3, 2			# divide for 2
	# subi	$t0, $t0, 1		# n = n - 1
	looper:
		slt	$s6, $t0, $s1	# if i > n => quit
		beq	$s6, 1, end_loop		
		sll	$t1, $s1, 2	# t1 = 4*i
 		add	$t2, $t1, $a0	# t2 = address(A[i])
 		lw	$t4, 0($t2)	# t4 = A[i]
 		div	$t4, $t3	# A[i] / 2
 		mfhi	$t5		# t5 = remainder = A[i] % 2
 		beq	$t5, 0, even	# if t5 == 0 then plus to even sum
 	odd:
 		add	$s5, $t4, $s5	# sum2 += A[i] - odd sum 
 		addi	$s1, $s1, 1	# i = i + 1
 		j 	looper
 	even:
 		add	$s2, $t4, $s2	# sum1 += A[i]
		addi	$s1, $s1, 1	# i = i + 1
		j	looper
	end_loop:
		jr 	$ra
end:
	
	

