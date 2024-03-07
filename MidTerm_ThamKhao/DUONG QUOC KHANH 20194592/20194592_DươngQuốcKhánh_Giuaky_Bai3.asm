.data
inputString: .space 100 # 100 byte chua chuoi ki tu can 
.text
	li $v0, 8
	la $a0, inputString   
	li $a1, 100
	syscall
	
	li $v0,4
	li $t0,0
	li $t7,32
	li $t6,10
loop: 
	lb $t1, inputString($t0)
	beq $t1, 0,exit # neu la xuong dong thi thoat luon 
	beq $t1, $t6,exit # neu la dau cach thi in ra dau cach 
	beq $t1, $t7,kk
	bgt $t1, 'a',toupcase
	blt $t1, 'Z',tolowcase

toupcase:
	sub $t1, $t1, 32
	sb $t1, inputString($t0)
	addi $t0,$t0,1
	j loop 
tolowcase:
	add $t1, $t1, 32
	sb $t1, inputString($t0)
	addi $t0,$t0,1
	j loop
kk: 
sb $t1, inputString($t0)
	addi $t0,$t0,1
	j loop

exit:
	li $v0, 4
    	la $a0, inputString 
    	syscall
    	
    	li $v0, 10		# exit
    	syscall
