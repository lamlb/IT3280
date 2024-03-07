.data
	Message:  .asciiz "Nhap so nguyen duong M:"
	Message1: .asciiz "Nhap so nguyen duong N:"
	Message2: .asciiz " BCNN cua "
	Message3: .asciiz " va "
	Message4: .asciiz " la: "
.text
main:
	li 	$v0, 51
	la	$a0, Message		#Nhap M
	syscall
	add	$s0, $a0, $zero		
	
	li 	$v0, 51
	la	$a0, Message1		#Nhap N
	syscall
	add	$s1, $a0, $zero
	
	jal 	LCM	
	nop
print:
	add	$t0, $a0, $zero
	li	$v0, 4
	la	$a0, Message2
	syscall
	add	$a0, $s0, $zero
	li	$v0, 1
	syscall				#in $s0
			
	li	$v0, 4
	la	$a0, Message3
	syscall
	li	$v0,1
	add	$a0, $s1, $zero
	syscall				# in $s1
	
	li	$v0, 4
	la	$a0, Message4
	syscall
	li	$v0, 1
	add	$a0, $t0, 0
	syscall				#in BCNN
quit:
	li	$v0, 10
	syscall
LCM:	
	add	$sp, $sp, -4
	sw	$ra, 0($sp)		#luu dia chi thanh ghi vao stack 
	jal	gcm
	nop
	mul	$t0, $s0, $s1		# lcm=M*N/gcd
	div	$a0, $t0, $a0
	lw	$ra, 0($sp)		#lay lai gia tri cua thanh ghi ra ve main
	add	$sp, $sp, 4
	jr 	$ra
gcm:
	add	$a0, $s0, $zero		
	add	$a1, $s1, $zero		
	slt	$t0, $a1, $a0		# GCD?
	beq	$t0, 1, divide		# dung thi nhay toi divide
	nop
	add	$t1, $a0, $zero		#sai thi doi cho $a0 voi $a1
	add	$a0, $a1, $zero
	add	$a1, $t1, $zero
divide:
	beq	$a1, $zero, done_gcd	#neu $a1=0 thi den done_gcd
	nop
	div	$a0, $a1		#neu khong thi t0= a0 mod a1
	mfhi	$t0
	add	$a0, $a1, $zero		
	add	$a1, $t0, $zero
	j 	divide
	nop
done_gcd:
	jr	$ra
