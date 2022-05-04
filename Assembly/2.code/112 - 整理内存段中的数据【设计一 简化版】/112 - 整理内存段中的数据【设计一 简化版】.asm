; 112 - �����ڴ���е����ݡ����һ �򻯰桿
; =================================================================
; 
; =================================================================
assume cs:code,ds:data,ss:stack

data segment
		db	'1975','1976','1977','1978','1979','1980','1981','1982','1983'
		db	'1984','1985','1986','1987','1988','1989','1990','1991','1992'
		db	'1993','1994','1995'
		;�����Ǳ�ʾ21���21���ַ��� year


		dd	16,22,382,1356,2390,8000,16000,24486,50065,9749,14047,19751
		dd	34598,59082,80353,11830,18430,27590,37530,46490,59370
		;�����Ǳ�ʾ21�깫˾�������21��dword����	sum

		dw	3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
		dw	1154,1443,1525,1780
data ends

table segment

	        	;0123456789ABCDEF
	db	21 dup ('year summ ne ?? ')
		
table ends

stack segment stack
	db	128 dup (0)
stack ends



code segment

	start:	mov ax,stack
		mov ss,ax
		mov sp,128

		call input_table

		mov ax,4C00H
		int 21H



	; ---------------------------------------------
	; ��֯�ڴ���е�������table��һ��
	; ���룺datasg
	; ��������ݰ��źõ�table��������
	input_table:	push ax
			push bx
			push cx
			push dx
			push si
			push di
			push bp
			
			
			
			mov ax, data
			mov ds, ax
			mov di, 0

			mov ax, table
			mov es, ax
			mov si, 0
			
			mov cx, 21

	_inout_table:	call mul_4	; ��Ϊ ��� �� ���붼������ 4 ���ڴ浥Ԫ�У�����diҪ����4�����������bp��

			mov dx, 0
			mov ax, 16
			mul si
			push si		; ��si - �к��ݴ�
			mov si, ax
			
			
			mov ax, ds:[bp + 0]	; �� ��� �ƶ���table���й̶�λ��
			mov es:[si + 0], ax
			mov ax, ds:[bp + 2]
			mov es:[si + 2], ax

			mov ax, ds:[bp + 84]	; �� ���� �ƶ���table���й̶�λ��
			mov dx, ds:[bp + 86]
			mov es:[si + 5], ax
			mov es:[si + 7], dx

			mov bx, di		; �� ������ƽ������ �ƶ���table���й̶�λ��
			add bx, di
			mov bx, ds:[bx + 168] ; A8 = 168
			mov es:[si + 10], bx	; �ƶ� ���� ��table��
			div bx
			mov es:[si + 13], ax	; �� ���� ��table��

			pop si
			inc di
			inc si
			

			loop _inout_table

			
			pop bp
			pop di
			pop si
			pop dx
			pop cx
			pop bx
			pop ax
			ret

	; -----------------------------------------
	; ��di��ֵ����4���������bp��
	; in: di
	; out: bp = di * 4
	mul_4:		mov bp, di
			add bp, di
			add bp, di
			add bp, di
			ret


	; -----------------------------------------

code ends



end start



