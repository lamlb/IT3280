# 6. Nhập vào xâu ký tự. In ra số từ trong xâu bắt đầu bằng 2 ký tự “Ch”.
.data
A: .space 100 # Buffer 100 byte chua chuoi ki tu can
.text
 li $v0, 8
 la $a0, A
 li $a1, 100
 syscall

	add $s0,$zero,$zero # $s0 = i = 0
	move $t5 ,$a0 
	add $t6, $0, $0 #$t6 = 0
	add $s7, $0, $0 #$s7 = 0
L1:
	add $t1,$s0,$t5 # $t1 = address of A[i]
	lbu $t2,0($t1) # $t2 = value at $t1 = A[i]
	
	addi $t7, $s0, 1 #$t7 = $s0 + 1
	add $t7, $t7, $t5 # $t7 = address of A[i+1]
	lbu $s6, 0($t7) # lay gia tri A[i+1]
	beq $t2,$zero,print # if A[i] == 0, jumb print
	nop
	j check1
	nop
next:	
	
	
	nop
	addi $s0,$s0,1 # $s0 = $s0 + 1 <-> i = i + 1
	j L1 # next character
	nop
	
check1:
	beq $t2, 67, check2
	nop
	j next
	nop
check2:
	beq $s6, 104, count
	nop
	
count: 
	addi $s7, $s7, 1 # tang $s7 them 1
	move $a0, $s7
	j next
	nop
	 
	

print: 
	li $v0, 1
 	syscall
done:
 