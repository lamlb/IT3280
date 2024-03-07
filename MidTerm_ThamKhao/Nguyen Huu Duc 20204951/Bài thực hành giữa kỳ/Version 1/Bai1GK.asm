.data
str1:	.asciiz "Nhap so a: "
str2:	.asciiz "Nhap so b: "
str3:	.asciiz "Nhap so c: "
str4:	.asciiz "Do dai canh khong hop le!"
str5:	.asciiz "a, b, c khong phai 3 canh cua tam giac!"
str6:	.asciiz "a, b, c la 3 canh cua mot tam giac!"

.text
main:
#Nhap a
li	$v0, 51
la	$a0, str1
syscall
move	$s1, $a0
ble	$s1, $zero, invalid

#Nhap b
li	$v0, 51
la	$a0, str2
syscall
move	$s2, $a0
ble	$s2, $zero, invalid

#Nhap c
li	$v0, 51
la	$a0, str3
syscall
move	$s3, $a0
ble	$s3, $zero, invalid

check:
#(a+b)>c
add	$t0, $s1, $s2
ble	$t0, $s3, nottri

#(b+c)>a
add	$t0, $s2, $s3
ble	$t0, $s1, nottri

#(a+c)>b
add	$t0, $s1, $s3
ble	$t0, $s2, nottri

j tri	#Neu khong sai dieu kien thi dung 3 canh tam giac

invalid:	#Neu 1 canh <= 0 thi khong hop le
li	$v0, 55
la	$a0, str4
li	$a1, 2
syscall
j end

nottri:	#Khong phai canh cua tam giac khi sai thuat toan
li	$v0, 55
la	$a0, str5
li	$a1, 2
syscall
j end

tri:
li	$v0, 55
la	$a0, str6
li	$a1, 1
syscall
j end

end: