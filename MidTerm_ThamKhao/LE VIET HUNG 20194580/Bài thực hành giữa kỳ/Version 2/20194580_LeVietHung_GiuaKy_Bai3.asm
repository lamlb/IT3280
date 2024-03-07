#int []freq1 = new int[62];
#    int []freq2 = new int[62];
#    Arrays.fill(freq1, 0);
#    Arrays.fill(freq2, 0);
#    for (i = 0; i < n1; i++)
#        freq1[s1.charAt(i) - 'a']++;
#    for (i = 0; i < n2; i++)
#        freq2[s2.charAt(i) - 'a']++;
#    for (i = 0; i < 62; i++)
#       count += (Math.min(freq1[i], freq2[i]));
.data
freq1: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
freq2: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

string1: .space 100
string2: .space 100
Message: .asciiz "Result: "
message1: .asciiz "Input String 1: "
message2: .asciiz "Input String 2: "
message_error1: .asciiz "Error no data input! Please enter data!"
message_error2: .asciiz "Error Cancel! Please enter data!"  
.text
main:
input:
	#read string1:
	li $v0, 54
 	la $a0, message1
 	la $a1, string1
 	la $a2, 100
	syscall
	bnez $a1, error_input 
	#read string2:
	li $v0, 54
 	la $a0, message2
 	la $a1, string2
 	la $a2, 100
	syscall
	bnez $a1, error_input
	nop
	j process
	#================================== 
	#======error 
error_input: 
	li $v0, 55  
	li $a1, 2              # warning message  
	beq $s6, -2, error1  
	nop 
	beq $s6, -3, error2  
	nop 
	error1:  
	la $a0, message_error1  
	syscall  
	j end_error  
	error2:  
	la $a0, message_error2  
	syscall  
	j end_error  
	end_error:    
	j input
	###############
process:
	la $a1, string1 #load adress of string1
	la $a2, string2 #load adress of string2
	la $k0, freq1 #load adress of freq1
	la $k1, freq2 #load adress of freq2
	li $t5,62
	add $s0,$zero,$zero # $s0 = i = 0
L1:
	add $t1,$s0,$a1 # $t1 = $v0 + $a1 = i + string1[0] # = adress	of string1[i]
	lb $t3,0,($t1) # $t3 = value at $t1 = string1[i]
character:
	bge $t3,65,letter
 	nop
 	bge $t3,48,number
 	nop
letter:
	ble $t3,90,Bold
	nop
	bge $t3,97,Normal
	nop
Bold:
	subi $t6,$t3,65
	j  done
Normal:
	subi $t6,$t3,71
	j done
number:
	ble $t3,57,oke
	nop
oke:
	addi $t6,$t3,3
	j done
done:
	add $t6,$t6,$t6
	add $t6,$t6,$t6
	add $t6,$t6,$k0
	#lw $t7,0($t6)
	
	addi $t7,$zero,1
	sb $t7,0($t6)
	beq $t3,$zero,end_of_string1 # if string1[i] == 0, exit
	nop
	addi $s0,$s0,1 #$s0 = $s0 + 1 <-> i = i + 1
	j L1 #next character
	nop
	
end_of_string1:
	add $s0,$zero,$zero # $s0 = i = 0
L2:
	add $t2,$s0,$a2 # $t2 = $v0 + $a2 = i + string2[0] # = adress	of string2[i]
	lb $t3,0,($t2) # $t4 = value at $t2 = string2[i]
character2:
	bge $t3,65,letter2
 	nop
 	bge $t3,48,number2
 	nop
letter2:
	ble $t3,90,Bold2
	nop
	bge $t3,97,Normal2
	nop
Bold2:
	subi $t6,$t3,65
	j  done2
Normal2:
	subi $t6,$t3,71
	j done2
number2:
	ble $t3,57,oke2
	nop
oke2:
	addi $t6,$t3,3
	j done2
done2:
	add $t6,$t6,$t6
	add $t6,$t6,$t6
	add $t6,$t6,$k1
#	lw $t7,0($t6)
	addi $t7,$zero,1
	sb $t7,0($t6)
	beq $t3,$zero,end_of_string2 # if string2[i] == 0, exit
	nop
	addi $s0,$s0,1 #$s0 = $s0 + 1 <-> i = i + 1
	j L2 #next character
	nop
end_of_string2:
	addi $t9,$t9,0
	add $s0,$zero,$zero # $s0 = i = 0
loop:
	beq $s0,$t5,end_loop # if i = n-1 then end_loop
	nop
	add $t3,$s0,$s0 # t3 = 2*s0
	add $t3,$t3,$t3 # t3 = 4*s0
	add $t4,$t3,$k0 # $t3 store the address of freq1[i]
	lbu  $t6,0($t4) # t6 = freq1[i]
	add $t4,$t3,$k1 # $t3 store the address of freq2[i]
	lbu $t7,0($t4) # t7 = freq2[i]
	addi $s0,$s0,1 # i++
	beqz $t6, loop
	nop
	beqz $t7, loop
	nop
	add $t9, $t9, 1
	j loop
	nop
	#bge $t6,$t7,plus1
	#nop
#	bge $t7,$t6,plus2
#	nop

plus1:
	add $t9,$t9,$t7
	j loop
	nop
plus2:
	add $t9,$t9,$t6
	j loop
	nop
end_loop:
output:
li $v0, 56 
la $a0, Message
add $a1,$t9,$zero
syscall
endmain:


	
	
