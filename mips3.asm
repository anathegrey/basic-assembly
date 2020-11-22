#Greatest common divisor between two given numbers.
	
	.data	
msg1:	.asciiz	"mdc("
msg2: 	.asciiz	","
msg3:	.asciiz	") = "
msg4:	.asciiz	"\n"

	.text
_main:
	li	$v0, 5
	syscall
	move	$a1, $v0
	li	$v0, 5
	syscall
	move	$a2, $v0
	li	$v0, 4
	la	$a0, msg1
	syscall
	li	$v0, 1
	move	$a0, $a1
	syscall
	li	$v0, 4
	la	$a0, msg2
	syscall
	li	$v0, 1
	move	$a0, $a2
	syscall
	li	$v0, 4
	la	$a0, msg3
	syscall
	jal	_gcd
	move	$t0, $v0
	li	$v0, 1
	move	$a0, $t0
	syscall
	li	$v0, 4
	la	$a0, msg4
	syscall
	li	$v0, 10
	syscall
	
_gcd:
	addi	$sp, $sp, -16
	sw	$ra, 12($sp)
	sw	$t1, 8($sp)
	sw	$s1, 4($sp)
	move	$s1, $a1
	sw	$s0, 0($sp)
	move	$s0, $a2
	bne	$s0, $zero, _else
	move	$v0, $s1
	j	_exit
	
_else:
	move	$a1, $s0
	rem	$t1, $s1, $s0
	move	$a2, $t1
	jal	_gcd

_exit:
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$t1, 8($sp)
	lw	$ra, 12($sp)
	addi	$sp, $sp, 16
	jr	$ra