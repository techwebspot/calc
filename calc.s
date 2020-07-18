.section .data

	.equ STDIN, 0
	.equ STDOUT, 1

	.equ SYS_EXIT, 1
	.equ SYS_READ, 3
	.equ SYS_WRITE, 4

	header:
		.ascii "\t\t\t\t\t\tCalculator\n"
	header_end:
		.equ header_len, header_end - header

	list:
		.ascii " 1. Simple Calculation \n 2. Advanced Maths \n 3. About \n 4. Exit \n > "
	list_end:
		.equ list_len, list_end - list
	
	simple_operation_list:
		.ascii " 1. Add \n 2. Sub \n 3. Mul \n 4. Div \n 5. Modulo \n > "
	simple_operation_list_end:
		.equ simple_operation_list_len, simple_operation_list_end - simple_operation_list

	advance_operation_list:
		.ascii " 1. Sin \n 2. Cos \n > "
	advance_operation_list_end:
		.equ advance_operation_list_len, advance_operation_list_end - advance_operation_list

	operation_end_msg:
		.ascii "\n\nPress ENTER to do same operation again or press 'b' to go back to previous list or press 'bb' to go back to main list. Press 'q' to exit from the program \n > "
	operation_end_msg_end:
		.equ operation_end_msg_len, operation_end_msg_end - operation_end_msg

	about_prog:
		.asciz "\t\t\tJust a simple calculator written in 32 bit Assembly AT&T Syntax \n\t\t\t\t\t\t -By Jeet"
	about_prog_end:
		.equ about_prog_len, about_prog_end - about_prog

	user_input:
		.ascii "Enter a number: "
	user_input_end:
		.equ user_input_len, user_input_end - user_input

	input_int:
		.asciz "%f"

	total:
		.asciz "Answer: %.2f \n"

	total_adv:
		.asciz "Answer: %f \n"

	val180:
		.int 180

.section .bss

	.lcomm input, 1
	.lcomm num1, 4
	.lcomm num2, 4

.section .text

.global _start

_start:

	again:

		movl $0x00, input

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $header, %ecx
		movl $header_len, %edx
		int $0x80

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $list, %ecx
		movl $list_len, %edx
		int $0x80

		movl $SYS_READ, %eax
		movl $STDIN, %ebx
		movl $input, %ecx
		movl $10, %edx
		int $0x80

		cmpl $0xa31, input
		je basic_operation

		cmpl $0xa32, input
		je advance_operation		

		cmpl $0xa33, input
		je about

		cmpl $0xa34, input
		je end

		jmp again

	basic_operation:
		
		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $simple_operation_list, %ecx
		movl $simple_operation_list_len, %edx
		int $0x80

		movl $0x00, input

		movl $SYS_READ, %eax
		movl $STDIN, %ebx
		movl $input, %ecx
		movl $10, %edx
		int $0x80

		cmpl $0xa31, input
		je add_operation

		cmpl $0xa32, input
		je sub_operation

		cmpl $0xa33, input
		je mul_operation

		cmpl $0xa34, input
		je div_operation

		cmpl $0xa35, input
		je modulo_operation

		jmp end

	advance_operation:
		
		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $advance_operation_list, %ecx
		movl $advance_operation_list_len, %edx
		int $0x80

		movl $0x00, input

		movl $SYS_READ, %eax
		movl $STDIN, %ebx
		movl $input, %ecx
		movl $10, %edx
		int $0x80

		cmpl $0xa31, input
		je sin_operation

		cmpl $0xa32, input
		je cos_operation

		jmp end

	about:

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $about_prog, %ecx
		movl $about_prog_len, %edx
		int $0x80

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $operation_end_msg, %ecx
		movl $operation_end_msg_len, %edx
		int $0x80

		movl $0x00, input

		movl $SYS_READ, %eax
		movl $STDIN, %ebx
		movl $input, %ecx
		movl $10, %edx
		int $0x80

		cmpl $0xa62, input
		je again

		cmpl $0xa6262, input
		je again

		cmpl $0x0a, input
		je about

		cmpl $0xa71, input
		je end

		jmp about

	add_operation:

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $user_input, %ecx
		movl $user_input_len, %edx
		int $0x80

		pushl $num1
		pushl $input_int
		call scanf
		addl $8, %esp

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $user_input, %ecx
		movl $user_input_len, %edx
		int $0x80

		pushl $num2
		pushl $input_int
		call scanf
		addl $8, %esp

		pushl num2
		pushl num1
		call add
		addl $8, %esp

		subl $4, %esp
		fstpl (%esp)
		pushl $total
		call printf
		addl $8, %esp

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $operation_end_msg, %ecx
		movl $operation_end_msg_len, %edx
		int $0x80

		movl $0x00, input

		movl $SYS_READ, %eax
		movl $STDIN, %ebx
		movl $input, %ecx
		movl $10, %edx
		int $0x80

		cmpl $0xa62, input
		je basic_operation

		cmpl $0xa6262, input
		je again

		cmpl $0x0a, input
		je add_operation

		cmpl $0xa71, input
		je end

		jmp add_operation

	sub_operation:

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $user_input, %ecx
		movl $user_input_len, %edx
		int $0x80

		pushl $num1
		pushl $input_int
		call scanf
		addl $8, %esp

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $user_input, %ecx
		movl $user_input_len, %edx
		int $0x80

		pushl $num2
		pushl $input_int
		call scanf
		addl $8, %esp

		pushl num2
		pushl num1
		call sub
		addl $8, %esp

		subl $4, %esp
		fstpl (%esp)
		pushl $total
		call printf
		addl $8, %esp

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $operation_end_msg, %ecx
		movl $operation_end_msg_len, %edx
		int $0x80

		movl $0x00, input

		movl $SYS_READ, %eax
		movl $STDIN, %ebx
		movl $input, %ecx
		movl $10, %edx
		int $0x80

		cmpl $0xa62, input
		je basic_operation

		cmpl $0xa6262, input
		je again

		cmpl $0x0a, input
		je sub_operation

		cmpl $0xa71, input
		je end

		jmp sub_operation

	mul_operation:

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $user_input, %ecx
		movl $user_input_len, %edx
		int $0x80

		pushl $num1
		pushl $input_int
		call scanf
		addl $8, %esp

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $user_input, %ecx
		movl $user_input_len, %edx
		int $0x80

		pushl $num2
		pushl $input_int
		call scanf
		addl $8, %esp

		pushl num2
		pushl num1
		call mul
		addl $8, %esp

		subl $4, %esp
		fstpl (%esp)
		pushl $total
		call printf
		addl $8, %esp

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $operation_end_msg, %ecx
		movl $operation_end_msg_len, %edx
		int $0x80

		movl $0x00, input

		movl $SYS_READ, %eax
		movl $STDIN, %ebx
		movl $input, %ecx
		movl $10, %edx
		int $0x80

		cmpl $0xa62, input
		je basic_operation

		cmpl $0xa6262, input
		je again

		cmpl $0x0a, input
		je mul_operation

		cmpl $0xa71, input
		je end

		jmp mul_operation

	div_operation:

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $user_input, %ecx
		movl $user_input_len, %edx
		int $0x80

		pushl $num1
		pushl $input_int
		call scanf
		addl $8, %esp

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $user_input, %ecx
		movl $user_input_len, %edx
		int $0x80

		pushl $num2
		pushl $input_int
		call scanf
		addl $8, %esp

		pushl num2
		pushl num1
		call div
		addl $8, %esp

		subl $4, %esp
		fstpl (%esp)
		pushl $total
		call printf
		addl $8, %esp

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $operation_end_msg, %ecx
		movl $operation_end_msg_len, %edx
		int $0x80

		movl $0x00, input

		movl $SYS_READ, %eax
		movl $STDIN, %ebx
		movl $input, %ecx
		movl $10, %edx
		int $0x80

		cmpl $0xa62, input
		je basic_operation

		cmpl $0xa6262, input
		je again

		cmpl $0x0a, input
		je div_operation

		cmpl $0xa71, input
		je end

		jmp div_operation

	modulo_operation:

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $user_input, %ecx
		movl $user_input_len, %edx
		int $0x80

		pushl $num1
		pushl $input_int
		call scanf
		addl $8, %esp

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $user_input, %ecx
		movl $user_input_len, %edx
		int $0x80

		pushl $num2
		pushl $input_int
		call scanf
		addl $8, %esp

		pushl num2
		pushl num1
		call modulo
		addl $8, %esp

		subl $4, %esp
		fstpl (%esp)
		pushl $total
		call printf
		addl $8, %esp

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $operation_end_msg, %ecx
		movl $operation_end_msg_len, %edx
		int $0x80

		movl $0x00, input

		movl $SYS_READ, %eax
		movl $STDIN, %ebx
		movl $input, %ecx
		movl $10, %edx
		int $0x80

		cmpl $0xa62, input
		je basic_operation

		cmpl $0xa6262, input
		je again

		cmpl $0x0a, input
		je modulo_operation

		cmpl $0xa71, input
		je end

		jmp div_operation

	sin_operation:

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $user_input, %ecx
		movl $user_input_len, %edx
		int $0x80

		pushl $num1
		pushl $input_int
		call scanf
		addl $8, %esp

		pushl num1
		call sin
		addl $4, %esp

		subl $4, %esp
		fstpl (%esp)
		pushl $total_adv
		call printf
		addl $8, %esp

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $operation_end_msg, %ecx
		movl $operation_end_msg_len, %edx
		int $0x80

		movl $0x00, input

		movl $SYS_READ, %eax
		movl $STDIN, %ebx
		movl $input, %ecx
		movl $10, %edx
		int $0x80

		cmpl $0xa62, input
		je basic_operation

		cmpl $0xa6262, input
		je again

		cmpl $0x0a, input
		je cos_operation

		cmpl $0xa71, input
		je end

		jmp sin_operation

	cos_operation:

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $user_input, %ecx
		movl $user_input_len, %edx
		int $0x80

		pushl $num1
		pushl $input_int
		call scanf
		addl $8, %esp

		pushl num1
		call cos
		addl $4, %esp

		subl $4, %esp
		fstpl (%esp)
		pushl $total_adv
		call printf
		addl $8, %esp

		movl $SYS_WRITE, %eax
		movl $STDOUT, %ebx
		movl $operation_end_msg, %ecx
		movl $operation_end_msg_len, %edx
		int $0x80

		movl $0x00, input

		movl $SYS_READ, %eax
		movl $STDIN, %ebx
		movl $input, %ecx
		movl $10, %edx
		int $0x80

		cmpl $0xa62, input
		je advance_operation

		cmpl $0xa6262, input
		je again

		cmpl $0x0a, input
		je cos_operation

		cmpl $0xa71, input
		je end

		jmp cos_operation

	end:

		movl $SYS_EXIT, %eax
		movl $0, %ebx
		int $0x80


.type add, @function
add:
	pushl %ebp
	movl %esp, %ebp
	
	finit
	flds 8(%ebp)
	fadd 12(%ebp)

	movl %ebp, %esp
	popl %ebp
	ret

.type sub, @function
sub:
	pushl %ebp
	movl %esp, %ebp
	
	finit
	flds 8(%ebp)
	fsub 12(%ebp)

	movl %ebp, %esp
	popl %ebp
	ret

.type mul, @function
mul:
	pushl %ebp
	movl %esp, %ebp
	
	finit
	flds 8(%ebp)
	fmul 12(%ebp)

	movl %ebp, %esp
	popl %ebp
	ret

.type div, @function
div:
	pushl %ebp
	movl %esp, %ebp
	
	finit
	flds 8(%ebp)
	fdiv 12(%ebp)

	movl %ebp, %esp
	popl %ebp
	ret

.type div, @function
modulo:
	pushl %ebp
	movl %esp, %ebp
	
	finit
	flds 12(%ebp)
	flds 8(%ebp)

	loop:
		fprem1
		fstsw %ax
		testb $4, %ah
		jnz loop

	movl %ebp, %esp
	popl %ebp
	ret

.type sin, @function
sin:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	
	finit
	flds 8(%ebp)
	fidivs val180
	fldpi
	fmul %st(1), %st(0)
	fsts -4(%ebp)
	fsin

	movl %ebp, %esp
	popl %ebp
	ret

.type cos, @function
cos:
	pushl %ebp
	movl %esp, %ebp
	subl $4, %esp
	
	finit
	flds 8(%ebp)
	fidivs val180
	fldpi
	fmul %st(1), %st(0)
	fsts -4(%ebp)
	fcos

	movl %ebp, %esp
	popl %ebp
	ret
