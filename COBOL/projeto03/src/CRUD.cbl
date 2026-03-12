       IDENTIFICATION DIVISION.
           PROGRAM-ID. CRUD.
           AUTHOR. Maurício Rodrigues.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT IDX-PRODUTOS 
             ASSIGN TO "../arch/produtos.idx"
             ORGANIZATION IS INDEXED
             ACCESS MODE IS DYNAMIC
             FILE STATUS IS WS-STATUS
             RECORD KEY IS PRODUTO-CODIGO.
       
       DATA DIVISION.
       FILE SECTION.
       FD IDX-PRODUTOS.
       01 DETALHE-PRODUTO.
           05 PRODUTO-CODIGO        PIC 9(05).
           05 PRODUTO-DESCRICAO     PIC X(30).
           05 PRODUTO-PRECO-UNIT    PIC 9(04)V99.
           05 PRODUTO-QTD-ESTOQUE   PIC 9(03).

       WORKING-STORAGE SECTION.
      * Variáveis de Controle
       01 WS-STATUS                 PIC X(02).
       01 WS-EOF                    PIC X(01) VALUE 'N'.
       01 WS-CONTADOR               PIC 9(03).
       01 WS-VERIFICACAO            PIC X(01).
       01 WS-PRECO-EDITADO          PIC ZZZ9.99.

      * Variáveis Locais de Produto 
       01 WS-CODIGO                 PIC 9(05).
       01 WS-DESCRICAO              PIC X(30).
       01 WS-PRECO-UNIT             PIC 9(04)V99.
       01 WS-QTD-ESTOQUE            PIC 9(03).
       
       LINKAGE SECTION.
       01 LS-OPCAO                  PIC 9(01).

       PROCEDURE DIVISION USING LS-OPCAO.
       MAIN.
      *    Switch da opção
           EVALUATE LS-OPCAO
             WHEN 1
               PERFORM ADICIONAR-PRODUTO
             
             WHEN 2
               PERFORM ALTERAR-PRODUTO
             
             WHEN 3
               PERFORM LISTAR-PRODUTOS
             
             WHEN 4
               PERFORM EXCLUIR-PRODUTO
           END-EVALUATE.

      *    Retorna
           EXIT PROGRAM.


       ADICIONAR-PRODUTO.
           DISPLAY "-----------------------------------".
           DISPLAY " CADASTRAR PRODUTO"
           DISPLAY "-----------------------------------".
      *    Recebe o código
           DISPLAY "Informe o código: " WITH NO ADVANCING
           ACCEPT WS-CODIGO.

      *    Recebe a descrição
           DISPLAY "Informe a descrição: " WITH NO ADVANCING
           ACCEPT WS-DESCRICAO
           
      *    Recebe o preço unitário
           DISPLAY "Informe o preço unitário: R$" WITH NO ADVANCING
           ACCEPT WS-PRECO-UNIT.
           
      *    Recebe a quantidade em estoque
           DISPLAY "Informe a quantidade em estoque: " WITH NO ADVANCING
           ACCEPT WS-QTD-ESTOQUE.

      *    Abre o arquivo
           PERFORM ABRE-ARQ-IDX.

      *    Move os valores para as variáveis de arquivo
           MOVE WS-CODIGO TO PRODUTO-CODIGO.
           MOVE WS-DESCRICAO TO PRODUTO-DESCRICAO.
           MOVE WS-PRECO-UNIT TO PRODUTO-PRECO-UNIT.
           MOVE WS-QTD-ESTOQUE TO PRODUTO-QTD-ESTOQUE.

           WRITE DETALHE-PRODUTO
             INVALID KEY
               DISPLAY "Erro ao cadastrar produto!"
             NOT INVALID KEY
               DISPLAY "Sucesso! Produto cadastrado!"
           END-WRITE.
           
      *    Fecha o arquivo
           CLOSE IDX-PRODUTOS.

      *    Retorna
           EXIT PARAGRAPH.

       
       ALTERAR-PRODUTO.
           DISPLAY "-----------------------------------".
           DISPLAY " ALTERAR PRODUTO"
           DISPLAY "-----------------------------------".
      *    Recebe o código do produto que será alterado
           DISPLAY "Informe o código do produto: " WITH NO ADVANCING.
           ACCEPT WS-CODIGO.

      *    Abre o arquivo
           PERFORM ABRE-ARQ-IDX.

      *    Atualiza a chave de busca (PRODUTO-CODIGO)
           MOVE WS-CODIGO TO PRODUTO-CODIGO.

      *    Busca pelo produto informado
           READ IDX-PRODUTOS KEY IS PRODUTO-CODIGO
      *      Caso o produto não for encontrado
             INVALID KEY
               DISPLAY "Erro! Produto não está cadastrado!"

      *      Caso o produto for encontrado
             NOT INVALID KEY
      *        Realiza a verificação
               DISPLAY "Atualizando produto " PRODUTO-DESCRICAO
               DISPLAY "Deseja continuar? (S/N): " WITH NO ADVANCING
               ACCEPT WS-VERIFICACAO

      *        Caso a escolha seja continuar
               IF WS-VERIFICACAO = 'S'
      *          Recebe nova descrição
                 DISPLAY "Informe a nova descrição: "
                   WITH NO ADVANCING
                 ACCEPT WS-DESCRICAO
      
      *          Recebe nova descrição
                 DISPLAY "Informe o novo preço unitário: R$"
                   WITH NO ADVANCING
                 ACCEPT WS-PRECO-UNIT
      
      *          Recebe nova descrição
                 DISPLAY "Informe a nova quantidade em estoque: "
                   WITH NO ADVANCING
                 ACCEPT WS-QTD-ESTOQUE
               
      *        Caso a escolha não seja por continuar
               ELSE
                 DISPLAY "Operação Cancelada!"
                 CLOSE IDX-PRODUTOS
                 EXIT PARAGRAPH
               
               END-IF
           END-READ.

      *    Atualiza as variáveis de arquivo
           MOVE WS-DESCRICAO TO PRODUTO-DESCRICAO.
           MOVE WS-PRECO-UNIT TO PRODUTO-PRECO-UNIT.
           MOVE WS-QTD-ESTOQUE TO PRODUTO-QTD-ESTOQUE.

      *    Sobrescreve os dados antigos
           REWRITE DETALHE-PRODUTO.
           DISPLAY "Sucesso! Produto atualizado!"

      *    Abre o arquivo
           CLOSE IDX-PRODUTOS.

      *    Retorna
           EXIT PARAGRAPH.
       
       
       LISTAR-PRODUTOS.
           DISPLAY "-----------------------------------".
           DISPLAY " LISTAR PRODUTOS"
           DISPLAY "-----------------------------------".
           
      *    Zera as variáveis de controle
           MOVE 0 TO WS-CONTADOR.
           MOVE 'N' TO WS-EOF.

      *    Abre o arquivo
           PERFORM ABRE-ARQ-IDX.

      *    Loop de execução
           PERFORM UNTIL WS-EOF = 'S'
             READ IDX-PRODUTOS INTO DETALHE-PRODUTO

      *      Caso seja o final do arquivo (EOF)
             AT END
               MOVE 'S' TO WS-EOF
              
      *      Caso não seja o final do arquivo (EOF)
             NOT AT END
               MOVE PRODUTO-PRECO-UNIT TO WS-PRECO-EDITADO 

               ADD 1 TO WS-CONTADOR
               DISPLAY "PRODUTO #" WS-CONTADOR
               DISPLAY "Código: " PRODUTO-CODIGO
               DISPLAY "Descrição: " PRODUTO-DESCRICAO
               DISPLAY "Preço Unitário: R$" WS-PRECO-EDITADO
               DISPLAY "Quantidade em Estoque: " PRODUTO-QTD-ESTOQUE
               DISPLAY " "          

           END-PERFORM.

      *    Fecha arquivo
           CLOSE IDX-PRODUTOS.
      
      *    Retorna
           EXIT PARAGRAPH.
       

       EXCLUIR-PRODUTO.
           DISPLAY "-----------------------------------".
           DISPLAY " EXCLUIR PRODUTO"
           DISPLAY "-----------------------------------".
      *    Recebe o código do produto que será excluído
           DISPLAY "Informe o código do produto: ".
           ACCEPT WS-CODIGO.

      *    Abre arquivo
           PERFORM ABRE-ARQ-IDX.

      *    Atuaiza a chave de busca
           MOVE WS-CODIGO TO PRODUTO-CODIGO

      *    Busca pelo produto no arquivo
           READ IDX-PRODUTOS KEY IS PRODUTO-CODIGO

      *      Se o produto não existir
             INVALID KEY
               DISPLAY "Chave inválida!"
               CLOSE IDX-PRODUTOS
               EXIT PARAGRAPH

      *      Se o produto existir
             NOT INVALID KEY
      *        Verifica se o estoque está zerado
               IF PRODUTO-QTD-ESTOQUE > 0
                 DISPLAY "Não foi possível excluir " PRODUTO-DESCRICAO
                 DISPLAY "Ainda existem itens em estoque!"
                 CLOSE IDX-PRODUTOS
                 EXIT PARAGRAPH
               END-IF

      *        Realiza a verificação
               DISPLAY "Excluindo produto " PRODUTO-DESCRICAO
               DISPLAY "Deseja continuar? (S/N): " WITH NO ADVANCING
               ACCEPT WS-VERIFICACAO
               
               IF WS-VERIFICACAO = 'S'
                 DELETE IDX-PRODUTOS
                 DISPLAY "Sucesso! Produto excluído!"
               ELSE
                 DISPLAY "Operação Cancelada!"
               END-IF
               
           END-READ.

      *    Fecha arquivo
           CLOSE IDX-PRODUTOS.

      *    Retorna
           EXIT PARAGRAPH.


       ABRE-ARQ-IDX.
           OPEN I-O IDX-PRODUTOS.

      *    Caso o arquivo não exista, cria
           IF WS-STATUS = "35"
             OPEN OUTPUT IDX-PRODUTOS
             CLOSE IDX-PRODUTOS
             PERFORM ABRE-ARQ-IDX
           END-IF.

      *    Retorna
           EXIT PARAGRAPH.
      