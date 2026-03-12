       IDENTIFICATION DIVISION.
           PROGRAM-ID. ProcessarVendas.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CSV-VENDAS-DO-DIA 
             ASSIGN TO "../arch/vendas-do-dia.csv"
             ORGANIZATION IS LINE SEQUENTIAL.

           SELECT IDX-PRODUTOS 
             ASSIGN TO "../arch/produtos.idx"
             ORGANIZATION IS INDEXED
             ACCESS MODE IS DYNAMIC
             FILE STATUS IS WS-STATUS
             RECORD KEY IS PRODUTO-CODIGO.
       
       DATA DIVISION.
       FILE SECTION.
       FD CSV-VENDAS-DO-DIA.
       01 DETALHAMENTO              PIC X(20).

       FD IDX-PRODUTOS.
       01 DETALHE-PRODUTO.
           05 PRODUTO-CODIGO        PIC 9(05).
           05 PRODUTO-DESCRICAO     PIC X(30).
           05 PRODUTO-PRECO-UNIT    PIC 9(04)V99.
           05 PRODUTO-QTD-ESTOQUE   PIC 9(03).

       WORKING-STORAGE SECTION.
      * Variáveis de controle local
       01 WS-EOF                    PIC X(01) VALUE 'N'.
       01 WS-STATUS                 PIC X(02) VALUE "00".
       01 WS-LUCRO                  PIC 9(05)V9(02).
       01 WS-VENDAS-REALIZADAS      PIC 9(03).
       01 WS-VALOR-ARRECADADO       PIC 9(05)V9(02).
       01 WS-VALOR-ARRECADADO-EDIT  PIC ZZZZ9.99.

      * Variáveis de controle do arquivo IDX
       01 WS-PRECO-UNIT             PIC 9(04)V99.
       
      * Variáveis de controle do arquivo IDX
       01 WS-DETALHAMENTO           PIC X(20).
       01 WS-CODIGO                 PIC X(05).
       01 WS-QTD                    PIC 9(03).
       
       PROCEDURE DIVISION.

           DISPLAY "-----------------------------------".
           DISPLAY " REGISTRANDO VENDAS"
           DISPLAY "-----------------------------------".

      *    Zera as variáveis de Linkage Section
           MOVE 0 TO WS-VALOR-ARRECADADO
           MOVE 0 TO WS-VENDAS-REALIZADAS

      *    Abre os arquivos
           OPEN INPUT CSV-VENDAS-DO-DIA.
           OPEN INPUT IDX-PRODUTOS.

      *    Loop de execução
           PERFORM UNTIL WS-EOF = 'S'
               
      *      Processa a prox linha
             READ CSV-VENDAS-DO-DIA INTO WS-DETALHAMENTO
               AT END
                 MOVE 'S' TO WS-EOF

               NOT AT END
      *          Separa a linha lida e atribui para as variáveis
                 UNSTRING WS-DETALHAMENTO
                   DELIMITED BY ';'
                   INTO WS-CODIGO, WS-QTD
                 END-UNSTRING
       
      *          Atualiza a chave de busca
                 MOVE WS-CODIGO TO PRODUTO-CODIGO
       
      *          Busca o produto na tabela
                 READ IDX-PRODUTOS KEY IS PRODUTO-CODIGO
      *            Se a chave for inválida
                   INVALID KEY
                   DISPLAY "Erro! Código " PRODUTO-CODIGO 
                     " não encontrado!"
       
      *            Se a chave não for inválida
                   NOT INVALID KEY
      *              Incrementa as vendas
                     ADD 1 TO WS-VENDAS-REALIZADAS
       
      *              Calcula o valor da última venda
                     COMPUTE WS-LUCRO = PRODUTO-PRECO-UNIT * WS-QTD
       
      *              Adiciona o valor da venda ao lucro total
                     COMPUTE WS-VALOR-ARRECADADO = 
                       WS-VALOR-ARRECADADO + WS-LUCRO 
                       
      *              Informa sucesso na operação
                     DISPLAY "Venda do produto " 
                       PRODUTO-CODIGO " registrada!"
             END-READ
           END-PERFORM.
           
      *    Fecha os arquivos
           CLOSE CSV-VENDAS-DO-DIA.
           CLOSE IDX-PRODUTOS.

      *    Cria o preço editado para print
           MOVE WS-VALOR-ARRECADADO TO WS-VALOR-ARRECADADO-EDIT

      *    Mostra os resultados
           DISPLAY "-----------------------------------".
           DISPLAY " RESULTADO DAS VENDAS"
           DISPLAY "-----------------------------------".
           DISPLAY "Vendas Realizadas: " WS-VENDAS-REALIZADAS.
           DISPLAY "Total Arrecadado: R$" WS-VALOR-ARRECADADO-EDIT.

      *    Retorna
           EXIT PROGRAM.
           