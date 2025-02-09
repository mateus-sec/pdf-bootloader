# Projeto de Manipulação de Imagens BMP

## Visão Geral
Este projeto tem como objetivo ler e manipular arquivos de imagem no formato BMP monocromático (1 bit por pixel). Ele extrai informações do cabeçalho BMP e realiza uma compressão simples utilizando o método Run-Length Encoding (RLE).

## Estrutura do Projeto
O projeto é composto pelos seguintes arquivos:

- **bmp.h**: Define as estruturas de dados para armazenar informações do BMP e declara funções auxiliares.
- **bmp.c**: Implementa funções para manipulação do cabeçalho BMP e verificação de bits.
- **main.c**: Contém a função principal, que realiza a leitura da imagem BMP e aplica compressão.

## Funcionalidades
1. **Leitura do Cabeçalho BMP**:
   - A função `fillHeader` lê os metadados do BMP a partir de um arquivo.
   
2. **Cálculo do Tamanho do Bitmap**:
   - A função `ceiling` é utilizada para calcular o número de bytes necessários para armazenar os pixels corretamente.
   
3. **Verificação de Bits**:
   - A função `checkBit` utiliza instruções em assembly para verificar o valor de um bit específico.
   
4. **Processamento da Imagem**:
   - O programa percorre a imagem, identificando padrões de bits para compressão RLE.
   
5. **Exibição de Informações do BMP**:
   - O programa imprime detalhes do cabeçalho BMP, como dimensões, tamanho do arquivo e deslocamento dos dados.

## Como Executar
1. Compile os arquivos fonte com o Visual Studio:
 
2. Execute o programa informando o caminho do arquivo BMP:
   ```sh
   LEITORBMP.exe caminho/para/imagem.bmp
   ```

Caso nenhum argumento seja passado, o programa tentará abrir um arquivo padrão `C:\Users\user\Desktop\1.bmp`.

## Requisitos
- Visual Studio
- O BMP de entrada deve ser monocromático (1 bit por pixel).


