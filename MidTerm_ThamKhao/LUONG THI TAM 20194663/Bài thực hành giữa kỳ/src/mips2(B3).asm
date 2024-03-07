.data
arr:	.space	200
str:	.asciiz	"Nhap so phan tu cua mang: "
str1:	.asciiz	"Tong cac phan tu thoa man la: \n"
str2: .asciiz	"Nhap sai. So phan tu cua mang khong duoc la so am. Hay nhap lai!\nNhap so phan tu cua mang: "
.text
	la	$s0, arr
	la	$a0, str
	addi	$v0, $0, 4
	syscall
nhap:addi	$v0, $0, 5
	syscall
	add	$t1, $v0, $0		#n
	bltz $t1, check
	addi	$t0, $0, 0		#i=0
	li $s4, 0				#sum
	j for
check:la	$a0, str2
	addi	$v0, $0, 4
	syscall
	j nhap
for:	slt  $t3, $t0, $t1
	beq $t3, $0, end_for	# i >= n, nhay den end_for
	add $t2, $t0, $t0
	add $t2, $t2, $t2
	add	$s1, $s0, $t2		#arr[i]
	addi	$v0, $0, 5			#doc phan tu vao mang
	syscall
	sw	$v0, 0($s1)		# lay gia tri phan tu vua doc vao
count:
	addi	$t0, $t0, 1		#i++
	j	for	
	nop			#
end_for:
	addi	$t0, $0, 0			#i=0
for1:		
	bge	$t0, $t1, end_for1	#if i >= vi tri cuoi, exit
	add $t2, $t0, $t0
	add $t2, $t2, $t2
	add	$s1, $s0, $t2		#arr[i]
	lw	$v0, 0($s1)		#arr[i]
	addi	$v1, $0, 5
	div	$v0, $v1
	mfhi	$v1				
	bne	$v1, $0, count1	#neu arr[i] chia het cho  5, tiep tuc, neu khong nhay den count1
	addi	$v1, $0, 2
	div	$v0, $v1
	mfhi	$v1				
	beq	$v1, $0, count1	#neu arr[i] chia het cho 2 , continue, neu khong nhay den count1
	add	$s4, $s4, $v0		# sum += arr[i]
count1:
	addi	$t0, $t0, 1		# i++
	j	for1
end_for1:

	la	$a0, str1
	addi	$v0, $0, 4
	syscall
	
	addi $a0, $s4, 0
	addi $v0, $0, 1
	syscall
