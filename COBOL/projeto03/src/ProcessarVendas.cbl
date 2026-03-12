       IDENTIFICATION DIVISION.
           PROGRAM-ID. ProcessamentoVendas.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CSV-VENDAS-DO-DIA ASSIGN TO 
             "../arquivos/vendas-do-dia.csv"
             ORGANIZATION IS LINE SEQUENTIAL.

           SELECT IDX-PRODUTOS ASSIGN TO "../arch/produtos.idx"
             ORGANIZATION IS INDEXED
             ACCESS MODE IS DYNAMIC
             FILE STATUS IS WS-STATUS
             RECORD KEY IS PRODUTO-CODIGO.
       
       DATA DIVISION.
       FILE SECTION.
       FD CSV-VENDAS-DO-DIA.
       01 DETALHAMENTO          PIC X(20).

       FD IDX-PRODUTOS.
       01 DETALHE-PRODUTO.
           05 PRODUTO-CODIGO        PIC 9(05).
           05 PRODUTO-DESCRICAO     PIC X(30).
           05 PRODUTO-PRECO-UNIT    PIC 9(04)V99.
           05 PRODUTO-QTD-ESTOQUE   PIC 9(03).

       WORKING-STORAGE SECTION.
       01 WS-EOF                PIC X(01) VALUE 'N'.
       01 WS-STATUS             PIC X(02) VALUE "00".

       01 WS-PRECO-UNIT         PIC 9(04)V99.
       01 WS-QTD-ESTOQUE        PIC 9(03).

       LINKAGE SECTION.
       01 LS-VENDAS-REALIZADAS  PIC 9(03).
       01 LS-VALOR-ARRECADADO   PIC 9(05)V9(02).
       
       PROCEDURE DIVISION USING LS-VENDAS-REALIZADAS, 
           LS-VALOR-ARRECADADO.
           
      *    A Fazer:
      *    PERCORRER O CSV DE VENDAS
      *    A CADA REPETIÇÃO
      *      - INCREMENTA VENDAS REALIZADAS
      *      - SOMA VALOR ARRECADADO
           
           EXIT PROGRAM.
           