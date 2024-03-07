.data
message: .asciiz "Nhap vao xau: "
message1: .asciiz "Cac ki tu giong nhau giua hai xau vua nhap la: "
string1: .space 100
string2: .space 100
string3: .space 100
.text
	la $t8, string3 # xau luu cac ki tu khac nhau cung xuat hien trong hai xau moi nhap vao
	li $t9, 0 # vi tri cuoi cua xau3
	li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 8 #nhap vao xau thu nhat
	la $a0, string1
	la $a1, 100
	syscall
	add $s6, $a0, $zero # lay dia chi xau thu nhat str1[0]
	
	li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 8 #nhap vao xau thu hai
	la $a0, string2
	la $a1, 100
	syscall
	
	add $s7, $a0, $zero # lay dia chi xau thu hai
	
	li $t0,0 # bien chay cho vong while 1
	li $s5, 10 #luu ki tu enter
loop: add $s4, $s6, $t0
	 lb  $t1, 0($s4) #load ki tu vao $t1
	 beq $t1, $s5, end_loop # load het xau, thoat vong lap lon, ket thuc chuong trinh
	 nop
	 li $t3,0 #j = 0
loop2: add $s4, $s7, $t3
	  lb $s1, 0($s4) # load ki tu vao $s1
	  beq $s1, $s5, end_loop2 #load het xau, thoat vong lap nho
	  nop
	  beq $t1, $s1, before_check # neu str1[i] = str[j], nhay den check
	  addi $t3, $t3, 1 # j = j+ 1
	  j loop2
end_loop2: addi $t0, $t0, 1 # i = i + 1
		 j loop
		
		
return: 		add $s4, $t8, $t9
	   		sb $t1, 0($s4) #luu ki tu tim duoc vao xau3
	   		addi $t9, $t9, 1
before_loop2:	 addi $t3, $t3, 1 # j = j +1
	  		 j loop2	
	   # kiem tra ki tu tim duoc da ton tai chua 
before_check: li $t5,0 # bien chay t cua xau 3, t= 0
check:	slt $t2, $t5, $t9 # t<n?
		beq $t2, $zero, return
		add $s4, $t8, $t5
		lb $s2, 0($s4) # load ki tu vao $s2
		beq $t1, $s2, before_loop2 # neu ki tu da ton tai, ket thuc kiem tra, quay lai vong lap nho
		addi $t5, $t5, 1 # t += 1
		j check
		#in ket qua ra man hinh
end_loop:	li $v0, 4
		la $a0, message1
		syscall
	
		li $v0, 4
		la $a0, string3
		syscall
		
	 
	 
