.data
string:  .asciiz  
str1: .asciiz "Nhap vao chuoi: "
str2: .asciiz "Chuoi sau khi chuyen: "
.text
.globl main

main:

# in chuoi "Nhap vao chuoi: " ra man hinh
li $v0,4		 # $v0 -> 4
la $a0, str1	# $a0-> address(str1) 
syscall 

# Nhap vao chuoi
li $v0, 8		# $v0 -> 4
la $a0, string		# $a0-> address(str1)
li $a1, 100   # $a1->10
syscall 

    la $t0, string
        move $t1, $0
    add $t2, $0, 0x20 #cac chu hoa chu thuong hon nhau 32
    add $t3, $0, 0x5B #lon hon 5b la chu thuong

loopProc:
        lb $t1, ($t0)
    nop
        beq $t1, $0, doneProc
    nop
        move $t4, $t3
        sub $t5, $t1, $t4
    bge $t5, $0, helperProc #check chu thuong hay chu hoa
        add $t1, $t1, $t2  #chuyen chu hoa thanh chu thuong
    sb $t1, ($t0)
     add $t0, $t0, 0x01

    nop
        j loopProc
helperProc:
nop
    sub $t1, $t1, $t2  #chuyen chu thuong thanh chu hoa
    sb $t1, ($t0)
    add $t0, $t0, 0x01

    nop
        j loopProc

doneProc:
# in chuoi "Nhap vao chuoi: " ra man hinh
li $v0,4		 # $v0 -> 4
la $a0, str2	# $a0-> address(str1) 
syscall

    la $a0, string
    add $t0, $0, $0
    li $v0,4 #in ki tu ra
    syscall
    li $v0,10
    syscall
