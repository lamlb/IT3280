.data
buffer: 	.space 		100
Message:  	.asciiz 	"Enter string: "
Message_2:  	.asciiz 	"Transformed: "

.text
main:
    	la 	$a0, Message    	# Load and print string asking for string
    	li 	$v0, 4
    	syscall

    	li 	$v0, 8      	 	# take in input
    	la 	$a0, buffer  		# load byte space into address
    	li 	$a1, 100      		# allot the byte space for string
    	syscall
    	move 	$s0, $a0   		# save string to s0

    	li 	$v0, 4

#Loop to capitalize and to lowercase
loop:
    	lb 	$t1, ($a0)    		#Load byte from 't0'th position in buffer into $t1
    	beq 	$t1, 0, exit       	#If ends, exit
    	blt 	$t1, 'a', not_lower  	#If less than a, exit
    	bgt 	$t1, 'z', not_lower 	#If greater than z, exit
	sub 	$t1, $t1, 32  		#If lowercase, then subtract 32
	sb 	$t1, ($a0)   		#Store it back to nth position in buffer
	j	loop_2

#Lowercase letter
not_lower: 
	blt 	$t1, 'A', loop_2  	#If less than A, exit
	bgt 	$t1, 'Z', loop_2 	#If greater than Z, exit
	add 	$t1, $t1, 32  		#If uppercase, then subtract 32
	sb 	$t1, ($a0) 	  	#Store it back to nth position in buffer
    
loop_2:
#if not alphabetical character, then increment $a0 and continue
    	addi	$a0, $a0, 1
    	j 	loop

exit:
    	la 	$a0, Message_2    	# load and print new string
    	li 	$v0, 4
    	syscall

    	move 	$a0, $s0   		# primary address = s0 address (load pointer)
    	li 	$v0, 4       		# print string
    	syscall
    	li 	$v0, 10      		# end program
    	syscall
