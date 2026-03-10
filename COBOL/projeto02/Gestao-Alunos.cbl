       IDENTIFICATION DIVISION.
           PROGRAM-ID. GESTAO-ALUNOS.
           AUTHOR. Mauricio Rodrigues.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-ALUNOS ASSIGN TO "alunos.idx"
             ORGANIZATION IS INDEXED
             ACCESS MODE IS DYNAMIC
             FILE STATUS IS WS-STATUS
             RECORD KEY IS ALUNO-MATRICULA.
       
       DATA DIVISION.
       FILE SECTION.
       FD ARQ-ALUNOS.
       01 REG-ALUNO.
           05 ALUNO-MATRICULA        PIC X(08).
           05 ALUNO-NOME             PIC X(30).
           05 ALUNO-CURSO            PIC X(20).
           05 ALUNO-DATA-ENTRADA     PIC X(10).
       
       WORKING-STORAGE SECTION.
       01 WS-STATUS                  PIC X(02) VALUE "00".
       01 WS-OPCAO                   PIC X(01).
       01 WS-CONTADOR                PIC 9(02).
       01 WS-EOF                     PIC X(01) VALUE 'N'.

       01 WS-ALUNO-MATRICULA         PIC X(08).
       01 WS-ALUNO-NOME              PIC X(30).
       01 WS-ALUNO-CURSO             PIC X(20).
       01 WS-ALUNO-DATA-ENTRADA      PIC X(10).

       01 WS-DELETE-OP               PIC X(01).

       PROCEDURE DIVISION.
       MAIN.
           PERFORM UNTIL WS-OPCAO = 0
      *      Printa o menu e recebe a opção de ação
             PERFORM PRINT-MENU
             DISPLAY "Escolha sua opção: " WITH NO ADVANCING
             ACCEPT WS-OPCAO
             
      *      Faz o switch da opção escolhida
             EVALUATE WS-OPCAO
               WHEN 0
                 DISPLAY "Programa Finalizado!"
               WHEN 1
                 PERFORM CADASTRAR-ALUNO
               WHEN 2
                 PERFORM EDITAR-ALUNO
               WHEN 3
                 PERFORM LISTAR-ALUNOS
               WHEN 4
                 PERFORM EXCLUIR-ALUNO
               WHEN OTHER
                 DISPLAY "Opção inválida!"
             END-EVALUATE

           END-PERFORM.

           STOP RUN.

       PRINT-MENU.
           DISPLAY "----------------------------------".
           DISPLAY " GESTÃO DE ALUNOS".
           DISPLAY "----------------------------------".
           DISPLAY " 1 - Cadastrar Aluno".
           DISPLAY " 2 - Editar Aluno".
           DISPLAY " 3 - Listar Alunos".
           DISPLAY " 4 - Excluir Aluno".
           DISPLAY " 0 - Sair".
           DISPLAY "----------------------------------".

       CADASTRAR-ALUNO.
           DISPLAY "----------------------------------".
           DISPLAY " CADASTRAR NOVO ALUNO".
           DISPLAY "----------------------------------".
      
      *    Recebe a matrícula
           DISPLAY "Informe a Matrícula: " WITH NO ADVANCING.
           ACCEPT WS-ALUNO-MATRICULA.
      
      *    Recebe o nome
           DISPLAY "Informe o Nome: " WITH NO ADVANCING.
           ACCEPT WS-ALUNO-NOME.
      
      *    Recebe o curso
           DISPLAY "Informe o Curso: " WITH NO ADVANCING.
           ACCEPT WS-ALUNO-CURSO.
      
      *    Recebe a data de entrada
           DISPLAY "Informe a Data de Entrada: " WITH NO ADVANCING.
           ACCEPT WS-ALUNO-DATA-ENTRADA.

      *    Salva as informações coletadas nas variáveis de arquivo
           MOVE WS-ALUNO-MATRICULA TO ALUNO-MATRICULA.
           MOVE WS-ALUNO-NOME TO ALUNO-NOME.
           MOVE WS-ALUNO-CURSO TO ALUNO-CURSO.
           MOVE WS-ALUNO-DATA-ENTRADA TO ALUNO-DATA-ENTRADA.

      *    Adiciona o novo aluno no arquivo
           PERFORM ABRE-ARQ-IDX.

           WRITE REG-ALUNO
             INVALID KEY
               DISPLAY "Erro ao Cadastrar Aluno!"

             NOT INVALID KEY
               DISPLAY "Sucesso! Aluno Cadastrado!"
           
           CLOSE ARQ-ALUNOS.

       EDITAR-ALUNO.
           DISPLAY "----------------------------------".
           DISPLAY " EDITAR ALUNO".
           DISPLAY "----------------------------------".

      *    Recebe a matrícula do aluno a ser alterado
           DISPLAY "Informe a Matrícula: " WITH NO ADVANCING.
           ACCEPT WS-ALUNO-MATRICULA.

      *    Abre o arquivo
           PERFORM ABRE-ARQ-IDX.

      *    Atualiza a chave de busca (ALUNO-MATRICULA)
           MOVE WS-ALUNO-MATRICULA TO ALUNO-MATRICULA.
           
      *    Busca a matrícula no arquivo
           READ ARQ-ALUNOS KEY IS ALUNO-MATRICULA

      *      Caso não encontre
             INVALID KEY
               DISPLAY "Matrícula Não Encontrada!"
             
      *      Caso encontre
             NOT INVALID KEY 
               DISPLAY "Alterar informações..."
               DISPLAY "Informe o Novo Nome: " WITH NO ADVANCING
               ACCEPT WS-ALUNO-NOME

               DISPLAY "Informe a Novo Curso: " WITH NO ADVANCING
               ACCEPT WS-ALUNO-CURSO
               
               DISPLAY "Informe o Nova Data de Entrada: " 
                 WITH NO ADVANCING
               ACCEPT WS-ALUNO-DATA-ENTRADA

      *        Move os novos valores para a variável de arquivo
               MOVE WS-ALUNO-NOME TO ALUNO-NOME
               MOVE WS-ALUNO-CURSO TO ALUNO-CURSO
               MOVE WS-ALUNO-DATA-ENTRADA TO ALUNO-DATA-ENTRADA
               
      *        Sobrescreve as informações antigas
               REWRITE REG-ALUNO
                 DISPLAY "Aluno " ALUNO-NOME " atualizado"

           END-READ.

      *    Fecha o arquivo
           CLOSE ARQ-ALUNOS.
           

       LISTAR-ALUNOS.
           DISPLAY "----------------------------------".
           DISPLAY " LISTAR ALUNOS CADASTRADOS".
           DISPLAY "----------------------------------".
           
      *    Zera as informações do loop
           MOVE 0 TO WS-CONTADOR.
           MOVE 'N' TO WS-EOF.

      *    Abre o arquivo
           PERFORM ABRE-ARQ-IDX.

      *    Repetição de execução
           PERFORM UNTIL WS-EOF = 'S'
             READ ARQ-ALUNOS INTO REG-ALUNO

             AT END
      *        Sinaliza que chegou ao final do arquivo
               MOVE 'S' TO WS-EOF

             NOT AT END
      *        Printa os dados do aluno
               ADD 1 TO WS-CONTADOR
               DISPLAY "Aluno #" WS-CONTADOR
               DISPLAY "Matrícula: " ALUNO-MATRICULA
               DISPLAY "Nome: " ALUNO-NOME
               DISPLAY "Curso: " ALUNO-CURSO
               DISPLAY "Data de Entrada: " ALUNO-DATA-ENTRADA
               DISPLAY " "

           END-PERFORM.
           
      *    Fecha o arquivo
           CLOSE ARQ-ALUNOS.

       EXCLUIR-ALUNO.
           DISPLAY "----------------------------------".
           DISPLAY " EXCLUIR ALUNO".
           DISPLAY "----------------------------------".
           
      *    Recebe a matrícula do aluno a ser excluído
           DISPLAY "Informe a matrícula: " WITH NO ADVANCING.
           ACCEPT WS-ALUNO-MATRICULA

      *    Abre arquivo
           PERFORM ABRE-ARQ-IDX.

      *    Atualiza a chave de busca (ALUNO-MATRICULA)
           MOVE WS-ALUNO-MATRICULA TO ALUNO-MATRICULA

      *    Busca pelo aluno no arquivo
           READ ARQ-ALUNOS KEY IS ALUNO-MATRICULA

      *      Caso não encontre
             INVALID KEY
               DISPLAY "Aluno não encontrado!"

      *      Caso encontre  
             NOT INVALID KEY
      *        Realiza uma verificação
               DISPLAY "Excluindo aluno " ALUNO-NOME
               DISPLAY "Deseja continuar? (S/N): "
               ACCEPT WS-DELETE-OP

      *        Faz o switch da escolha
               EVALUATE WS-DELETE-OP
                 WHEN 'S'
                   DELETE ARQ-ALUNOS
                   DISPLAY "Aluno excluído com sucesso!"
                  
                 WHEN 'N'
                   DISPLAY "Operação Cancelada!"

                 WHEN OTHER
                   DISPLAY "Opção inválida!"
               END-EVALUATE

           END-READ.

      *    Fecha arquivo
           CLOSE ARQ-ALUNOS.

       ABRE-ARQ-IDX.
           OPEN I-O ARQ-ALUNOS.

      *    Caso o arquivo não exista (status 35), cria
           IF WS-STATUS = "35"
             OPEN OUTPUT ARQ-ALUNOS
             CLOSE ARQ-ALUNOS
             PERFORM ABRE-ARQ-IDX
           END-IF.

      