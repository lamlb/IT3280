.data
Message1: .asciiz " Nhap xau s1:"
Message2: .asciiz "Nhap xau s2:"
string: .space 100
.text
li $v0 , 54
la $a0 , Message1
la $a1 , string
la $a2 , 100
syscall

li $v0, 54
la $a0, Message2
la $s1, string
la $a2 , 100
syscall