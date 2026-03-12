       IDENTIFICATION DIVISION.
           PROGRAM-ID. RealizarVenda.
           AUTHOR. Maurício Rodrigues.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT IDX-PRODUTOS 
             ASSIGN TO "../arch/produtos.idx"
             ORGANIZATION IS INDEXED
             ACCESS MODE IS DYNAMIC
             FILE STATUS IS WS-STATUS-IDX
             RECORD KEY IS PRODUTO-CODIGO.
       
           SELECT CSV-VENDAS 
             ASSIGN TO "../arch/vendas-do-dia.csv"
             ORGANIZATION IS LINE SEQUENTIAL
             FILE STATUS IS WS-STATUS-CSV.

       DATA DIVISION.
       FILE SECTION.
       FD IDX-PRODUTOS.
       01 DETALHE-PRODUTO.
           05 PRODUTO-CODIGO        PIC 9(05).
           05 PRODUTO-DESCRICAO     PIC X(30).
           05 PRODUTO-PRECO-UNIT    PIC 9(04)V99.
           05 PRODUTO-QTD-ESTOQUE   PIC 9(03).
       
       FD CSV-VENDAS.
       01 DETALHAMENTO              PIC X(100).

       WORKING-STORAGE SECTION.
       01 WS-STATUS-IDX             PIC X(02).
       01 WS-STATUS-CSV             PIC X(02).

       01 WS-QTD-VENDA              PIC 9(03).
       01 WS-NOVA-QTD               PIC 9(03).
       01 WS-CODIGO                 PIC 9(05).

       01 WS-NOVA-LINHA             PIC X(100).
       
       LINKAGE SECTION.
       01 LS-STATUS-VENDA           PIC X(02).
       
       PROCEDURE DIVISION USING LS-STATUS-VENDA.
       MAIN.
           DISPLAY "-----------------------------------"
           DISPLAY " REALIZAR VENDA"
           DISPLAY "-----------------------------------"
           
      *    Recebe o item que será vendido
           DISPLAY "Informe o código do item: " WITH NO ADVANCING.
           ACCEPT WS-CODIGO.

      *    Abre o arquivo
           PERFORM ABRE-ARQ-IDX.

      *    Atualiza a chave de busca
           MOVE WS-CODIGO TO PRODUTO-CODIGO.

      *    Busca o produto na tabela
           READ IDX-PRODUTOS KEY IS PRODUTO-CODIGO

      *      Caso produto não encontrado, fecha arquivo e retorna
             INVALID KEY
               DISPLAY "Produto não encontrado!"
               MOVE "ER" TO LS-STATUS-VENDA
               CLOSE IDX-PRODUTOS
               EXIT PROGRAM

      *      Caso encontrado, realiza a venda
             NOT INVALID KEY
               DISPLAY "Informe a quantidade: " WITH NO ADVANCING
               ACCEPT WS-QTD-VENDA
               
      *        Realiza a verificação de quantidade
               IF WS-QTD-VENDA < 1
                 DISPLAY "Quantidade inválida!"
                 MOVE "ER" TO LS-STATUS-VENDA
                 CLOSE IDX-PRODUTOS
                 EXIT PROGRAM
               END-IF

               IF WS-QTD-VENDA > PRODUTO-QTD-ESTOQUE
                 DISPLAY "Estoque insuficiente!"
                 MOVE "ER" TO LS-STATUS-VENDA
                 CLOSE IDX-PRODUTOS
                 EXIT PROGRAM
               END-IF

      *        Subtrai a quantidade na tabela idx
               COMPUTE WS-NOVA-QTD = PRODUTO-QTD-ESTOQUE - WS-QTD-VENDA
               MOVE WS-NOVA-QTD TO PRODUTO-QTD-ESTOQUE
               REWRITE DETALHE-PRODUTO
               MOVE "OK" TO LS-STATUS-VENDA
           
           END-READ.

      *    Fecha o arquivo
           CLOSE IDX-PRODUTOS.
           
      *    Cria a nova linha para o arquivo de vendas
      *    Máscara: <codigo>;<qtd>
           STRING
             WS-CODIGO    DELIMITED BY SIZE
             ";"          DELIMITED BY SIZE
             WS-QTD-VENDA DELIMITED BY SIZE
             INTO WS-NOVA-LINHA
           END-STRING

      *    Adiciona a linha criada ao arquivo
           PERFORM ABRE-ARQ-CSV.
           
           MOVE WS-NOVA-LINHA TO DETALHAMENTO.
           WRITE DETALHAMENTO.

           CLOSE CSV-VENDAS.

      *    Retorna
           EXIT PROGRAM.

       ABRE-ARQ-IDX.
           OPEN I-O IDX-PRODUTOS.
      
      *    Caso o arquivo não exista, cria
           IF WS-STATUS-IDX = "35"
             OPEN OUTPUT IDX-PRODUTOS
             CLOSE IDX-PRODUTOS
             PERFORM ABRE-ARQ-IDX
           END-IF.           

       ABRE-ARQ-CSV.
           OPEN EXTEND CSV-VENDAS.
      
      *    Caso o arquivo não exista, cria
           IF WS-STATUS-CSV = "35"
             OPEN OUTPUT CSV-VENDAS
             CLOSE CSV-VENDAS
             PERFORM ABRE-ARQ-CSV
           END-IF.           
