# block interruptions
mtc0 $k1,$s2 #中断屏蔽

addi $gp,$zero,0x00000300
addi $fp,$zero,0
add $fp,$gp,$sp

# protect environment
sw $s0,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $s4,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $s5,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $s6,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $a0,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $v0,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $s3,($fp)
addi $sp,$sp,4
addi $fp,$fp,4
sw $t1,($fp)
addi $sp,$sp,4
addi $fp,$fp,4

# store EPC value
mfc0 $t1,$31
sw $t1,($fp)
addi $fp,$fp,4
addi $sp,$sp,4


# set block number
mtc0 $zero,$t7

mfc0 $t6,$t6
sw $t6,($fp)
addi $fp,$fp,4
addi $sp,$sp,4



# calc display number
add $s6,$zero,$t6
addi $s6,$s6,1

# unblock interruptions
mtc0 $k0,$s2 #开中断

# start of program
addi $s4,$zero,5      
addi $s5,$zero,1       
IntLoop:
add $s0,$zero,$s6   
IntLeftShift:       
add    $a0,$0,$s0       #display $s0
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.   
sll $s0, $s0, 4  
bne $s0, $zero, IntLeftShift
sub $s4,$s4,$s5      
bne $s4, $zero, IntLoop
# end of test program

# block interruptions
mtc0 $k1,$s2

addi $fp,$fp,-4
addi $sp,$sp,-4
lw $t1,($fp)
mtc0 $t1,$t6

# restore EPC value
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $t1,($fp)
mtc0 $t1,$31

# restore environment
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $t1,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $s3,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $v0,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $a0,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $s6,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $s5,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $s4,($fp)
addi $fp,$fp,-4
addi $sp,$sp,-4
lw $s0,($fp)



# unblock interruptions
mtc0 $k0,$s2 #开中断

eret










