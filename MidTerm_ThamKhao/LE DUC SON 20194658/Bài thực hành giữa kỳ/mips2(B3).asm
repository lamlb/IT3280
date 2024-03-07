.data
arr:	.space	400
str:	.asciiz	"Hay nhap so phan tu cua mang: "
str1:	.asciiz	"Tong cac phan tu thoa man la: "
.text
	la	$s0, arr
	la	$a0, str
check:
	addi	$v0, $0, 4
	syscall
	addi	$v0, $0, 5
	syscall			#scan length of array
	ble	$v0, $0, check
	add	$t1, $v0, $v0
	add	$t1, $t1, $t1	#end of array
	addi	$t0, $0, 0		#i=0
for:	#for(int i =0;i < length;i++)
	bge	$t0, $t1, end_for 	#if i >= end exit
	add	$s1, $s0, $t0		#arr[i]
	addi	$v0, $0, 5			#scan integer
	syscall
	sw	$v0, 0($s1)		#arr[i] = scan integer
count:
	addi	$t0, $t0, 4		#i++
	j	for				#
end_for:
	addi	$t0, $0, 0			#i=0
	la	$a0, str1
	addi	$v0, $0, 4
	syscall				#print str1
	addi	$s2, $0, 0			#sum = 0
for1:	#for(int i =0;i < length;i++)
	bge	$t0, $t1, end_for1	#if i >= end exit
	add	$s1, $s0, $t0		#arr[i]
	lw	$v0, 0($s1)		#arr[i]
	addi	$v1, $0, 5
	div	$v0, $v1
	mfhi	$v1				#$v1 = arr[i] % 5
	bne	$v1, $0, count1	#if arr[i] % 5 != 0 continue
	addi	$v1, $0, 2
	div	$v0, $v1
	mfhi	$v1				#$v1 = arr[i] % 10
	beq	$v1, $0, count1	#if arr[i] % 2 == 0 continue
	add	$s2, $s2, $v0		#sum += arr[i]
count1:
	addi	$t0, $t0, 4
	j	for1
end_for1:
	addi	$a0, $s2, 0
	addi	$v0, $0, 1			#print sum
	syscall