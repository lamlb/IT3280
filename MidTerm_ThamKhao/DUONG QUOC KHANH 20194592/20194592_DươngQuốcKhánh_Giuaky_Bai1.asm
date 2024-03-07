.data  
 thongbao1: .asciiz "\nNhap so nguyen N: "
 thongbao2: .asciiz "Ban da nhap sai hay nhap so co nhieu hon 2 chu so tro len hay nhap lai"
 thongbao3: .asciiz "So nho nhat trong N la: "
.text 
	
	nhapso: #nhap so N
	li $v0,4 
	la $a0,thongbao1 # hien ra thong bao nhap so N
	syscall
	li $v0,5   # nhap so N
	syscall
	move $a1,$v0 # gan gia tri vao thanh ghi $a1
	li $a2,10
	check_so: # kiem tra xem so co tu 2 chu so tro len khong
	slt $a3,$a1,$a2 # so sanh N voi 10
	beq $a3,$zero,main # neu N < 10 chay tiep vao thong bao 2, N>=10 nhay den main
	li $v0,4 
	la $a0,thongbao2 # in ra thong bao 2
	syscall
	j nhapso # nhap lai so 
	
	
	main:
	div $a1,$a2 # chia N/10
	mfhi $t4 # Luu so du
	lap:
	div $a1,$a2 # CHia N/10
	mflo $t1 # Luu so chia
	mfhi $t3  # luu so du
	slt $t5,$t4,$t3 # So sanh cac so trong N (so du) neu t4>t3 cap nhat gia tri moi cho t4
	beq $t5,$zero,k  # t4< t3 thi chay tiep , t4>= cap nhat gia tri moi
	add $a1,$zero,$t1 # cap nhat gia tri a1 bang gia tri so chia Lo 
	beq $t1,$zero,end_vonglap # bao gio so chia bang 0 thi dung lai
	j lap
	
	k: # cap nhat gia tri
	add $t4,$zero,$t3 # update gia tri t4
	add $a1,$zero,$t1 # cap nhat gia tri a1
	beq $t1,$zero,end_vonglap
	j lap
	
	end_vonglap:
	li $v0,4 
	la $a0,thongbao3
	syscall
	li $v0,1
	move $a0,$t4
	syscall
	li $v0,10
	syscall
	
	
	
	