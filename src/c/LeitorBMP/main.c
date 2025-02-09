#ifdef _MSC_VER
#define _CRT_SECURE_NO_WARNINGS
#endif // _MSC_VER


#include <stdio.h>
#include <stdlib.h>
#include "bmp.h"

BFHeader bf;
//char **repBMP; // Representa��o do BMP na mem�ria
//Lembrando quem o BMP come�a de baixo para cima, da esquerda para a direita
int main(int argc, char* argv[]) {

	FILE* fp;
	char arg[] = "C:\\Users\\user\\Desktop\\1.bmp";
	int larguratotal = 0;
	int bytesPerRow;
	int y, x;
	int byteAtual = 0;
	int cont = 0;
	int quantBits = 0;
	int quantBitsSeguidos = 0;
	unsigned char temp = 0;
	unsigned char bitAtual = 1; // Meu Run Length Encoding j� come�a considerando o bit de cor definido como branco

	if (argc < 2) {
		fp = fopen(arg, "rb");
	}
	else {
		fp = fopen(argv[1], "rb");
	}

	//fp = fopen(arg, "rb");
	if (!fp) {
		printf("Deu pala ao abrir a imagem!\n");
		return(0);
	}

	fillHeader(&bf, fp);

	/*printf("%c%c\n", bf.signature[0], bf.signature[1]);
	printf("%X\n", bf.imageSize);
	printf("%hX\n", bf.reserved1);
	printf("%hX\n", bf.reserved2);
	printf("%X\n", bf.pixelDataOffset);*/

	if (bf.BIHeader.bitsPerPixel != 1) {
		printf("So funciono com imagens monocromaticas\n");
		fclose(fp);
		return(0);
	}

	//larguratotal = bf.BIHeader.bitsPerPixel * bf.BIHeader.imageWidth;
	//bytesPerRow = ceiling(larguratotal, 32) * 4;
	//repBMP = (unsigned char **)malloc(bf.BIHeader.imageHeigth * sizeof(unsigned char *));
	//fseek(fp, bf.pixelDataOffset, SEEK_SET);

	//for (y = 0; y < bf.BIHeader.imageHeigth; y++) {
	//	repBMP[y] = (unsigned char *)malloc(larguratotal * sizeof(char) + 1);
	//	memset(repBMP[y], '\0', (sizeof(char) * larguratotal + 1));
	//	quantBits = 0;
	//	for (x = 0; x < bytesPerRow; x++) {
	//		fread(&byteAtual, 1, 1, fp);
	//		for (cont = 7; cont >= 0; cont--) {
	//			if (quantBits < larguratotal) {
	//				if (checkBit(&byteAtual, cont) == 1) repBMP[y][quantBits] = '+';
	//				else repBMP[y][quantBits] = '-';
	//			}
	//			quantBits++;
	//			//printf("%d\n", checkBit(&byteAtual, cont));
	//		}
	//	}
	//}

	//for (y = bf.BIHeader.imageHeigth-1; y >=0; y--) {
	//	printf("%s\n", repBMP[y]);
	//}


	larguratotal = bf.BIHeader.bitsPerPixel * bf.BIHeader.imageWidth;
	bytesPerRow = ceiling(larguratotal, 32) * 4;
	//repBMP = (unsigned char **)malloc(bf.BIHeader.imageHeigth * sizeof(unsigned char *));
	fseek(fp, bf.pixelDataOffset, SEEK_SET);

	for (y = 0; y < bf.BIHeader.imageHeigth; y++) {
		//repBMP[y] = (unsigned char *)malloc(larguratotal * sizeof(char) + 1);
		//memset(repBMP[y], '\0', (sizeof(char) * larguratotal + 1));
		quantBits = quantBitsSeguidos = 0;
		for (x = 0; x < bytesPerRow; x++) {
			fread(&byteAtual, 1, 1, fp);
			for (cont = 7; cont >= 0; cont--) {
				if (quantBits < larguratotal) {
					temp = checkBit(&byteAtual, cont);
					if (temp == bitAtual) quantBitsSeguidos++;
					else {
						printf("%d,", quantBitsSeguidos);
						quantBitsSeguidos = 1;
						bitAtual = temp;
					}
					if (quantBitsSeguidos >= 0xff) {
						return(0);
					}
				}
				quantBits++;
				//printf("%d\n", checkBit(&byteAtual, cont));
			}
		}
		printf("%d,", quantBitsSeguidos);
	}

	//for (y = bf.BIHeader.imageHeigth-1; y >=0; y--) {
	//	printf("%s\n", repBMP[y]);
	//}


	/*printf("Largura Total: %d\n", larguratotal);
	printf("Bytes por Linha: %d\n", bytesPerRow);*/


	return(0);
}