.data
Msg:	.asciiz 	"Nhap so nguyen duong N: "
Msg1:	.asciiz		"Nhap so nguyen duong M: "
Msg_out: 	.asciiz 	"Uoc chung lon nhat cua N va M: "
Msg_out1:	.asciiz 	"Chuong trinh ket thuc "
space: 		.asciiz 	" "

.text
main:
nhap:
	li	$v0, 51
	la	$a0, Msg
	syscall
	add 	$s0, $a0, $zero	# s0 = N
	
	li 	$v0, 51
	la	$a0, Msg1
	syscall
	add	$s1, $a0, $zero	# s1 = M
	
UCLN:
	slt	$s2, $zero, $s0		#if N > 0 -> s2 = 1 nguoc lai s2 = 0 
	beq	$s2, $zero, print1
	
	slt	$s2, $zero, $s1		#if M > 0 -> s2 = 1 nguoc lai s2 = 0 
	beq	$s2, $zero, print1
	
	beq	$s0, $zero, print	#if n = 0 -> ucln = m
	beq	$s1, $zero, print2	#if m = 0 -> ucln = n 
	beq	$s0, $s1, print
	slt 	$s2, $s1, $s0	# if s1 < s0 -> s2 = 1 nguoc lai s2 = 0
	beq	$s2, $zero, gcd
	sub	$s0, $s0, $s1
	j 	UCLN

 gcd:
 	sub	$s1, $s1, $s0 
 	j	UCLN
		
print1:
	li	$v0, 4
	la	$a0, Msg_out1
	syscall
	j	end

print2:
	li	$v0, 4
	la	$a0, Msg_out
	syscall
	li	$v0, 1
	addi	$a0, $s0, 0
	syscall
	j	end

	
print:
	li	$v0, 4
	la	$a0, Msg_out
	syscall
	li	$v0, 1
	addi	$a0, $s1, 0
	syscall
	j	end
	
	
end:
	
	
	
	 