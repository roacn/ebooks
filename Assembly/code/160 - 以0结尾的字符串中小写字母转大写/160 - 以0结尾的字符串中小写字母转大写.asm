; 160 - ��0��β���ַ�����Сд��ĸת��д
; =================================================================

; ��дһ���ӳ��򣬽����������ַ�����0��β���ַ����е�Сд��ĸת��Ϊ��д��ĸ

; ���ƣ�letterc
; ���ܣ�����0��β���ַ����е�Сд��ĸת��Ϊ��д��ĸ
; ������ds:si ָ���ַ����׵�ַ
; 
; =================================================================
assume cs:code, ss:stack, ds:data
; =================================================================
data segment
		db	"Beginner's All-purpose Symbolic Instruction Code.", 0
data ends
; =================================================================
stack segment stack
		db	128 dup (0)
stack ends
; =================================================================
code segment
start:		mov ax, stack
		mov ss, ax
		mov sp, 128

		mov ax, data
		mov ds, ax
		mov si, 0

		call letterc

		mov ax, 4c00h
		int 21h


	; ----------------------------------------
	; ���ƣ�letterc
	; ���ܣ�����0��β���ַ����е�Сд��ĸת��Ϊ��д��ĸ
	; ������ds:si ָ���ַ����׵�ַ
	letterc:push cx
		push ds
		push si
		
		mov cx, 0

		_letterc:	mov cl, ds:[si]		; Сд��ĸASCII��Χ��[61H, 7A]
				jcxz _retLetterRc
				cmp cl, 61H
				jb _nextLetter
				cmp cl, 7AH
				ja _nextLetter
				and cl, 11011111B
				mov ds:[si], cl

		_nextLetter:	inc si
				jmp _letterc

		_retLetterRc:	pop si
				pop ds
				pop cx
				ret	
code ends

end start
