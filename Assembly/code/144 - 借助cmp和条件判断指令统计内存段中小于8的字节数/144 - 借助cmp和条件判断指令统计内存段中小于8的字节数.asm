; 144 - ����cmp�������ж�ָ��ͳ���ڴ����С��8���ֽ���
; =================================================================
; cmp ͨ������Ӱ���־�Ĵ�����Ȼ��������Ӧ���ж�ָ������ͨ��������ת
; 
; ����Ϊʲô�˴�����˵������� P225
; 
; je = 
; jne !=
; jb <
; jnb >=
; ja >
; jna <=
; 
; =================================================================
assume cs:code, ss:stack, ds:data
; =================================================================
data segment
		db	8,11,8,1,8,5,63,38
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
		mov bx, 0		; print to first byte in data segment
		mov ax, 0		; Tne counter
		mov cx, 8		; loop 8 times

		s:	cmp byte ptr ds:[bx], 8
			jnb next	; �жϲ�С��Ҫ��ֱ���ж�С�ڵ��ڵĴ��������߼�Ҫ��
			inc ax
		next:	inc bx
			loop s

		mov ax, 4c00h
		int 21h
	
code ends

end start
