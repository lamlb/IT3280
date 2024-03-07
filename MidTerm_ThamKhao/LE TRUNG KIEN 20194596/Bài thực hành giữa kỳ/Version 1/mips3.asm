#2. Nhập mảng số nguyên từ bàn phím. 
#Sắp xếp các phần tử có giá trị dương giảm dần. 
.data
	myArray: .word 0:1000
.text
li $v0, 5 #nhap so nguyen N
syscall

la $t0, myArray #lay dia chi co so cua mang
add $t1, $0, $0 # i= 0
add $t2, $0, $v0 # $t2 = N
for:	beq $t1, $t2, done # neu i = N jumb done
	sll $t3, $t1, 2 # $t3 = i * 4
	add $t3, $t3, $t0 # dia chi cua myArray[i]
	j NhapMang # jumb NhapMang
tiep:   
	sw $t4, 0($t3)
	addi $t1, $t1, 1 # tang i len 1  
	j for #nhay den for
NhapMang:
	li $v0, 5 #nhap so nguyen N
	syscall
	move $t4, $v0
	j tiep

#reset: 
#	add $t1, $0, $0 # i = 0
#	add $t5, $0, $0 # j = 0
#	
#for1:	beq $t1, $t2, done # neu i = N thoat
#	sll $t3, $t1, 2 # $t3 = i * 4
#for2:	beq $t5
#	add $t3, $t3, $t0 # dia chi cua myArray[i]
#	lw $t4, 0($t3)
#	addi $t1, $t1, 1 # tang i len 1  
#	j for1 #nhay den for1
done: