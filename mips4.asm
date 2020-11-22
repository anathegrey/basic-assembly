#Searches for given value using binary search

	.data
size:	.word	15
v:	.word	2, 9, 15, 26, 31, 37, 49, 51, 53, 54, 62, 66, 75, 84, 91
err:	.asciiz	" not found\n"
valid1:	.asciiz	" found at index "
valid2:	.asciiz	"\n"

	.text
_main:
	li	$v0, 5
	syscall	
	move	$a1, $v0
	li	$a2, 0
	lw	$t0, size
	addi	$t0, $t0, -1
	move	$a3, $t0
	jal	_bsearch
	move	$s0, $v0
	bne	$s0, -1, _elsemain
	li	$v0, 1
	move	$a0, $a1
	syscall
	li	$v0, 4
	la	$a0, err
	syscall
	j	_exitmain
	
_elsemain:
	li	$v0, 1
	move	$a0, $a1
	syscall
	li	$v0, 4
	la	$a0, valid1
	syscall
	li	$v0, 1
	move	$a0, $s0
	syscall
	li	$v0, 4
	la	$a0, valid2
	syscall
	
_exitmain:
	li	$v0, 10
	syscall
	
_bsearch:
	addi	$sp, $sp, -20
	sw	$ra, 16($sp)
	sw	$t1, 12($sp)
	sw	$s3, 8($sp)
	move	$s3, $a3
	sw	$s2, 4($sp)
	move	$s2, $a2
	sw	$s1, 0($sp)
	move	$s1, $a1
	ble	$s2, $s3, _elsebsearch
	li	$v0, -1
	j 	_exitbsearch
	
_elsebsearch:
	add	$t2, $s2, $s3
	div	$t1, $t2, 2
	la	$t3, v
	sll	$t6, $t1, 2
	add	$t6, $t6, $t3
	lw	$t5, 0($t6)
	ble	$s1, $t5, _elsebsearch2
	addi	$t4, $t1, 1
	move	$a2, $t4
	j	_bsearch

_elsebsearch2:
	bge	$s1, $t5, _elsebsearch3
	addi	$t4, $t1, -1
	move	$a3, $t4
	j	_bsearch

_elsebsearch3:
	move	$v0, $t1

_exitbsearch:
	lw	$s1, 0($sp)
	lw	$s2, 4($sp)
	lw	$s3, 8($sp)
	lw	$t1, 12($sp)
	lw	$ra, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra