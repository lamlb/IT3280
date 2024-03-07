.data
Message1:		.asciiz	"Nhap so nguyen duong M"
Message2:		.asciiz 	"Nhap so nguyen duong N"
.text

loop1:
	li $v0, 51	#Nhap M tu ban phim
	la $a0, Message1
	syscall		
	
	slt $t0,$0,$a0	#Neu a0 <= 0 thi quay lai vong lap va nhap lai so M
	beq $t0, $0, loop1
	add $s0, $0, $a0	#Luu gia tri cua M vao thanh ghi $s0
	
loop2:
	li $v0, 51	#Nhap N tu ban phim
	la $a0, Message2
	syscall

	slt $t0,$0,$a0	#Neu a0 <= 0 thi quay lai vong lap va nhap lai so N
	beq $t0, $0, loop2
	add $s1, $0, $a0	#Luu gia tri cua N vao thanh ghi $s1
	
	
gcd:
	bgt $s0, $s1, case		#Neu s0 > s1 thi nhay den case
	beq $s0, $s1, print2
	sub $s1, $s1, $s0		# s1 = s1 - s0
	beq $s0, $s1, print2		#Neu s0 = s1 thi nhay den print2, khong thi quay lai gcd
	j gcd

case:	sub $s0, $s0, $s1		#s0 = s0 - s1
	beq $s0, $s1, print2		#Neu s0 = s1 thi nhay den print2, khong thi quay lai gcd
	j gcd

print2:
	add $a0, $zero, $s0
	addi $v0, $zero, 1
	syscall
	
end:
	
	
