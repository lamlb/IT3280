.data 	
	mess1: .asciiz "Nhap so nguyen duong M:"
	mess2: .asciiz "Nhap so nguyen duong N:"
	mess_error: .asciiz "Nhap so duong "
	mess_m: .asciiz " M!"
	mess_n: .asciiz " N!"
	mess_kq1: .asciiz "Uoc chung lon nhat cua "
	mess_kq2: .asciiz " và "
	mess_kq3: .asciiz " là "

.text
	li 	$v0, 51 		# read integer
	la 	$a0, mess1		
	syscall
	
	slti 	$t0, $a0, 0 		#if (M < 0) -> Thông báo lỗi nhập số âm 
	la 	$a1, mess_m
	bnez 	$t0, thong_bao
	
	addi	$s0, $a0, 0		# s0 = M
	
	li 	$v0, 51 		# read integer
	la 	$a0, mess2		
	syscall
	
	slti 	$t0, $a0, 0 		#if (N < 0) -> Thông báo lỗi nhập số âm 
	la 	$a1, mess_n
	bnez 	$t0, thong_bao
	
	addi 	$s1, $a0, 0		# s1 = N
	
main:
	addi 	$a0, $s0, 0 		# a0 = M
	addi 	$a1, $s1, 0		# a1 = N
	jal 	UCLN

	li 	$v0, 4			# print String
	la 	$a0, mess_kq1
	syscall
	
	li 	$v0, 1			# print integer
	addi 	$a0, $s0, 0		# M
	syscall
	
	li 	$v0, 4			# print String
	la 	$a0, mess_kq2
	syscall
	
	li 	$v0, 1			# print integer
	addi 	$a0, $s1, 0		# N
	syscall
	
	li 	$v0, 4			# print String
	la 	$a0, mess_kq3
	syscall
	
	li 	$v0, 1			# print integer
	addi 	$a0, $v1, 0		# UCLN
	syscall
	
	
end_main:
	li 	$v0, 10
	syscall

# Hàm tìm ước chung lớn nhất 
# Đầu vào là 2 giá trị M, N tương ứng với hai thanh ghi đầu vào là $a0, $a1
# Đầu ra là $v1

UCLN:
check_value_0:
	beqz 	$a0, return
	beqz	$a1, return
	j 	else
return:
	add 	$v1, $a0, $a1 	 	# c = a+b
	jr	$ra
else:	
loop:
	sub	$t0, $a0, $a1		# t0 = a-b
	beqz	$t0, end_loop		# if(a == b) -> end_loop 
	
	slt	$t0, $a1, $a0		# if (b < a)
	beqz	$t0, else_loop
	sub 	$a0, $a0, $a1		# a = a - b
	j	loop
else_loop:
	sub 	$a1, $a1, $a0		# b = b - a
	j 	loop
end_loop:
	addi 	$v1, $a0, 0		# return a
	jr 	$ra
end_UCLN: 
	
	
thong_bao:
	li	$v0, 59			#print string
	la 	$a0, mess_error
	syscall
	li 	$v0, 10
	syscall
end:
