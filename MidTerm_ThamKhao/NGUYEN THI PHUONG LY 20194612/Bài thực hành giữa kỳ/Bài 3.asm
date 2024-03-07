.data 
	input:    .space 101
	message_output:  .asciiz "So tu duoc bat dau bang 'Ch' la: "
	check_C:  .byte 'C'
	check_h:  .byte 'h'
	
.text
main:
	la $a0,input
	li $a1,101          #Gioi han nhap 100 ky tu
	li $v0,8            #Doc xau va luu vao $a0
	syscall 
	nop
        	
	jal check_Ch
	
	li $v0, 56
       	la $a0, message_output
       	add $a1, $t3, $zero
       	syscall
       	nop
       	
       	li $v0, 10	       
       	syscall
       	nop

check_Ch:
	la $s0, input		#Luu lai vao s0
	#Lay ra 2 ky tu C va h
	la $s2, check_C
	la $s3, check_h		
	lb $t5, 0($s2)
	lb $t2, 0($s3)
	li $t3, 0                 # So tu duoc bat dau bang 'Ch'
	subi $s0, $s0, 1 	  # Tam thoi tru 1 de vong lap co the chi den ky tu dau tien

loop:
		addi $s0, $s0, 1
		lb $t0, 0($s0)
		beq $t0, $zero, endLoop

sosanh_C:
		bne $t0, $t5, skip # Neu ky tu dau tien khac C thi skip

sosanh_h:
		addi $s0, $s0, 1
		lb $t0, 0($s0)
		beq $t0, $zero, endLoop
		bne $t0, $t2, skip # Neu ky tu tiep theo khac h thi skip
		addi $t3, $t3, 1

skip:
		addi $s0, $s0, 1
		lb $t0, 0($s0)
		beq $t0, $zero, endLoop
		bne $t0, 32, skip
		j loop	
endLoop:
endcheck_Ch:
		jr $ra
