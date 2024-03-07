# Nhập vào xâu ký tự. In ra từ dài nhất có trong xâu.

.data
	string:	.space 100
.text 
input_data:
	li	$v0, 8
	la 	$a0, string
	li	$a1, 100
	syscall
main:
	li	$t0, 0	# i = 0
	add	$s5, $zero, $a0	# s5 -> string[0]

shortest_word:
	li	$t8, 0	# start
	li	$t9, -1	# end (Cho TH chuoi dai nhat la chuoi dau tien)
	li	$t7, 0	# length current word
	li	$s3, 0x0fffffff	# min
loop:
	add	$s0, $s5, $t0	# s0 = &string[i]
	lb	$s1, 0($s0)	# s1 = string[i]
	beq	$s1, 10, modify	# is null ?
	 
	beq	$s1, 32, modify		# if char = ' ' 
	 
	
continue:
	beq	$s1, 10, end_shortest_word
	
	addi	$t7, $t7, 1	# length current word ++	
	addi	$t0, $t0, 1	# i++
	j	loop
	
exit_loop:	
	j	end_shortest_word

modify:
	add	$t6, $zero, $t7	# temp of t7
	li	$t7, -1 	# reset length current word
	bge	$t6, $s3, continue
	 
	add	$s3, $zero, $t6	# set min = length current word
	sub	$t8, $t0, $t6	# start = i - length current word
	add	$t9, $zero, $t0	# set new end 
	j	continue	
			
end_shortest_word:	
	li	$v0, 11
	add	$t0, $zero, $t8	# i = start 
print_shortest:
	add	$s0, $s5, $t0	# s0 = &string[i]
	lb	$s1, 0($s0)	# $s1 = string[i]
	add 	$a0, $zero, $s1
	syscall
	addi	$t0, $t0, 1
	bge	$t0, $t9, end_main
	 
	j	print_shortest
end_main:												
														