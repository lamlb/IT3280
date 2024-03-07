.data
Message: 	.asciiz 	"Nhap vao so N:"
Error:		.asciiz		"Loi dau vao!"
Success:	.asciiz		"So co cap so trung! Hehe!"
Fail:		.asciiz		"Khong co cap so trung nhau."
.text	
	li	$v0, 51			
	la	$a0, Message
	syscall
	
	add	$s0, $a0, $zero		# Nhập vào số nguyên s0
	
	slt	$t1, $zero, $s0		# 0 < s0?
	beq	$t1, $zero, error 	# Kiểm tra số nguyên dương
	
	
	li	$a1, 10			# Kiểm tra số nhỏ hơn 10
	div 	$s0, $a1		
	mflo 	$t1 			
	beqz	$t1, error		 
	
	j	loop_1

error:
	li	$v0, 55
	la	$a0, Error
	syscall

	j	end
	
#-----------------So sánh các số với số còn lại---------------	

loop_1:	
	beqz 	$s0,fail
	
	div 	$s0, $a1		# Chia số N cho 10
	mfhi 	$a2 			# a2 = dư
	mflo 	$s0 			# s0 = thương
	
	add	$s1, $s0, $zero		
	j	loop_2
		
loop_2:
	beqz	$s1, loop_1		# s1 = 0 quay lại loop_1
	div	$s1, $a1		# Chia s1 cho 10
	mfhi	$s2			# s2 = dư
	mflo	$s1			# s1 = thương
	beq	$s2, $a2, success	# so sánh s2, a2
	
	j	loop_2			
	
success:
	li	$v0, 55			
	la	$a0, Success
	syscall
	j	end


fail:
	li	$v0, 55
	la	$a0, Fail
	syscall

end: