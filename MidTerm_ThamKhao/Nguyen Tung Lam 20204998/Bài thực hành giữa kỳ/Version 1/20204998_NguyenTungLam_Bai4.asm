.data
msg1:		.asciiz			"Nhap xau s1: "
msg2:		.asciiz			"Nhap xau s2: "
s1:		.space			100		
s2:		.space			100
temp:		.space			100
temp1:		.space			100
msg3:		.asciiz			"Nhung ky tu thoa man yeu cau: "
enter:		.asciiz			"\n"
space:		.asciiz			" "

.text
main: 
get_string:
	# Get string 1
	li 	$v0, 54 		# service number
	la 	$a0, msg1		# Message of dialog
	la 	$a1, s1			# address of input buffer
	la 	$a2, 100 		# max-length
	syscall
	
	# Get string 2
	li 	$v0, 54 		# service number
	la 	$a0, msg2 		# Message of dialog
	la 	$a1, s2			# address of input buffer
	la 	$a2, 100 		# max-length
	syscall
	
get_length_s1:	
	la	$a0, s1			# a0 = address(string[0])
	add	$t0, $zero, $zero	# t0 = i = 0
	
check_char1: 	
	add 	$t1, $a0, $t0		# t1 = a0 + t0 = address(s1[i])
	lb	$t2, 0($t1)		# t2 = s1[i]
	beq 	$t2, $zero, exit1	# is null char ?
	addi	$t0, $t0, 1		# $t0 = $t0 + 1 <=> i = i + 1
	j	check_char1		# continue looping
exit1:
	# string 1 length = s1
	subi 	$t0, $t0, 1
	add	$s1, $t0, $zero			
	
get_length_s2:	
	la	$a0, s2			# a0 = address(s2[0])
	add	$t0, $zero, $zero	# t0 = i = 0
	
check_char2: 	
	add 	$t1, $a0, $t0		# t1 = a0 + t0 = address(s2[i])
	lb	$t2, 0($t1)		# t2 = s2[i]
	beq 	$t2, $zero, exit2	# is null char ?
	addi	$t0, $t0, 1		# $t0 = $t0 + 1 <=> i = i + 1
	j	check_char2		# continue looping
exit2:
	# string 2 length = s2
	subi 	$t0, $t0, 1
	add	$s2, $t0, $zero

	la	$s3, s1			# s3 = address(s1)
	la 	$s4, s2			# s4 = address(s2)

	li	$v0, 4
	la	$a0, msg3
	syscall	

	la	$a2, temp		# a2 = address(temp)
	la	$a3, temp1		# a3 = address(temp1)

case1: 	# iter s1
	li	$t0, 0			# index = t0 = 0
	li	$s7, 0			# index for temp string - j
	loop1:
		beq	$t0, $s1, end_loop1	# if index == s1.length then stop
		add	$t3, $t0, $s3		# t3 = address(s1[i])
		lb	$t5, 0($t3)		# t5 = s1[i]
		jal	find_char1		# Check if the char has been added or not
		beq	$a1, 1, continue1	# if letter has been added => skip else add
		add	$t7, $s7, $a2		# t7 = address(temp[j])
		sb	$t5, 0($t7)		# temp[j] = s1[i]	
		addi	$s7, $s7, 1		# j = j + 1
	continue1:
		addi	$t0, $t0, 1		# i = i + 1
		j 	loop1
	end_loop1:
	
	add	$v0, $s7, $zero		# v0 = temp.length
	li	$t0, 0			# reset index = t0 = 0
	li	$s7, 0			# reset index for temp1 string - j	
		
case2:  # iter s2
	li	$t0, 0			# index = t0 = 0
	li	$s7, 0			# index for temp1 string - j
	loop2:
		beq	$t0, $s2, end_loop2	# if index == s2.length then stop
		add	$t4, $t0, $s4		# t4 = address(s2[i])
		lb	$t6, 0($t4)		# t6 = s2[i]
		jal	find_char2		# Check if the char has been added or not
		beq	$a1, 1, continue2	# if letter has been added => skip else add
		add	$t7, $s7, $a3		# t7 = address(temp1[j])
		sb	$t6, 0($t7)		# temp1[j] = s2[i]
		addi	$s7, $s7, 1		# j = j + 1
	continue2:
		addi	$t0, $t0, 1		# i = i + 1
		j 	loop2
	end_loop2:
	
	add	$v1, $s7, $zero		# v1 = temp1.length
	li	$t0, 0			# reset index for temp - i - s1
	li	$s7, 0			# reset index for temp1 - j - s2
	
	# find char in 2 distinct temp array
	print_char:
		lb	$t3, 0($a2)			# t3 = temp[i])
		beq	$t3, $zero, end_print_char	# null then quit
		loop_to_find:
			lb	$t4, 0($a3)		# t4 = temp1[j])
			beq	$t4, $zero, end_print	# null then next char -> not found 
			beq	$t4, $t3, print		# if 2 char equal then print
			addi	$a3, $a3, 1		# move next
			j	loop_to_find
		stop_find:
	print:
		li 	$v0, 11
 		add 	$a0, $t3, $zero
 		syscall 
 		li	$v0, 4
 		la	$a0, space
 		syscall
	end_print:
		la 	$a3, temp1		# reset a3 = address(temp1)
		addi	$a2, $a2, 1 		# move next
		j	print_char
	end_print_char:
		# stop the program
		li	$v0, 10
		syscall
	
find_char1:
	li	$s6, 0		# index = s6 = 0
	li	$a1, 0		# Check = 0
	loop_find1:
		beq	$s6, $s7, end_find1	# if i == current temp.length => quit
		add	$t8, $s6, $a2		# t8 = address(temp)
		lb	$t9, 0($t8)		# t9 = temp[i]
		beq	$t9, $t5, found1	# if temp[i] = current equal char in s1/s2
		addi	$s6, $s6, 1		# i = i + 1
		j 	loop_find1
	found1:
		li	$a1, 1			# letter found => check = 1
	end_find1:
	jr	$ra
	
find_char2:
	li	$s6, 0		# index = s6 = 0
	li	$a1, 0		# Check = 0
	loop_find2:
		beq	$s6, $s7, end_find2	# if i == current temp1.length => quit
		add	$t8, $s6, $a3		# t8 = address(temp1[i])
		lb	$t9, 0($t8)		# t9 = temp1[i]
		beq	$t9, $t6, found2	# if temp1[i] = current char in s2
		addi	$s6, $s6, 1		# i = i + 1
		j 	loop_find2
	found2:
		li	$a1, 1			# letter found => check = 1
	end_find2:
	jr	$ra

	


	
	
