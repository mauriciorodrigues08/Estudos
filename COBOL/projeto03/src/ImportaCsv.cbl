       IDENTIFICATION DIVISION.
           PROGRAM-ID. ImportaCsv.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CSV-PRODUTOS 
             ASSIGN TO "../arch/produtos.csv"
             ORGANIZATION IS LINE SEQUENTIAL.

           SELECT IDX-PRODUTOS
             ASSIGN TO "../arch/produtos.idx"
             ORGANIZATION IS INDEXED
             ACCESS MODE IS DYNAMIC
             FILE STATUS IS WS-STATUS
             RECORD KEY IS PRODUTO-CODIGO.
       
       DATA DIVISION.
       FILE SECTION.
       FD CSV-PRODUTOS.
       01 DETALHAMENTO          PIC X(200).

       FD IDX-PRODUTOS.
       01 DETALHES-PRODUTO.
           05 PRODUTO-CODIGO        PIC 9(05).
           05 PRODUTO-DESCRICAO     PIC X(30).
           05 PRODUTO-PRECO-UNIT    PIC 9(04)V99.
           05 PRODUTO-QTD-ESTOQUE   PIC 9(03).

       WORKING-STORAGE SECTION.
       01 WS-CODIGO                 PIC 9(05).
       01 WS-DESCRICAO              PIC X(30).
       01 WS-PRECO-UNIT             PIC 9(04)V99.
       01 WS-QTD-ESTOQUE            PIC 9(03).

       01 WS-STATUS                 PIC X(02).
       01 WS-EOF                    PIC X(01) VALUE 'N'.
       
       LINKAGE SECTION.
       01 LS-STATUS-RETORNO         PIC X(02).
       01 LS-QTD-ADICIONADOS        PIC 9(03).
       

       PROCEDURE DIVISION USING LS-QTD-ADICIONADOS, LS-STATUS-RETORNO.
       MAIN.
           DISPLAY "-----------------------------------"
           DISPLAY " IMPORTANDO PRODUTOS JÁ EXISTENTES"
           DISPLAY "-----------------------------------"
           
      *    Zera as variáveis de retorno
           MOVE 0 TO LS-QTD-ADICIONADOS
           MOVE "OK" TO LS-STATUS-RETORNO

      *    Abre os arquivos
           PERFORM ABRE-ARQ-IDX.
           OPEN INPUT CSV-PRODUTOS.

      *    Loop de execução
           PERFORM UNTIL WS-EOF = 'S'
             READ CSV-PRODUTOS
               AT END
                 MOVE 'S' TO WS-EOF
               
               NOT AT END
      *          Retira os epaços em branco do DETALHAMENTO
                 MOVE FUNCTION TRIM(DETALHAMENTO) TO DETALHAMENTO

      *          Desmembra a linha do CSV e adiciona nas variáveis locais
                 UNSTRING DETALHAMENTO DELIMITED BY ";" INTO
                   WS-CODIGO, WS-DESCRICAO, WS-PRECO-UNIT, 
                   WS-QTD-ESTOQUE

      *          Atualiza as variáveis de arquivo
                 MOVE WS-CODIGO TO PRODUTO-CODIGO
                 MOVE WS-DESCRICAO TO PRODUTO-DESCRICAO
                 MOVE WS-PRECO-UNIT TO PRODUTO-PRECO-UNIT
                 MOVE WS-QTD-ESTOQUE TO PRODUTO-QTD-ESTOQUE
       
      *          Salva no arquivo IDX
                 WRITE DETALHES-PRODUTO

      *          Incremena o contador de produtos cadastrados
                 ADD 1 TO LS-QTD-ADICIONADOS

             END-READ
           END-PERFORM.

      *    Fecha os arquivos
           CLOSE IDX-PRODUTOS.
           CLOSE CSV-PRODUTOS.

      *    Retorna
           EXIT PROGRAM.

       ABRE-ARQ-IDX.
           OPEN I-O IDX-PRODUTOS.

      *    Caso o arquivo não exista, cria
           IF WS-STATUS = "35"
             OPEN OUTPUT IDX-PRODUTOS
             CLOSE IDX-PRODUTOS
             PERFORM ABRE-ARQ-IDX
           END-IF.
