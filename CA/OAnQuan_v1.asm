.macro print_int1 (%x) # lam thay doi v0, a0
	assign($a0,%x)
	bnez $a0,if1
		print_str("  ")
		j if2
	if1: 
	assign($a0,%x)
	li $v0, 1
	syscall
	bgt $a0,9,if2
		print_str(" ")
	if2:
.end_macro

.macro print_int (%x) # lam thay doi v0, a0
	add $a0, $zero, %x
	li $v0, 1
	syscall
.end_macro

.macro print_str (%str) # lam thay doi v0, a0
	.data
	myLabel: .asciiz %str
	.text
	li $v0, 4
	la $a0, myLabel
	syscall
.end_macro
.macro read_int(%r) # lam thay doi v0
	.text
	li $v0, 5
	syscall
	move %r,$v0
.end_macro
.macro assign(%r,%pos)
	la %r,arr
	lhu %r,%pos(%r)	
.end_macro
.macro print_board() # lam thay doi $v0, a0
	print_str "<---R    5     4     3     2     1    L--->\n _________________________________________\n"
	print_str "|     |  " 
	print_int1(22)
	print_str " |  " 
	print_int1(20)
	print_str " |  " 
	print_int1(18)
	print_str " |  " 
	print_int1(16)
	print_str " |  " 
	print_int1(14)
	print_str " |     |   scores 2: " 
	print_int($s2)
	beqz $s3,if1
		print_str "\n|  A  |_____|_____|_____|_____|_____|  "
		j end_if1
	if1:
		print_str "\n|     |_____|_____|_____|_____|_____|  "
	end_if1:
	beqz $s4,if2
		print_str "B  |\n"
		j end_if2
	if2:
		print_str "   |\n"
	end_if2:
	print_str "|  " 
	print_int1(0)
	print_str " |  " 
	print_int1(2)
	print_str " |  " 
	print_int1(4)
	print_str " |  " 
	print_int1(6)
	print_str " |  " 
	print_int1(8)
	print_str " |  " 
	print_int1(10)
	print_str " |     |   scores 1: " 
	print_int($s1)
	print_str "\n|_____|_____|_____|_____|_____|_____|_____|\n<---L    1     2     3     4     5    R--->"
	
.end_macro
.data
	arr: .half 0,1,2,3,4,5,0,0,8,9,10,11,10,10
.text
	li $s1,0 # diem nguoi choi 1
	li $s2,0 # diem nguoi choi 
	
	read_int $a1
