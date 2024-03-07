.data
Message_Input : .asciiz  "Nhap vao so nguyen duong N:  "
Message_OutputEven: .asciiz  "Tong cac chu so chan cua N la: S = "
Message_OutputOdd: .asciiz  "Tong cac chu so le cua N la: S = "
.text  
main:
	li $v0, 51  #InputDialogInt
	la $a0, Message_Input
	syscall
	add $t1,$a0,0 #Gan gia tri  N cho t1
	li $t2, 10 #Gan gia tri thanh ghi t2 = 10
	li $t3, 2  #Gan gia tri thanh ghi t3 = 2
	li $t4, 0  #Gan gia tri ban dau cua tong cac chu so chan = 0
	li $t5, 0  #Gan gia tri ban dau cua tong cac chu so le = 0
	li $t6, 1  #Gan gia tri thanh ghi t6 =1
	blt $t1, $t6, main #Neu N<1 thi yeu cau nhap lai N
	
div_10: 
	div $t1, $t2 #Chia so nguyen co dau
	mflo $a1 # Thuong 
	mfhi $a2	 # Phan du 
	div $a2, $t3 #Chia so nguyen co dau
	mfhi $a3 #Phan du
	beq $a3 $zero , even #Neu chia het thi chuyen den doan lenh(nhan) even
odd: 
	add $t5, $t5, $a2 # t5 + = a2  
	j check #Nhay den doan lenh check
even:
	add $t4, $t4, $a2 # t4 + = a2
	j check #Nhay den doan lenh(nhan) check
check:
	beq $a1, $zero , done #Thuong = 0 -> done
	add $t1, $a1, 0   # t1 = a1
	j div_10 #Nhay den doan lenh div_10

done:	
	li $v0, 56 #MessageDialogInt
	la $a0, Message_OutputEven
	add $a1, $t4, $zero
	syscall
	li $v0, 56
	la $a0, Message_OutputOdd
	add $a1, $t5, $zero
	syscall
		
