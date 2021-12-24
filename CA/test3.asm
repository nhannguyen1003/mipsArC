
.macro storeArr # -52
	assign($t9,0)
	sh $t9,0($sp)
	assign($t9,2)
	sh $t9,2($sp)
	assign($t9,4)
	sh $t9,4($sp)
	assign($t9,6)
	sh $t9,6($sp)
	assign($t9,8)
	sh $t9,8($sp)
	assign($t9,10)
	sh $t9,10($sp)
	assign($t9,12)
	sh $t9,12($sp)
	assign($t9,14)
	sh $t9,14($sp)
	assign($t9,16)
	sh $t9,16($sp)
	assign($t9,18)
	sh $t9,18($sp)
	assign($t9,20)
	sh $t9,20($sp)
	assign($t9,22)
	sh $t9,22($sp)
	assign($t9,24)
	sh $t9,24($sp)
	assign($t9,26)
	sh $t9,26($sp)
.end_macro
.macro loadArr
	la $t8,arr
	lhu $t9,0($sp)
	sh $t9,0($t8)
	lhu $t9,2($sp)
	sh $t9,2($t8)
	lhu $t9,4($sp)
	sh $t9,4($t8)
	lhu $t9,6($sp)
	sh $t9,6($t8)
	lhu $t9,8($sp)
	sh $t9,8($t8)
	lhu $t9,10($sp)
	sh $t9,10($t8)
	lhu $t9,12($sp)
	sh $t9,12($t8)
	lhu $t9,14($sp)
	sh $t9,14($t8)
	lhu $t9,16($sp)
	sh $t9,16($t8)
	lhu $t9,18($sp)
	sh $t9,18($t8)
	lhu $t9,20($sp)
	sh $t9,20($t8)
	lhu $t9,22($sp)
	sh $t9,22($t8)
	lhu $t9,24($sp)
	sh $t9,24($t8)
	lhu $t9,26($sp)
	sh $t9,26($t8)
.end_macro
.macro assign(%r,%$a3)
	la %r,arr
	lhu %r,%$a3(%r)	
.end_macro
.data
	arr: .half 0,1,2,3,4,5,6,7,8,9,10,11,12,13
.text
	li $s1,10
	
	add $sp,$sp,-4
	sw $s1,0($sp)
	add $sp,$sp,4
	add $sp,$sp,-4
	lw $s2,0($sp)
	add $sp,$sp,4
	
	
	