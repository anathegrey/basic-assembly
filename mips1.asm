#Given the position, returns the stored value - Fibonacci 

	.data
msg1:	.asciiz "fib("
msg2: 	.asciiz ") = "
msg3: 	.asciiz "\n"

	.text
_main:
	li	$v0, 5
	syscall	
	move	$a1, $v0
	li	$v0, 4
	la	$a0, msg1
	syscall
	li	$v0, 1
	move	$a0, $a1
	syscall
	jal	_fib
	move	$t0, $v0
	li	$v0, 4
	la	$a0, msg2
	syscall
	li	$v0, 1
	move	$a0, $t0
	syscall
	li	$v0, 4
	la	$a0, msg3
	syscall
	li	$v0, 10
	syscall
	
_fib:
	addi	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$s0, 4($sp)
	sw	$t1, 0($sp)
	blt	$a1, 2, _else
	move	$s0, $a1
	addi	$a1, $s0, -1
	jal	_fib
	move	$t1, $v0
	addi	$a1, $s0, -2
	jal	_fib
	add	$v0, $t1, $v0

_exit:
	lw	$t1, 0($sp)
	lw	$s0, 4($sp)
	lw	$ra, 8($sp)
	addi	$sp, $sp, 12
	jr	$ra

_else:
	move	$v0, $a1
	j	_exit 