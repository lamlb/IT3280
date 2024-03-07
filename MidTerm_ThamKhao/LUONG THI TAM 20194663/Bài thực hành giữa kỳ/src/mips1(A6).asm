.data
message: .asciiz "Nhap vao 3 canh cua mot tam giac:\n"
message1: .asciiz "Nhap: "
message2: .asciiz "Ba so vua nhap la ba canh cua mot tam giac!"
message3: .asciiz "Ba so vua nhap khong la ba canh cua mot tam giac!"
message4: .asciiz "Nhap sai.So nhap vao phai la so duong!\n"
.text
	#Nhap vao ba so
nhap:li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 4
	la $a0, message1
	syscall
	
	li $v0, 5  # nhap vao a
	syscall
	addi $t1, $v0, 0   # $t1 = a
	blez $t1, check
	nop
	
	li $v0, 4
	la $a0, message1
	syscall
	
	li $v0, 5 # nhap vao b
	syscall
	addi $t2, $v0, 0	# $t2 = b
	blez $t2, check 
	nop
	
	li $v0, 4
	la $a0, message1
	syscall
	
	li $v0, 5 #nhap vap c
	syscall
	addi $t3, $v0, 0 # $t3 = c
	blez $t3, check  
	nop
	j main
	nop
	# kiem tra dieu kien nhap
check: li $v0, 4
	  la $a0, message4
	  syscall
	  j	nhap # quay lai de nhap
	  #kiem tra dieu kien tam giac
main: add $s0, $t1, $t2 
	 slt $t4, $t3, $s0 # a + b > c ?
	 beq $t4, $zero, return1 # a + b <= c, return1
	 nop
	 
	 add $s0, $t2, $t3
	 slt $t4, $t1, $s0 # b + c > a?
	 beq $t4, $zero, return1 # b+c<=a ,return1
	 nop
	 
	 add $s0, $t1, $t3
	 slt $t4, $t2, $s0# a+c>b?
	 beq $t4, $zero, return1 #a+c<=b, return1
	 nop
	 j return2 
	 
return1: li $v0, 4 
	   la $a0, message3 
	   syscall
	    
	   li $v0, 10
	   syscall
	   
return2: li $v0, 4
	   la $a0, message2
	   syscall
	    
	   li $v0, 10
	   syscall
