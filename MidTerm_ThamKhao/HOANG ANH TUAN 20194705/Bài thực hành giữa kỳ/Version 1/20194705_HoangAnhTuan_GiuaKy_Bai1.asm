# Nhập 3 số nguyên a, b, c, kiểm tra đây 
# có phải là 3 cạnh của một tam giác không.

.data
	warning: .asciiz "Canh cua tam giac phai lon hon 0"

.text

main:
	# Input a
	li	$v0, 5		# read integer
	syscall
	blez	$v0, warn	# if input <= 0 then warning
	nop
	add	$s0, $zero, $v0	# s0 = a
	
	# Input b
	li	$v0, 5		# read integer
	syscall
	blez	$v0, warn	# if input <= 0 then warning
	nop
	add	$s1, $zero, $v0	# s1 = b

	# Input c
	li	$v0, 5		# read integer
	syscall
	blez	$v0, warn	# if input <= 0 then warning
	nop
	add	$s2, $zero, $v0	# s2 = c
	
check_triangle:
	li	$s5, 1			# boolean value for is triangle or not
	
	add	$t0, $s0, $s1		# t0 = a + b
	ble	$t0, $s2, return_false	# if a + b <= c return false
	nop
	# OR
	add	$t0, $s1, $s2		# t0 = b + c
	ble	$t0, $s0, return_false	# if b + c <= a return false
	nop
	# OR
	add	$t0, $s2, $s0		# t0 = a + b
	ble	$t0, $s1, return_false	# if a + c <= b return false
	nop
	j	end_main
return_false:
	li	$s5, 0		# is not triangle
	j	end_main
warn:
	li	$v0, 4
	la	$a0, warning
	syscall
	j	exit
end_main: 
	# In gia tri s5, neu la 1 thi a, b, c la 3 canh cua tam giac
	# va nguoc lai	
	li	$v0, 1
	add	$a0, $zero, $s5
	syscall
exit:

	
