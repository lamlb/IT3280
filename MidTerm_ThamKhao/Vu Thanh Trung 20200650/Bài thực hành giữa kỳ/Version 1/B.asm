.data
array: .word 0:100
Message: 	.asciiz 	"Input number of array's elements  "
Message_2: 	.asciiz 	"Input: "
space: 		.asciiz 	" "
Out: .asciiz "Cap phan tu lien ke co tich be nhat la: "
.text

# Read input number of array's elements
	li 	$v0, 4
	la 	$a0, Message
	syscall
	
	li 	$v0, 5
	syscall
	move 	$t0, $v0 	# Store value in $t0
	
# Insert array's elements
	
	li 	$t1,0		# Use to count element's index
	la 	$t2, array	# Load array's address into $t2
	
	li 	$v0, 4		
	la 	$a0, Message_2
	syscall
Input:	
 	li 	$v0, 5
 	syscall
 	sw	$v0, 0($t2)	# Save element's value into array
 	
 	addi 	$t1 ,$t1 ,1	# Increment index
 	addi 	$t2 ,$t2 ,4	# Point to array's new address
 	
 	beq 	$t1, $t0, start	# If index is equal to number of elements then we start
 	j 	Input

start:	
	# subi	$t0, $t0, 1
 	la 	$t2 ,array	# Load array's address into $t2
 	
 	lw 	$s1 ,0($t2)	# Load A[i]
 	lw 	$s2 ,4($t2)	# Load A[i+1]
 	mul 	$t3, $s1, $s2	# A[i]*A[i+1}
 	addi 	$t2, $t2, 4	
 	move 	$s4, $s1	# Store value of first 2 integers (1)
 	move 	$s5, $s2	# Store value of first 2 integers (2)
 	li 	$t1, 1		# Increment (Equals to 1 because first one has already been counted)
	beq 	$t1, $t0 ,print	# If array has only 2 elements then return
compare:
# Same idea as start, with added comparison 
 	lw 	$s1 ,0($t2)
 	lw 	$s2 ,4($t2)
 	mul 	$t4 ,$s1 ,$s2
 	addi 	$t2 ,$t2, 4
 	addi 	$t1 ,$t1 ,1
 	
 	slt 	$s3 , $t4 , $t3
 	beq 	$t1 , $t0, print
 	beq 	$s3 , 0, compare	# If A[i]*A[i+1} new is lower than older one than swap values
 	move 	$s4 ,$s1
 	move 	$s5 ,$s2
 	move 	$t3 ,$t4
 	
 	j 	compare
 
print:
#----- Print output -----#
 	la 	$t3 , Out
	li 	$v0, 4
	addi 	$a0, $t3, 0
	syscall
 	
 	li 	$v0, 1
	addi 	$a0, $s4, 0
	syscall
	
	la 	$t3 , space
	
	li 	$v0, 4
	addi 	$a0, $t3, 0
	syscall
	
	li 	$v0, 1
	addi 	$a0, $s5, 0
	syscall
	
	
	li 	$v0, 4
	addi 	$a0, $t3, 0
	syscall
#----- Print output -----#
 	li 	$v0, 10      	# end program
    	syscall
 
		
 	
 
 
 
