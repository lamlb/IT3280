# cac thanh ghi su dung:
#  $t0:  so luong phan tu n
#  $t1:  chi so mang
#  $a1:  dia chi co so (base address) cua mang[/color]

  .data
input1:  .asciiz  "Nhap n: "
input2:  .asciiz  "[ "
input3:  .asciiz  " ] = "
output:  .asciiz "tich cua 2 so lien ke be nhat la:"
array:  .word  0:100   # int array[100]
  .text
main:
#khoi tao gia tri tich cua 2 so lien ke
li $t7, 1000000  #gia tri tich 2 só lien ke nh? nhat
li $t3, 1000000  #gia tri tich 2 so tam thoi
li $t4, 1  #nhan 2 so lien ke tinh tu so thu 2
li $t5, 0  #check xem da nhap den phan tu thu 2 ch?a
li $s2, 0  #so dung truoc hien tai
li $s3, 0  #so dung sau hien tai

# nhap n
  la  $a0, input1
  addi  $v0, $zero, 4
  syscall

  addi  $v0, $zero, 5
  syscall              
  addi  $t0, $v0, 0       #gan gia tri so luong phan tu vao $t0
  sub $s7, $t0, $t4       # gán thanh ghi s7= t0- t4
  blez $s7, main           #n?u s? luongj ph?n t? nh? h?n 1 thì nh?p l?i s? luongj ph?n t?
# khoi tao
  addi  $t1, $zero, 0
  la  $a1, array

NhapMang: add $s2, $s3, $0
# kiem tra so lan lap
  subu  $t2, $t1, $t0
  bgez  $t2, KetThucNhap

  # xuat dau nhac nhap
  la    $a0, input2
  addi  $v0, $zero, 4
  syscall

  addi  $a0, $t1, 0
  addi  $v0, $zero, 1
  syscall

  la    $a0, input3
  addi  $v0, $zero, 4
  syscall

# nhap so nguyen va luu vao array[i]
  addi  $v0, $zero, 5
  syscall
  sw    $v0, ($a1)
  
  add $s3, $v0, $0 # gan so dung sau vao thanh ghi s3
  sub $t5, $t1, $t4  #kiem tra xem da nhap den phan tu thu 2 ch?a
  blt $t5, $0 continue
  mult $s2, $s3       #khi da nhap den phan tu thu hai thì nhân 2 phan tu lien ke
  mflo $t3      #tich cua 2 so gan nhat
  blt $t7, $t3 continue
  add $t7, $t3, $0  #neu tich hai phan tu lien ke bé nh?t nh? h?n tích 2 ph?n t? li?n k? hi?n t?i thì gán
 

# tang chi so
continue:  addi  $t1, $t1, 1
           addi  $a1, $a1, 4

  j    NhapMang

KetThucNhap:
  la    $a0, output
  addi  $v0, $zero, 4
  syscall
  add $a0,$0,$t7
  add $v0,$0,1
  syscall
  li $v0, 10
  syscall