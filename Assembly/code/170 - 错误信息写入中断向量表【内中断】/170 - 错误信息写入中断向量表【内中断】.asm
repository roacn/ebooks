; 170 - ������Ϣд���ж����������жϡ�
; =================================================================

; ����˵������� P240
; 

; ע�⣺��Ϊwin10 ���жϻ��Ʋ�ͬ���������������ܲ�����ȷ����

; =================================================================
assume cs:code, ss:stack, ds:data
; =================================================================
data segment
	;	db	'overflow!'	����д�������Ϊ���������꣬����������ܻḲ�ǵ������������
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

		; do0��װ����
		call local_do0

		; �����ն�������
		call set_IVT

		mov ax, 2233H
		mov bx, 0
		div bx

		mov ax, 4C00H
		int 21H



		; -------------------------------
		; ��װdo0
		local_do0:	push ax
				push cx
				push ds
				push es
				push di
				push si

				mov ax, cs	; <-- ע��������CS
				mov ds, ax 
				mov si, OFFSET do0

				mov ax, 0000H
				mov es, ax
				mov di, 0200H
				mov cx, OFFSET _do0Ret  - OFFSET do0	; ���볤��
				cld
				rep movsb

				pop si
				pop di
				pop es
				pop ds
				pop cx
				pop ax
				ret


		; -------------------------------
		; �����ն�������
		set_IVT:	push ax
				push ds
				
				mov ax, 0
				mov ds, ax
				mov word ptr ds:[0 * 4 + 0], 0200H		; IP �����跴�ˣ�������
				mov word ptr ds:[0 * 4 + 2], 0H			; CS

				pop ds
				pop ax
				ret


		; -------------------------------
		; ����Ļ�м���ʾoverflow��
		; ���룺ds:si ָ���ַ�����һ������
		; 
		do0:		jmp short _do0Start
				db	'overflow!'	; ��ŵ��ж���������
	
			_do0Start:	push ax
					push cx
					push ds
					push es
					push di
					push si

					mov ax, cs
					mov ds, ax
					mov si, 202H	; <-- ��Ϊ'overflow!'�ŵ����������еĿ����ڴ��У�������202H

					mov ax, 0B800H
					mov es, ax
					mov di, 160 * 12 + 36 * 2
				
					mov cx, 9

			_do0:		mov al, ds:[si]
					mov es:[di + 0], al
					mov byte ptr es:[di + 1], 11001111B
					add di, 2
					inc si
					loop _do0

				pop si
				pop di
				pop es
				pop ds
				pop cx
				pop ax
				ret

			_do0Ret:	nop	; <<==== Ҫָ���������һ���ֽڣ�������
		

code ends

end start
