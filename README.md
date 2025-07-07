# PDF BootLoader com Imagem Monocromática

Este projeto implementa um PDF BootLoader que roda na VMware e exibe uma imagem monocromática em preto e branco. O código foi projetado para exibir a imagem em uma resolução de 320x200 pixels, utilizando compressão Run-Length Encoding (RLE) para reduzir o tamanho da imagem.

# 🎯 Objetivo

O objetivo deste projeto é demonstrar como arquivos poliglotas funcionam, permitindo que o arquivo PDF contenha tanto a imagem monocromática quanto o código necessário para rodar o BootLoader. Ao executar o PDF na VMware, você verá a imagem comprimida sendo exibida.

# 🖼️ A Imagem

A imagem foi criada a partir de uma foto pessoal, redimensionada para 320x200 pixels e salva no formato monocromático (preto e branco). A imagem foi então comprimida usando Run-Length Encoding (RLE), uma técnica simples e eficiente para compressão de imagens monocromáticas.

# Detalhes da Imagem

- Resolução: 320x200 pixels
- Formato: Monocromático (preto e branco)
- Compressão: Run-Length Encoding (RLE)

# ⚙️ Como Funciona

O BootLoader é carregado a partir de um arquivo PDF, que foi modificado para ser poliglota. Ele contém o código que será executado na VMware e a imagem comprimida.

# Etapas de Execução

Executando o PDF: Ao abrir o PDF na VMware, o código no arquivo é interpretado e executado, exibindo a imagem comprimida na tela.
Decompressão: O código de Run-Length Encoding (RLE) é utilizado para descomprimir a imagem e exibi-la corretamente.
Exibição da Imagem: A imagem monocromática é exibida em uma tela de 320x200 pixels.

# 🛠️ Como Usar
Pré-requisitos:
- VMware: Você precisará de um ambiente VMware para rodar o arquivo PDF.
- Crie um floppy 
