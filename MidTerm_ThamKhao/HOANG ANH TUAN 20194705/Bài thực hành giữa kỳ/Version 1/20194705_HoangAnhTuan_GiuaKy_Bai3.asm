# Nhập vào xâu ký tự. In ra các ký tự khác nhau có trong xâu

.data
	string:	.space 100
.text 
input_data:
	li	$v0, 8
	la 	$a0, string
	li	$a1, 100
	syscall
main:
	li	$t0, 0			# i = 0
	add	$s5, $zero, $a0		# s5 -> string[0]
getDiffChar:
	li	$t9, 0			# count = 0  
outer:
	add	$s0, $s5, $t0		# s0 = &string[i]
	lb	$s1, 0($s0)		# s1 = string[i]
	beq	$s1, 10, exit_getDiffChar	# is '\n' ?
	nop
	li	$t1, 0			# j = 0
	
	# so sanh cac ki tu truoc do voi ki tu hien tai
	inner:
		# If i = j then count++ 
		beq	$t1, $t0, increase_count
		nop
		add	$s2, $s5, $t1	# s2 = &string[j]
		lb	$s3, 0($s2)	# s3 = string[j]
		beq	$s3, $s1, exit_inner	# if s2 = s3 then not increase
		nop	
		addi	$t1, $t1, 1	# j++
		j	inner
	exit_inner:
		
	addi	$t0, $t0, 1		# i++
	j	outer
exit_outer:

increase_count:
	addi	$t9, $t9, 1	# count++
	j	exit_inner	
exit_getDiffChar:	
			
end_main:
	li	$v0, 1
	add	$a0, $zero, $t9
	syscall				
							
								
									
										
											
												
														
