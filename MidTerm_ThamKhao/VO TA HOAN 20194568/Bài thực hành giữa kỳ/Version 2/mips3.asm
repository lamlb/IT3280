.data 
ascii:	.space	256
string: 	.space	20
Message1:    .asciiz "Nhap xau(<20 ki tu): "	#khai bao chuoi ky tu "Nhap xau:" voi nhan Message1 
Message2:    .asciiz "So ki tu khac nhau la: "	#tuong tu 

.text 
main:
get_string: 
	la $a0, Message1
	li $v0, 4
	syscall
         	li $v0,8 
         	la $a0, string 
         	li $a1, 20
         	syscall
get_length:    
    la   	$a0,string      # $a0=address(string[0]) 
    add 	$v1,$zero,$zero # $v1= length =0 
    add	$t0,$zero,$zero # $t0=i=0 
check_char:    
    add  	$t1,$a0,$t0       	# $t1=$a0+$t0 
                            	# =address(string[i]) 
    lb 	$t3, 0($t1)	# t3 = string[i] 
    beq 	$t3, $zero,end_get_length 
    addi 	$v1,$v1,1		# v1 = length++ 
    addi 	$t0,$t0,1		# t0 = i++ 
    j check_char		# jump to check_char 
end_get_length:
    addi	$v1, $v1, -1
    addi	$t1, $0, 0		#i=0
    la	$a0, string
    la	$s5, ascii
for_i:	bge	$t1, $v1, end_for_i	#for(int i=0;i<length;i++)
	add	$t2, $a0, $t1	#t2=&string[i]
	lb	$t3, 0($t2)	#t3 = string[i]
	add	$s2, $s5, $t3	#s2=&asscii[string[i]]
	lb	$s3, 0($s2)	#s3=asscii[string[i]]
	addi	$s3, $s3, 1	#s3++
	sb	$s3, 0($s2)	#luu lai vao mang ascci[string[i]]
	addi	$t1, $t1, 1	#i++
	j	for_i
end_for_i:
    addi	$t1, $0, 0			#i =0
    addi	$k1, $0, 0			#k1= count =0
for_j:	bge  $t1, 256, end_for_j	#for(int i=0;i<256;i++)
	add  $s2, $s5, $t1		#s2= &ascii[i]
	lb  $s2, 0($s2)		#s2= ascii[i]
if:	beqz  $s2, end_if		#if ascii[i]!= 0 
	addi $k1, $k1, 1		#count++
end_if:	
	addi $t1, $t1, 1		#i++	
	j    for_j
end_for_j:
	li 	    $v0, 4 		# print integer
	la 	    $a0, Message2		
	syscall
	
	li 	    $v0, 1 		# print integer
	la 	    $a0, ($k1)		# a0 = A[i]
	syscall
   	 
   	li	$v0 , 10
   	syscall
