.data 
	input:          .space 200
	nhapchuoi: .asciiz "nhap chuoi:"
	string:    .asciiz "So ki tu nguyen am la: "
	checkNguyenAm:     .asciiz "aeouiAEOUI"
	
.text
	main:   la $a0,nhapchuoi
	        la $a1, input
	        li $a2,201          #gioi han chi duoc nhap 200 ky tu
	        li $v0,54           #do va luu vao $a1
	        syscall 
	        
	        li $t3, 0         #so ki tu nguyen am
	       
	       la $s0, input		#luu chuoi nhap vao s0
	       #lb $t0, 0($s0)
               la $s1, checkNguyenAm    # lu chuoi ki tu can check vao s1
              
               subi $s0, $s0, 1
	       subi $s1, $s1, 1 # tam thoi tru 1 de vong lap co the chi den ky tu dau 
	       
check: addi $s0, $s0, 1
       lb $t0, 0($s0)
       beq $t0, $0, endcheck

	loop:
		addi $s1, $s1, 1
		lb $t1, 0($s1)
		beq $t0, $t1 plus
		j continue
        plus:   add $t3, $t3, 1
                j continue
       continue: beq $t1, $zero, endLoop
		j loop
endLoop: la $s1, checkNguyenAm 
         subi $s1, $s1, 1
         j check
endcheck:

la $a0, string
add $a1, $0, $t3
li $v0, 56
syscall
