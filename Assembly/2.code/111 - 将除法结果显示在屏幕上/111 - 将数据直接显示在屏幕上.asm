; 111 - ������ֱ����ʾ����Ļ��
; =================================================================
; 
; =================================================================
; ��ϰһ��32λ������
	; ����Ϊ16λ��������Ϊ32λ
	; DX ��Ÿ�16λ��AX ��ŵ�16λ

	; ����Ĵ洢��
	; AX --> �̣�DX --> ����


; ���ڴ��е�����ת��ΪASCII�룺 + 30

; ��AX��= 0 Ҳ������ == 0����ζ�ų���������

; =================================================================

assume cs:codesg, ds:datasg, ss:stacksg

; =================================================================

datasg segment
		dw 7895
datasg ends

; =================================================================

stacksg segment
		db 128 dup (0)
stacksg ends

; =================================================================


codesg segment
start:			mov ax, datasg
			mov ds, ax
			mov di, 0

			mov ax, stacksg
			mov ss, ax
			mov sp, 128
			
			call short_div
			
			mov ax, 4c00h
			int 21h

	; ------------------ ������ֱ����ʾ����Ļ�� ------------------
	; ���룺ds:[di]
	; �������Ļ

	short_div:	push ax
			push bx
			push cx
			push dx	
			push es
			push si

			mov ax, 0B800H
			mov es, ax
			mov si, 160 * 10 + 40 * 2
			
			
			mov ax, ds:[di]
	jmp_div:	mov dx, 0
			mov bx, 10
			div bx
			mov cx, dx
			jcxz return_div
			add cx, 30H
			mov ch, 00001010B	; <--- ע�⣬����Ҫ�����ֵ����Խ������ã������ڴ���ԭ���Ľ������ã����ܵ����޷���ʾ������
			mov es:[si], cx
			;mov word ptr es:[si + 1], 00000100B
			sub si, 2
			jmp jmp_div

	return_div:	pop si
			pop es
			pop dx
			pop cx
			pop bx
			pop ax

			ret

codesg ends
end start

; =================================================================;



