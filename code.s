.data
  expVal23:    .asciiz  "Expected Value : 23  Your Value : "
  expVal21:    .asciiz  "Expected Value : 21  Your Value : "
  endl:        .asciiz  "\n"

.text

# #
# int getDigit(int number);
# List Used Registers Here:
# sum --> $v0
# 10 --> $t0
# tmp9 --> $t9
# #
getDigit:
  li   $v0, 0             # sum = 0
  li   $t0, 10            # tmp0 = 10
  bge  $a0, $t0, else0    # if (number >= 10), jump to else0
  move $v0, $a0           # sum = number
  j    endGetDigit        # jump to endGetDigit
else0:
  rem  $v0, $a0, $t0      # sum = number % 10
  div  $t9, $a0, $t0      # tmp9 = number / 10
  add  $v0, $v0, $t9      # sum = sum + tmp9
endGetDigit:
  jr   $ra



##
# int sumOfDoubleEvenPlace(int number);
# List Used Registers Here:
# sum --> $s0
# digit --> $s1
# 100 --> $t1
# 10 --> $t2
# number --> $t8
##
sumOfDoubleEvenPlace:
  addi $sp, $sp, -12      # $sp = $sp - 12, move stack pointer
  sw   $s0, ($sp)         # M[$sp] = $s0 (M: memory)
  sw   $s1, 4($sp)        # M[$sp + 4] = $s1
  sw   $ra, 8($sp)        # M[$sp + 8] = $ra
  li   $s0, 0             # sum = 0
  li   $t1, 100           # tmp1 = 100
  li   $t2, 10            # tmp2 = 10
  move $t8, $a0           # tmp8 = number
  div  $t8, $t8, $t2      # tmp8 = tmp8 / 10
  ble  $t8, $0, endSumOfDoubleEvenPlace # if (tmp8 <= 0), skip the loop
loop0:
  rem  $s1, $t8, $t2      # digit = tmp8 % 10
  sll  $a0, $s1, 1        # arg0 = digit * 2
  jal  getDigit           # jump and link getDigit
  add  $s0, $s0, $v0      # sum += getDigit(digit * 2)
  div  $t8, $t8, $t1      # tmp8 = tmp8 / 100
  bgt  $t8, $0, loop0     # if (tmp8 > 0), jump to loop0
endSumOfDoubleEvenPlace:
  move $v0, $s0           # $v0 = sum, as return value
  lw   $ra, 8($sp)        # $ra = M[$sp + 8]
  lw   $s1, 4($sp)        # $s1 = M[$sp + 4]
  lw   $s0, ($sp)         # $s0 = M[$sp]
  addi $sp, $sp, 12       # $sp = $sp + 12, reset stack pointer
  jr   $ra

main:
  li $s0, 89744563  # int test1 = 89744563;
  li $s1, 98756421  # int test2 = 98756421;
  li $s2, 0         # int result1 = 0;
  li $s3, 0         # int result2 = 0;


  # code for first function call

  add $a0, $0, $s0
  jal sumOfDoubleEvenPlace
  add $s2, $0, $v0 

  la   $a0, expVal23     
  addi $v0, $0, 4     
  syscall             

  move $a0, $s2       
  addi $v0, $0, 1     
  syscall             

  la   $a0, endl      
  addi $v0, $0, 4     
  syscall

   # code for second function call

  add $a0, $0, $s1
  jal sumOfDoubleEvenPlace
  add $s3, $0, $v0 

  la   $a0, expVal21     
  addi $v0, $0, 4     
  syscall             

  move $a0, $s3       
  addi $v0, $0, 1     
  syscall             

  la   $a0, endl      
  addi $v0, $0, 4     
  syscall

  li $v0, 10
  syscall
