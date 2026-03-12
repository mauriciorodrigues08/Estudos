       IDENTIFICATION DIVISION.
           PROGRAM-ID. Controle-Estoque-Vendas.
           AUTHOR. Maurício Rodrigues.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-OPCAO                  PIC 9(01) VALUE 9.

      * Variáveis para Linkage Storage (Importação)
       01 WS-QTD-IMPORTACOES        PIC 9(03).
       01 WS-STATUS-IMPORTACAO      PIC X(02).

      * Variáveis para Linkage Storage (Realizar Venda)
       01 WS-STATUS-VENDA           PIC X(02).


       PROCEDURE DIVISION.
       MAIN.
      *    Executa o programa de importação de produtos
           CALL "ImportaCsv" USING WS-QTD-IMPORTACOES, 
             WS-STATUS-IMPORTACAO.

      *    Printa os resultados da importação
           DISPLAY "Status da Importação: " WS-STATUS-IMPORTACAO.
           DISPLAY "Quantidade de produtos importados: "
             WS-QTD-IMPORTACOES.
           DISPLAY "-----------------------------------".
           DISPLAY " "

      *    Loop de execução do programa
           PERFORM UNTIL WS-OPCAO = 0

      *      Menu de opções
             DISPLAY "-----------------------------------"
             DISPLAY " GESTÃO DE ESTOQUE E VENDAS"
             DISPLAY "-----------------------------------"
             DISPLAY "1 - Cadastrar Produto"
             DISPLAY "2 - Alterar Produto"
             DISPLAY "3 - Listar Produtos"
             DISPLAY "4 - Excluir Produto"
             DISPLAY "5 - Realizar Venda"
             DISPLAY "6 - Processar Vendas do Dia"
             DISPLAY "0 - Sair"
             DISPLAY "-----------------------------------"
      
      *      Recebe opção
             DISPLAY "Escolha sua opção: " WITH NO ADVANCING
             ACCEPT WS-OPCAO

      *      Faz o switch da opção
             EVALUATE WS-OPCAO
               WHEN 0
                 DISPLAY "Programa Finalizado!"
                 
               WHEN 1
               WHEN 2
               WHEN 3
               WHEN 4
                 PERFORM CHAMA-CRUD

               WHEN 5
                 PERFORM CHAMA-VENDA
                 
               WHEN 6
                 PERFORM CHAMA-PROCESSA-VENDAS

               WHEN OTHER
                 DISPLAY "Opção inválida!"

             END-EVALUATE
           END-PERFORM.

      *    Finaliza o Programa
           STOP RUN.


       CHAMA-CRUD.
           CALL "CRUD" USING WS-OPCAO.


       CHAMA-VENDA.
           CALL "RealizarVenda" USING WS-STATUS-VENDA.
      
      *    Notifica o status da operação
           IF WS-STATUS-VENDA = "OK"
             DISPLAY "Venda realizada com Sucesso!"
           ELSE
             DISPLAY "Venda Cancelada!"
           END-IF.


       CHAMA-PROCESSA-VENDAS.
           CALL "ProcessarVendas".
