
.data
 str1: .asciiz "Nhap vao so nguyen a: "
 str2: .asciiz "Nhap vao so nguyen b: "
 str3: .asciiz "Nhap vao so nguyen c: "
 str4: .asciiz "Day la ba canh mot tam giac "
 str5: .asciiz "Day la khong phai ba canh mot tam giac: "

.text 

#--------------------------------nhap canh a----------------------------------
# In chu?i "Nhap vao so nguyen a: "
li $v0, 4						#$v0 -> 4
la $a0, str1					#$a0 -> address(str1)
syscall
# Nhap gia tri
li $v0, 5						# $v0 -> 5
syscall
move $s1, $v0					# $s1 -> $v0
# kiem tra gia tri > 0
blez $s1, KhongPhaiTamGiac		#s1 < = 0 true nhay den nhan KhongPhaiTamGiac

#--------------------------------nhap canh b----------------------------------
# In chu?i "Nhap vao so nguyen a: "
li $v0, 4						#$v0 -> 4
la $a0, str2					#$a0 -> address(str2)
syscall
# Nhap gia tri
li $v0, 5						#$v0 -> 5
syscall
move $s2, $v0					# $s2 -> $v0
# kiem tra gia tri > 0
blez $s2, KhongPhaiTamGiac		#s2 < = 0 true chuyen den  KhongPhaiTamGiac

#--------------------------------nhap canh c----------------------------------
# In chu?i "Nhap vao so nguyen a: "
li $v0, 4						#$v0 -> 4
la $a0, str3					#$a0 -> address(str3)
syscall
# Nhap gia tri
li $v0, 5						#$v0 -> 5
syscall
move $s3, $v0					# $s3 -> $v0
# kiem tra gia tri > 0
blez $s3, KhongPhaiTamGiac		#s3 < = 0 true nhay den nhan KhongPhaiTamGiac


#xet th a+b>c
add $s0, $s1, $s2				# $s1 + $s2 -> $s0
sgt $t0, $s0, $s3				# so sánh $s0 vs $s3 -> $t0
bne $t0, 1, KhongPhaiTamGiac	# $t0 != 1 true chuy?n ??n KhongPhaiTamGiac

#xet th b+c>a
add $s0, $s2, $s3				# $s2 + $s3 -> $s0
sgt $t0, $s0, $s1				# so sánh $s0 vs $s3 -> $t0
bne $t0, 1, KhongPhaiTamGiac	# $t0 != 1 true chuy?n ??n KhongPhaiTamGiac

#xet th a+c>b
add $s0, $s1, $s3				# $s1 + $s3 -> $s0
sgt $t0, $s0, $s2				# so sánh $s0 vs $s3 -> $t0
bne $t0, 1, KhongPhaiTamGiac	# $t0 != 1 true chuy?n ??n KhongPhaiTamGiac

# ------------------In chu?i "Day la ba canh mot tam giac: "-------------------------
li $v0, 4						#$v0 -> 4
la $a0, str4					#$a0 -> address(str5)
syscall
j fin							#chuy?n ??n label fin

# ------------------In chu?i "Day la khong phai ba canh mot tam giac: "---------------
KhongPhaiTamGiac:
li $v0, 4						#$v0 -> 4
la $a0, str5					#$a0 -> address(str5)
syscall
j fin							#chuy?n ??n label fin

#----------------------ket thuc chuong trinh---------------------
fin:
li $v0, 10						#$v0 -> 10
syscall