# Nhập mảng số nguyên từ bàn phím. 
# Sắp xếp các phần tử có giá trị dương giảm dần.


.data
	A:	.word	
	warning: .asciiz "So phan tu cua mang khong duoc am"

.text
input_numbers_element:
	li 	$v0, 5 		
	syscall
	bltz	$v0, warn		# N < 0 then warning
	nop
	addi 	$s6, $s6, 0x10010000 	# s6 -> 0x10010000 = &A
	add 	$s5, $s6, $zero		# s5 -> 0x10010000 = &A
	
	addi 	$s0, $v0, 0 		# s0 = N
	li 	$t1, 0			# i = 0
	  
input_element_array:
	bge	$t1, $s0, end_input	# if (i >= N) then exit
	nop
	li 	$v0, 5			# read integer
	syscall
	sw 	$v0, 0($s5)		# s5[i] = v0
	
	addi 	$t1, $t1, 1		# i++
	addi 	$s5, $s5, 4		# s5 -> &A[i]
	
	j 	input_element_array
end_input:

main:
	addi 	$a0, $s6, 0 		# a0 = &A[0]
	addi 	$a1, $s0, 0 		# a1 = N
	jal	sort_pos_desc
	
	li 	$t1, 0 			# i = 0
	addi 	$s5, $s6, 0		# s5 = s6 -> &A[0]
print:
	bge	$t1, $s0, end_print	# if (i >= N) then exit
	nop
	li 	$v0, 1 			# print integer
	lw 	$a0, 0($s5)		# a0 = A[i]
	syscall
	
	li 	$v0, 11 		# print comma
	li 	$a0, 44	
	syscall  
	
	addi	$t1, $t1, 1		# i++
	addi 	$s5, $s5, 4		# s5 -> &A[i] 
	
	j 	print
end_print:
end_main:
	j 	exit
swap: 
	sw	$s0,0($t9)		# A[j] = A[i]
	sw	$s1,0($t8)		# A[i] = A[j] 
	jr	$ra			
sort_pos_desc:
	addi 	$sp, $sp, -8		# Khoi tao 2 vung nho 4 byte
	sw 	$ra, 4($sp)		# push $ra -> stack
	sw 	$s0, 0($sp)		# push $s0 -> stack
	
	li 	$t1, 0			# i = 0
	li 	$t2, 0			# j = 0
	addi 	$t8, $a0, 0		# t8 -> &A[0]
loop_i: 
	bge	$t1, $a1, end_loop_i	# if i >= n exit loop i
	nop
	lw 	$s0, 0($t8)		# s0 = A[i]
	blez 	$s0, continue_i 	# if (A[i] <= 0)
	nop
	addi  	$t2, $t1, 1		# j = i+1
	addi 	$t9, $t8, 4		# t9 -> A[i+1]	
loop_j:
	bge	$t2, $a1, end_loop_j	# if (j >= n) exit loop j
	nop
	lw 	$s1, 0($t9)		# s1 = A[j]
	blez 	$s1, continue_j		# if (s1 <= 0) -> continue_j
	nop
	bge	$s0, $s1, continue_j	# if (A[j] > A[i]) -> swap
	nop	
	jal 	swap
	nop
continue_j:
	addi 	$t2, $t2, 1		# j++
	addi 	$t9, $t9, 4		# t9 -> &A[j]
	lw 	$s0, 0($t8)		# s0 = A[i]
	j	loop_j	
end_loop_j:
continue_i:
	addi 	$t1, $t1, 1		# i++
	addi 	$t8, $t8, 4		# t8 -> &A[i]
	j	loop_i	
end_loop_i:
	lw 	$s0, 0($sp)
	lw 	$ra, 4($sp)	
	addi	$sp, $sp, 8		# free memory
	jr 	$ra
end_sort_pos_desc:
warn:
	li	$v0, 4
	la	$a0, warning
	syscall

exit:
