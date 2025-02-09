jmp short main
nop

OEMname:				        db "MATEUSOS"
byterPerSector:			    dw 512
sectPerCluster:			    db 1
reservedSectors:		    dw 1
numFATs:				        db 2
numRootDirEntries:	    dw 224
numSectors:				      dw 2880
mediaType:				      db 0xf0
numFatSectors:			    dw 9
sectorsPerTrack:		    dw 18
numHeads:				        dw 2	
numHidenSector:			    dd 0
numSectorsHuge:			    dd 0
driveNum:				        db 0
reserved:				        db 0
extendedBootSignature:  db 0x29 
volumeID:				        dd 0xa1b2c3d4
volumeLabel:			      db "MATEUSOS   " ;espaço de 11 chars"
fileSysType:			      db "FAT12   "    ;espaço de 8"

;--------------------------------------------------------------------------------------------


nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

;--------------------------------------------------------------------------------------------

main:

mov [driveNum], dl

mov ax, 0x7c00
mov ds, ax

mov ax, 0x7c0
mov es, ax

sub ax, 0x200
mov sp, ax
mov bp, ax



;--------------------------------------------------------------------------------------------

;Gerar o modo de vídeo
xor ax, ax
mov al, 0x13
int 0x10
;Finalizado

;Chamar Fundo Branco 

call DesenhaFundoBranco

;Escrever a frase

call BotaFrase

;Chama Parte 2

call ChamaParte2

;Desenha

;call desenha

;Acabou
jmp $

;--------------------------------------------------------------------------------------------

DesenhaFundoBranco:
push bp
mov bp, sp
pusha

xor cx, cx ; posição horizontal - >
mov dx, 0x1e ; posição vertical ->
mov ah, 0x0c
mov al, 0x0f
recomeca:
int 0x10
inc cx
cmp cx, 0x140 ; 320 em decimal
je zeraHorizontal
jmp recomeca

fim:
popa
mov sp, bp
pop bp
ret

;--------------------------------------------------------------------------------------------

zeraHorizontal:
xor cx, cx
inc dx
cmp dx, 0xc8 ; 200 em decimal 
je fim
jmp recomeca 

;--------------------------------------------------------------------------------------------

BotaFrase:
push bp
mov bp, sp
pusha

mov ah, 0x13
mov al, 0x01
xor bx, bx
mov bl, 0x0f
mov cx, 0x0f
mov dh, 0x1c
mov dl, 0x04
mov bp, mensagem
;add bp, 0x7c00
int 0x10

popa
mov sp, bp
pop bp
ret

;--------------------------------------------------------------------------------------------


ChamaParte2:
mov ah, 2
mov al, 3 ; Número de setores para ler
mov ch, 0 ; Número do Cilindro
mov cl, 2  
mov dh, 0 ; Númemro da "Cabeça"
mov dl, [driveNum]
mov bx, stage2
int 0x13
jmp stage2

;--------------------------------------------------------------------------------------------

drvnum: db 0

;Variáveis
mensagem:db 'Me contrata! =D'

;finalizando
times (510 - ($ -$$)) db 0x00
dw 0xAA55



;--------------------------------------------------------------------------------------------

stage2:
call desenha

final:
jmp $


;Desenha

desenha:
push bp
mov bp, sp
pusha

xor ax, ax
mov ds, ax
mov si, ax

push 0x0f ; Cor do pixel - [sp + 0x06]
push 0x00 ; X - Horixontal [sp + 0x04]
push 0xc7 ; Y vertical [sp + 0x02]
push 0x00 ; número de Repetições - [sp]

mov di, sp
mov bl, byte [0x7c00 + dados + si] ; Repetições

inicio:
mov dx, [di + 0x02] ; Vertical - Y

volta1:
xor bh, bh
mov cx, [di + 0x04] ; X - Horixontal [sp + 0x04]
mov al, [di + 0x06]
mov ah, 0x0c
int 0x10
dec bl ; Diminui uma repetição
mov [di], bl ; Salva as Repetições que faltam

cmp bl, 0
je trocaCor
volta2:
xor ax, ax
mov ax, word[di + 0x04] ; X - Horixontal [sp + 0x04]
inc ax
cmp ax, 0x13f ; 319
je preparaRetorno
mov [di + 0x04], ax 
jmp volta1


preparaRetorno:
xor ax, ax
mov [di + 0x04], ax ; X - Horixontal [sp + 0x04]
mov ax, [di + 0x02] ; ; Y - Horixontal [sp + 0x02]
dec ax 
mov [di + 0x02], ax
inc si
mov bl, byte [0x7c00 + dados + si] ; Repetições
cmp bl, 0xff
je final
jmp inicio


trocaCor:
mov al, [di + 0x06]
cmp al, 0x0f
je preto
mov al, 0x0f 
jmp salva

preto:
mov al, 0x00


salva:
mov [di + 0x06], al
inc si

mov bl, byte [0x7c00 + dados + si] ; Repetições
cmp bl, 0xff
je final
mov [di], bl
jmp volta2



popa 
mov sp, bp
pop bp
ret


dados: db 28,2,56,161,58,2,13,29,2,55,161,57,2,14,30,2,53,162,39,3,13,3,15,31,1,53,162,5,1,27,5,2,1,12,3,17,32,1,51,158,1,3,6,2,26,6,12,4,18,33,1,50,155,2,1,1,2,3,1,2,3,25,7,8,7,19,83,155,3,1,1,2,3,1,1,4,25,3,2,2,7,6,21,82,156,3,5,3,5,31,1,5,7,22,81,158,2,5,5,2,24,1,8,1,4,5,24,79,160,3,4,6,1,22,1,11,1,5,1,26,78,161,3,4,45,2,27,77,163,3,2,44,3,28,76,165,2,3,40,5,29,74,167,3,2,41,3,30,73,169,2,3,40,1,32,72,171,2,3,36,2,34,71,172,3,1,37,1,35,70,174,76,68,177,75,67,179,31,4,39,66,180,30,4,40,65,183,28,2,42,64,184,72,63,186,25,1,45,61,189,23,1,46,60,192,20,1,47,58,195,17,1,49,58,196,14,2,50,58,197,11,3,51,59,197,10,1,53,60,198,7,1,54,61,199,4,1,55,62,202,56,63,93,10,98,56,64,90,14,94,58,65,87,18,91,59,65,85,21,90,59,66,83,23,88,60,67,82,24,86,61,67,81,26,83,63,68,79,27,82,64,68,79,27,81,65,68,79,2,7,19,80,65,69,88,18,79,66,70,87,18,79,66,71,84,21,77,67,73,80,23,77,67,74,77,25,76,68,75,75,27,74,69,76,73,28,73,70,76,72,29,71,72,77,70,30,71,72,79,68,31,69,73,81,64,33,68,74,82,63,33,68,74,83,62,33,67,75,85,59,35,65,76,86,58,35,63,78,87,57,35,61,80,88,57,1,2,32,58,82,89,60,31,57,83,91,66,23,55,85,92,69,2,1,16,54,86,94,75,12,52,87,95,77,9,51,88,95,79,7,50,89,95,80,6,49,90,96,81,4,49,90,96,82,3,48,91,97,67,1,14,1,47,93,98,57,3,4,4,60,94,99,54,16,56,95,99,52,20,52,97,100,50,21,51,98,101,48,23,49,99,109,39,25,47,100,112,36,25,46,101,115,32,27,43,103,118,29,27,39,107,121,26,28,33,112,124,23,30,28,115,126,20,31,26,117,128,18,33,23,118,130,16,35,20,119,131,13,37,18,121,133,10,39,8,130,134,8,40,7,131,135,6,42,4,133,135,5,43,4,133,134,4,10,4,16,2,1,1,12,3,133,134,4,10,10,4,9,13,3,133,134,3,11,9,28,2,133,134,3,48,3,132,133,3,49,3,132,133,3,15,3,32,2,132,133,3,16,6,2,6,20,2,132,132,4,16,7,1,5,21,3,131,132,3,18,6,2,3,23,2,131,132,3,19,5,3,1,24,2,131,132,3,20,4,28,2,131,132,3,20,2,30,2,131,132,3,18,4,30,2,131,132,2,18,6,4,2,23,2,131,132,2,20,4,3,4,22,2,131,132,3,20,2,5,3,22,2,131,132,3,52,2,131,133,3,51,2,131,134,2,8,8,15,1,19,2,131,144,9,14,1,19,2,131,145,9,12,1,19,3,131,135,2,5,13,10,5,14,6,130,135,13,1,6,9,7,3,2,8,6,130,134,11,6,5,8,5,5,7,2,7,130,131,11,10,4,7,5,8,15,129,131,12,9,4,7,4,15,9,129,131,15,6,5,5,5,5,2,9,8,129,130,19,4,4,5,4,4,7,5,9,129,130,20,3,5,3,5,3,9,3,8,1,1,129,131,28,1,5,4,10,1,11,129,131,34,3,23,129,131,34,2,24,129,131,60,129,132,59,129,132,32,1,4,1,21,129,132,31,6,3,1,18,129,130,1,2,10,3,17,7,6,2,12,130,130,2,1,11,1,18,7,5,2,13,130,130,31,8,21,130,130,25,1,4,9,13,1,7,130,130,24,2,4,9,11,2,4,1,3,130,130,30,9,15,2,4,130,131,4,4,4,3,14,10,5,3,4,4,4,130,131,4,5,6,4,10,17,3,6,4,130,131,4,7,9,6,2,15,4,8,4,130,131,4,10,15,8,8,9,5,130,131,4,16,21,13,5,130,131,4,50,5,130,131,4,50,5,130,131,4,49,6,130,131,5,48,6,130,132,7,44,6,131,132,7,43,7,131,132,9,39,9,131,133,9,36,11,131,133,10,4,5,25,11,132,134,22,20,12,132,134,24,17,13,132,135,25,13,15,132,135,28,4,21,132,135,52,133,136,51,133,136,50,134,136,50,134,136,49,135,137,48,135,137,47,136,138,45,137,138,44,138,139,42,139,139,41,140,140,40,140,142,37,141,144,33,143,146,30,144,148,26,146,150,22,148,153,16,151,157,9,154,255
