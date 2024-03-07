#Bai b2
.data
A: .space 400
Message1: .asciiz "Nhap so phan tu: "
Message2: .asciiz "Nhap phan tu cho mang: "
.text
main:
	la 	$s1, A				# load address of array A
	
	li	$v0, 51
	la	$a0, Message1
	syscall
	
	beq $a1, -1, main		# nhap lai neu khong phai so nguyen
	beq $a1, -3, main		# nhap lai neu khong phai so nguyen
	beq $a1, -2, exit		# thoat khi nguoi dung an cancel
	
	add $s0, $zero, $a0		# N - so phan tu cua mang
	
	li $t0, 0				# i = 0

input_array:
	bge $t0, $s0, sort
input_element:
	li	$v0, 51
	la	$a0, Message2
	syscall
	
	beq $a1, -1, input_element	# nhap lai neu khong phai so nguyen
	beq $a1, -3, input_element	# nhap lai neu khong phai so nguyen
	beq $a1, -2, exit			# thoat khi nguoi dung an cancel
	
	sll $t1, $t0, 2			# $t1 = $t0 << 2 ( = 4*i)
	add $t1, $s1, $t1		# A + 4i
	
	sw $a0, 0($t1)			# lýu so vua nhap vao mang A
	
	add $t0, $t0, 1			# i++
	j input_array
sort:
		li 	$t0, 0
loop1:	beq $t0, $s0, end_loop1

		sll $t1, $t0, 2			# $t1 = $t0 << 2 ( = 4*i)
		add $t1, $s1, $t1		# A + 4i
			
		lw 	$a0, 0($t1)			# current_max = A[i]
		bgtz $a0, findMaxAndSwap
		add $t0, $t0, 1			# i++
		j loop1

findMaxAndSwap:
		add $t2, $t0, 1			# j = i + 1
loop2:	beq $t2, $s0, end_loop2
		
		sll $t3, $t2, 2			# $t3 = $t2 << 2 ( = 4*j)
		add $t3, $s1, $t3		# address(A + 4j) = address(A[j])
		
		lw $a1, 0($t3)			# A[j]
		bltz $a1, continue_loop2# A[j] < 0 => continue compare A[i] with A[j+1]
		
		slt $t4, $a0, $a1		# current_max < A[j] ?
		beqz $t4, continue_loop2
		
		sw $a1, 0($t1)			# store value of A[j] to A[i]
		sw $a0, 0($t3)			# store value of A[i] to A[j]
		
		add $a0, $a1, 0			# max = A[j]
continue_loop2:
		add $t2, $t2, 1			# j = j + 1
		j loop2
end_loop2:
		add $t0, $t0, 1			# i++
		j loop1
end_loop1:
exit:
