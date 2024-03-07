# 2. Nh?p vào xâu ký t?. In ra màn hình s? ký t? khác nhau có trong xâu.
.data
	tmp: .space 65				# chuoi tmp dung de luu tru cac ky tu khac nhau trong xau nguoi dung nhap vao
	inputString: .space 65		# xau nguoi dung nhap vao duoc luu trong input string
	INPUT_STRING_MESSAGE: .asciiz "Enter a string (under 65 character): "
	RESULT:	  .asciiz "SO KY TU KHAC NHAU TRONG CHUOI: "
.text
main:
#--------------------------------------------------------------------------------------------
# @brief	Nhan vao 1 xau tu nguoi dung
#--------------------------------------------------------------------------------------------
getString:
	li $v0, 54						# hien thi thong bao nhap xau tu nguoi dung
	la $a0, INPUT_STRING_MESSAGE
	la $a1, inputString				# inputString luu tru xau nhap vao
	la $a2, 51
	syscall
	
	li $t1, 0						# do dai hien tai cua chuoi tmp
	li $s2, 0						# dem so ky tu khac nhau
	la $s0, inputString
	la $s1, tmp
	
	li $a0, '\0'
	li $a1, '\n'
loop1:
	la $t5, tmp					# $t5 la con tro index tro den dia chi cua cac ki tu trong chuoi tmp 
	la $t6, tmp($t1)			# $t6 la dia chi sau ki tu cuoi cung cua chuoi tmp
	lb $t2, 0($s0)				# lay ki tu hien tai trong chuoi inputString de xem xet 
	beq $t2, $a1, end_loop1
loop2:
	lb $t3, 0($t5)
	beq $t2, $t3, continue_loop1# xem ki tu dang xet cua chuoi inputString da ton tai trong chuoi tmp hay chua?
	add $t5, $t5, 1				# tang con tro index $t5 len 1
	bgt $t5, $t6, end_loop2		# con tro index da tro den ki tu cuoi cung cua chuoi tmp hay chua?
								# neu chua thi cho vao cuoi cung cua chuoi tmp
	j loop2
end_loop2:
	sb $t2, 0($t6)				# luu ki tu vao cuoi cua chuoi tmp
	add $t1, $t1, 1				# tang do dai cua chuoi tmp len 1
	j loop1
continue_loop1:
	add $s0, $s0, 1
	j loop1
end_loop1:
	add $t6, $s1, $t1
	sb $a0, 0($t6)				# luu ki tu '\0' vao cuoi chuoi tmp


dem_ki_tu_khac_nhau:
	la $t0, tmp					# address(tmp[0])
	la $t2, tmp($t1)			# address(tmp[length])
loop3:
	beq	$t0, $t2, print			# neu $t0 == address(tmp[length]) (tuc la $t0 dan tro den ki tu '\0' trong chuoi tmp
								# thi se in ra so cac ky tu khac nhau)
	add $s2, $s2, 1				# count++
	add $t0, $t0, 1				# tang con tro index len 1
	j loop3
print:
	li	$v0, 4					# in ra
	la $a0, RESULT
	syscall
	
	li	$v0, 1
	add $a0, $s2, 0
	syscall
