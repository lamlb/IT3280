#6.Nhập 3 số nguyên a, b, c, kiểm tra đây có phải là 3 cạnh của một tam giác không
.data
	s1:	.asciiz	"So a: "
	s2:	.asciiz	"\nSo b: "
	s3:	.asciiz	"\nSo c: "
	message1:	.asciiz	"\nLa 3 canh cua mot tam giac"
	message2:	.asciiz	"\nKhong phai la canh cua tam giac"

.text
main:

# --------Khai bao 3 so nguyen---------
type_a:	la	$a0, s1
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$s0, $v0
	blez	$s0, type_a

type_b:	la	$a0, s2
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$s1, $v0
	blez	$s1, type_b

type_c:	la	$a0, s3
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$s2, $v0
	blez	$s2, type_c
#-------------------------------------
check:
	
	add	$t0, $s0, $s1		# t0 = a + b
	ble	$t0, $s2, false		# if a + b <= c return false
	nop
	# OR
	add	$t0, $s1, $s2		# t0 = b + c
	ble	$t0, $s0, false		# if b + c <= a return false
	nop
	# OR
	add	$t0, $s2, $s0		# t0 = a + b
	ble	$t0, $s1, false		# if a + c <= b return false
	nop
	j	end_main
false:
	la	$a0, message2		# neu khong phai la tam giac thi in ra message 2
	li	$v0, 4
	syscall
	j	exit
end_main:
	la	$a0, message1		# neu la tam giac thi in message 1
	li	$v0, 4
	syscall	
exit:

	

