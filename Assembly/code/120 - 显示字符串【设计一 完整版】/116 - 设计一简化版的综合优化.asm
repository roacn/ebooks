; 116 - ���һ�򻯰���ۺ��Ż�
; =================================================================




; =================================================================
assume cs:code, ds:data, ss:stack
; =================================================================
data segment
		db	'Welcome to msam!', 0
data ends
; =================================================================
stack segment stack
		db	128 dup (0)
stack ends
; =================================================================
code segment
start:		mov ax ,stack
		mov ss, ax
		mov sp, 128

		mov ax, data
		mov ds, ax
		mov si, 0

		mov ax, 0B800H
		mov es, ax
		;mov di, 160 * 3

		mov dl, 5
		mov dh, 3
		mov cl, 11000010B
		call show_str

		mov ax, 4c00h
		int 21h


	
	; -------------------------------------
	; 1. ��ʾ�ַ���
	; ���ƣ�show_str
	; ���ܣ���ָ��λ�ã���ָ����ɫ����ʾһ����0�������ַ���
	; ������(dh)=�кţ�ȡֵ��Χ0~24��,��dl��=�кţ�ȡֵ��Χ0~79��
	; 	(cl)=��ɫ��ds:siָ���ַ����׵�ַ
	; 
	; ���أ���
	;
	; Ӧ�þ���������Ļ��8��3�У�����ɫ��ʾdata���е��ַ���
	;
	show_str: 	push ax
			push bx
			push ds
			push es
			push di
			push si
			push cx
			push dx
			
			mov ah, 0 
			mov al, 160
			mov dh, 0
			mov bx, dx
			mov dx, 0
			mul bx
			pop dx
			mov dh, 0
			add ax, dx	; ע����������飬���ܼ򵥵ؽ��к���ӣ���Ϊ��ʾһ���ַ����������ֽ�
			add ax, dx
			mov bx, ax

			; ȷ�������λ��

		_showStr:	mov cx, 0
				mov cl, ds:[si + 0]
				jcxz _retShowStr
				mov es:[bx + 0], cl
				pop cx
				push cx
				mov byte ptr es:[bx + 1], cl
				inc si
				add bx, 2
				jmp _showStr

		_retShowStr:	pop cx
				pop si
				pop di
				pop es
				pop ds
				pop bx
				pop ax
				ret


	
code ends

end start

