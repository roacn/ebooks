; 131 - ʹ��adcָ�����40λ�ӷ�
; =================================================================
; adc --> add carry (Cf)
; 
; adc�Ǵ���λ�ӷ�ָ���������CFλ�ϼ�¼�Ľ�λֵ
; 
; ���磺 adc ax, bx -->> (ax)=(ax)+(bx)+CF
; 
; 
; 
; =================================================================
assume cs:code, ds:data, ss:stack
; =================================================================
data segment
		dw	1111H,2222H,3333H,4444H,5555H,6666H,7777H,8888H
		dw	1111H,2222H,3333H,4444H,5555H,6666H,7777H,2H
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
		mov di, 16
		
		call add128

		mov ax, 4c00h
		int 21h


		; -------------------------------------------
		; ���ƣ�add128
		; ���� 128λ�ӷ�
		; ��������Ϊ����128λ��������Ҫ8���ֵ�Ԫ
		;	ds:si ָ��洢��Ԫ�ĵ�һ�������ڴ�ռ�
		;	ds:di ָ�򴢴浥Ԫ�ĵڶ��������ڴ�ռ�
		; 	������ڵ�һ�������ڴ�ռ���
		add128:	push ax
			push cx
			push ds
			push di
			push si
			
			sub ax, ax	; ************ ��CF����Ϊ0 ************ ����������
			
			mov cx, 8

		_add128:	mov ax, ds:[si]
				adc ax, ds:[di]
				mov ds:[si], ax
			
				inc si
				inc si
				inc di
				inc di
				loop _add128
			pop si
			pop di
			pop ds
			pop cx
			pop ax
			ret


	
	
code ends

end start
