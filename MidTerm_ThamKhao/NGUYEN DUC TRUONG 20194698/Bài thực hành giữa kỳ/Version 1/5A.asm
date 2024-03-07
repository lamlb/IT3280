.data
Message: .asciiz "Nhap so nguyen:"
MessageChan:    .asciiz "tong cac chu so chan la:"
MessageLe:      .asciiz "tong cac chu so le la:"  
.text
main:li $v0, 51
     la $a0, Message
     syscall
     add $t1, $a0, 0 #gan gia tri N nhap vao cho t1
     li $t2, 10      #gan thanh ghi t2=10
     li $t3, 2 #gan thanh ghi t3 = 2
     li $t4, 0 # tong chu so chan
     li $t5, 0 #tong chu so le
     li $t6, 1
     blt $t1, $t6, main #neu N nho hon 0 thì nhap lai


chia_10:div $t1, $t2
        mflo $a1  #thuong
        mfhi $a2  #du
        div $a2, $t3
        mfhi $a3
        beq $a3 $zero, chan
        
le:   add $t5, $t5, $a2
      j check
chan: add $t4, $t4, $a2
      j check

check: beq $a1, $zero, done	
       add $t1, $a1, 0
       j chia_10

done:li $v0, 56
     la $a0, MessageChan
     add $a1, $t4, $0 
     syscall
     li $v0, 56
     la $a0, MessageLe
     add $a1, $t5, $0 
     syscall