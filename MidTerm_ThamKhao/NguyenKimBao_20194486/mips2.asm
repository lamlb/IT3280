.data
	A: .word 5, 4, 2
	n: .word 3 #So phan tu mang

.text
	la $a0, n #Luu dia chi n tai a0
	lw $a1, 0($a0)   # ($a1) = mem[($a0)+0]
	addi $a2, $zero, 3 #luu M = 3 tai a2
	la $a3, A #luu d/c A[0] tai a3

	#nhap A[n] = m; n++
	sll $s3, $a1, 2
	add $s4, $s3, $a3
	sw $a2, 0($s4)
	add $a1, $a1, 1

	#Bubble sort
	main: 
	j bubble_sort #sort
after_sort:
	li $v0, 10 #exit
	syscall
end_main:
	
bubble_sort:
	li $t0, 1 # isSwap? t0 = 1 -> van con swap  
	subi $a1, $a1, 1 # a1 = n-1
	loop:
		beq $t0, $zero, endloop # t0=0 -> k con swap -> end
		li $t0, 0
		add $t1, $zero, $zero # i = 0
		j loop2
	endloop:
end_bubble_sort:
	j after_sort
	
loop2:
	slt $t2, $t1, $a1 # i < n - 1 ??
	beq $t2, $zero, end_loop2 # t2 = 0 -> i >= n -> false
	sll $t3, $t1, 2 # t3 = 4*i
		
	add $a2, $a3, $t3  # a2 = d/c A[i]
	lw $t4 , 0($a2) #t4 = A[i]  
	lw $t5 , 4($a2) #t5 = A[i+1]
	
	sge $t2, $t4, $t5 # t4 >= t5 ??
	addi, $t1, $t1, 1 # i++
		
	bne $t2, $zero, loop2 # t2 = 1 -> ko can swap
	li $t0, 1 #cap nhat t0 = 1
	sw $t4, 4($a2) #swap A[i] va A[i+1]
	sw $t5, 0($a2)
	j loop2
end_loop2:
	j loop
