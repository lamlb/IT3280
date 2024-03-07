.data
str_a: .asciiz "Nhap Gia Tri Canh a: "
str_b: .asciiz "Nhap Gia Tri Canh b: "
str_c: .asciiz "Nhap Gia Tri Canh c: "
yes: .asciiz "Dung, day la ba canh cua tam giac"
no: .asciiz "Sai, Day 0 la ba canh cua tam giac."
err: .asciiz "ERROR: Gia tri canh tam giac >0!!"
.text
main: # Main program code here
	li $v0, 4 #input canh a
	la $a0, str_a
	syscall
	li $v0, 5
	syscall
	add $t0, $zero, $v0
	ble $t0, $zero , edge_err # if a <=0 jump to edge_err
	li $v0, 4 #input canh b
	la $a0, str_b
	syscall
	li $v0, 5
	syscall
	add $t1, $zero, $v0
	ble $t1, $zero , edge_err # if b <=0 jump to edge_err
	li $v0, 4 #input canh c
	la $a0, str_c
	syscall
	li $v0, 5
	syscall
	add $t2, $zero, $v0
	ble $t2, $zero , edge_err # if c <=0 jump to edge_err
	#if a+b <c jump toi no_triagle
	add $a1,$t0,$t1
	blt $a1,$t2,no_triagle
	#if b+c <a jump toi no_triagle
	add $a1,$t1,$t2
	blt $a1,$t0,no_triagle
	#if c+a <b jump to no_triagle
	add $a1,$t2,$t0
	blt $a1,$t1,no_triagle
	j yes_triagle # neu thoa man thi jump toi yes_triagle
no_triagle: #in ra thong bao ko phai 3 canh tam giac
	li $v0,4
	la $a0,no
	syscall
	j end
yes_triagle: #in ra thong bao day la 3 canh cua tam giac
	li $v0,4
	la $a0,yes
	syscall
	j end
edge_err: #in ra thong bao canh phai >0
	li $v0, 4
	la $a0,err
	syscall
	j end
end: #ket thuc chuong trinh
	li $v0,10
	syscall
