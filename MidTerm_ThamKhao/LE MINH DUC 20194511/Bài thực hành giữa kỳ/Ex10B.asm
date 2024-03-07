.data
arr:	.space	400
in:	.asciiz	"Nhap vao kich thuoc cua mang: "
error1:	.asciiz	"Mang khong ton tai so le\n"
error2:	.asciiz	"Mang khong ton tai so chan\n"
error3:	.asciiz	"Khong ton tai phan tu thoa man\n"
out:	.asciiz	"Phan tu thoa man la: "
.text
input:
	la		$a0, in
	addi		$v0, $0, 4
	syscall				#Goi hop thoai va nhap vao do dai cua mang
	addi		$v0, $0, 5
	syscall	
	ble		$v0, 0, input	#Kiem tra do dai cua mang
	
	addi		$s1, $0, 0		#max1 = 0 (So le lon nhat)
	addi		$s2, $0, 1		#min2 = 1 (So chan be nhat)
	add		$s0, $0, $v0	#n : length of array	
	la		$s3, arr		#array
	#Nhap cac phan tu cua mang, tim phan tu chan be nhat va gan vao min2,
	# tim ra 1 phan tu le va gan vao max1 
	addi		$t1, $0, 0		#i = 0
for1:	bge		$t1, $s0, end_for1
	add		$t2, $t1, $t1
	add		$t2, $t2, $t2
	add		$t0, $s3, $t2	#val = arr+i
	addi		$v0, $0, 5
	syscall
	
	sw		$v0, 0($t0)	#*val = input
	addi		$v1, $0, 2
	div		$v0, $v1
	mfhi		$v1
if1:	bne		$v1, $0, else1	#neu so du khac 0 thi nhay den else1
	#if(*val % 2 == 0) do
	beq		$s2, 1, set_min_2		#Neu gap so chan dau tien thi gan min2 la so chan do
	bge		$v0, $s2, end_if_else1	#v0 >= s2 thi nhay den end_if_else1 
	#if(min2 == 1 || *val < min2) do set_min_2
set_min_2:
	add		$s2, $0, $v0	#min2 = *val
	j		end_if_else1
else1:	beq	$s1, $0, set_min_1		#them vao
	bge	$v0, $s1, end_if_else1  	#v0 >= s1 thi nhay den end_if_else1
	#if(max1 == 0 || *val < max1) do set_max_1
set_min_1:
	add	$s1, $0, $v0	#max1 = *val
end_if_else1:
	addi		$t1, $t1, 1
	j		for1
end_for1:
	beq		$s1, 0, invalid1	#Neu gia tri cua max1 khong thay doi => khong ton tai so le trong mang
	beq		$s2, 1, invalid2	#Neu gia tri cua min2 khong thay doi => khong ton tai so chan trong mang
	addi		$t1, $0, 0		#i = 0
for2:	bge	$t1, $s0, end_for2
	add		$t2, $t1, $t1
	add		$t2, $t2, $t2
	add		$t0, $s3, $t2	#val = arr+i
	lw		$v0, 0($t0)	#*val = input
	addi		$v1, $0, 2
	div		$v0, $v1
	mfhi		$v1
if2:	beq		$v1, $0, end_if2
	bge		$v0, $s2, end_if2
	bge		$s1, $v0, end_if2
	#if(*val % 2 == 1 && *val < min2 && *val > max1) do
	add		$s1, $0, $v0
end_if2:
	addi		$t1, $t1, 1
	j		for2
end_for2:
	bge		$s1, $s2, invalid3	#Neu max1 >= min2     => khong ton tai phan tu le thoa man dieu kien
	j		success			#In ra phan tu thoa man










invalid1:
	addi		$v0, $0, 4
	la		$a0, error1
	syscall
	j	end
invalid2:
	addi		$v0, $0, 4
	la		$a0, error2
	syscall
	j	end
invalid3:
	addi		$v0, $0, 4
	la		$a0, error3
	syscall
	j	end
success:
	addi		$v0, $0, 4
	la		$a0, out
	syscall
	addi		$v0, $0, 1
	add		$a0, $0, $s1
	syscall
	j	end
end:
	addi		$v0, $0, 10
	syscall
