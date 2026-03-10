       IDENTIFICATION DIVISION.
           PROGRAM-ID. Professores-Index.
           AUTHOR. Mauricio Rodrigues.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-PROFESSORES ASSIGN TO "professores.idx"
             ORGANIZATION IS INDEXED
             ACCESS MODE IS DYNAMIC
             RECORD KEY IS PRO-MATRICULA
             FILE STATUS IS WS-STATUS.
       
       DATA DIVISION.
       FILE SECTION.
       FD ARQ-PROFESSORES.
       01 PROFESSOR.
           05 PRO-MATRICULA      PIC X(08).
           05 PRO-NOME           PIC X(30).
       
       WORKING-STORAGE SECTION.
       01 WS-STATUS              PIC X(02).
       01 WS-OPCAO               PIC 9.
       01 WS-CONTADOR            PIC 9(02).
       01 WS-EXC-OPCAO           PIC X.

       01 WS-PROFESSOR.
           05 WS-PRO-MATRICULA   PIC X(08).
           05 WS-PRO-NOME        PIC X(30).
       
       PROCEDURE DIVISION.
       MAIN.
      *    Recebendo opção
           DISPLAY "-------------------------------------".
           DISPLAY " SISTEMA DE PROFESSORES".
           DISPLAY "-------------------------------------".
           DISPLAY " 1 - Cadastrar Professor".
           DISPLAY " 2 - Listar Professorres".
           DISPLAY " 3 - Modificar Professor".
           DISPLAY " 4 - Excluir Professor".
           DISPLAY " 0 - Sair".
           DISPLAY "-------------------------------------".
           DISPLAY " Escolha sua opção: " WITH NO ADVANCING.
           ACCEPT WS-OPCAO.

      *    Switch opção
           EVALUATE WS-OPCAO
             WHEN 0
               DISPLAY "Programa Finalizado!"
               STOP RUN
             WHEN 1
               PERFORM CADASTRAR
             WHEN 2
               PERFORM LISTAR
             WHEN 3
               PERFORM MODIFICAR
             WHEN 4
               PERFORM EXCLUIR
             WHEN OTHER
               DISPLAY "Opção Inválida!"
               PERFORM MAIN
           END-EVALUATE.


       ABRE-ARQ.
           OPEN I-O ARQ-PROFESSORES.
      *      Caso o arquivo não exista (status 35), ele é criado
             IF WS-STATUS = "35"
               OPEN OUTPUT ARQ-PROFESSORES
               CLOSE ARQ-PROFESSORES
               PERFORM ABRE-ARQ
             END-IF.


       FECHA-ARQ.
           CLOSE ARQ-PROFESSORES.


       CADASTRAR.
           DISPLAY "-------------------------------------".
           DISPLAY " CADASTRAR PROFESSOR".
           DISPLAY "-------------------------------------".
           
      *    Recebe as informações do professor
           DISPLAY "Informe a matrícula: " WITH NO ADVANCING.
           ACCEPT WS-PRO-MATRICULA.
           DISPLAY "Informe o nome: " WITH NO ADVANCING.
           ACCEPT WS-PRO-NOME.

      *    Salva as informações no arquivo
           PERFORM ABRE-ARQ.
           MOVE WS-PRO-MATRICULA TO PRO-MATRICULA.
           MOVE WS-PRO-NOME TO PRO-NOME.

           WRITE PROFESSOR
             INVALID KEY
               DISPLAY "Erro ao gravar informações no arquivo!"
             NOT INVALID KEY
               DISPLAY "Sucesso! Professor cadastrado!".

           PERFORM FECHA-ARQ.
           PERFORM MAIN.

       
       LISTAR.
           DISPLAY "-------------------------------------".
           DISPLAY " LISTAR PROFESSORES".
           DISPLAY "-------------------------------------".

      *    Garante que o status do arquivo seja OK (00) e zera contador
           PERFORM ABRE-ARQ.
           MOVE "00" TO WS-STATUS.
           MOVE ZERO TO WS-CONTADOR.

      *    Loop de execução (até EOF - status 10)
           PERFORM UNTIL WS-STATUS = "10"
             READ ARQ-PROFESSORES NEXT RECORD
               AT END
                 MOVE "10" TO WS-STATUS
               NOT AT END
                 ADD 1 TO WS-CONTADOR
                 DISPLAY "PROFESSOR #" WS-CONTADOR
                 DISPLAY "Matrícula: " PRO-MATRICULA
                 DISPLAY "Nome: " PRO-NOME
                 DISPLAY " "
           END-PERFORM.

      *    Fechar arquivo e retorna para a MAIN
           PERFORM FECHA-ARQ.
           PERFORM MAIN.

       
       MODIFICAR.
           DISPLAY "-------------------------------------".
           DISPLAY " MODIFICAR PROFESSOR".
           DISPLAY "-------------------------------------".

      *    Recebe a matrícula do professor
           DISPLAY "Informe a Matrícula: " WITH NO ADVANCING.
           ACCEPT WS-PRO-MATRICULA.

      *    Abre arquivo
           PERFORM ABRE-ARQ.
           MOVE WS-PRO-MATRICULA TO PRO-MATRICULA.
           
      *    Busca e atualiza o nome
           READ ARQ-PROFESSORES KEY IS PRO-MATRICULA
             INVALID KEY
               DISPLAY "Matrícula não encontrada!"
             NOT INVALID KEY
               DISPLAY "Informe o novo Nome: " WITH NO ADVANCING
               ACCEPT WS-PRO-NOME
               MOVE WS-PRO-NOME TO PRO-NOME
               REWRITE PROFESSOR
                 DISPLAY "Registro atualizado!"
           END-READ.

      *    Fecha arquivo e retorna para a MAIN
           PERFORM FECHA-ARQ.
           PERFORM MAIN.


       EXCLUIR.
           DISPLAY "-------------------------------------".
           DISPLAY " EXCLUIR PROFESSOR".
           DISPLAY "-------------------------------------".

      *    Recebe a matrícula do professor
           DISPLAY "Informe a Matrícula: " WITH NO ADVANCING.
           ACCEPT WS-PRO-MATRICULA.
           MOVE WS-PRO-MATRICULA TO PRO-MATRICULA

      *    Abre o arquivo
           PERFORM ABRE-ARQ.

      *    Busca e remove o professor
           READ ARQ-PROFESSORES KEY IS PRO-MATRICULA
             INVALID KEY
               DISPLAY "Matrícula não encontrada!"
             
             NOT INVALID KEY
      *        Confirma a exclusão
               DISPLAY "Excluindo o professor " PRO-NOME 
               DISPLAY "Deseja prosseguir? (S/N): "
                 WITH NO ADVANCING
               ACCEPT WS-EXC-OPCAO

               EVALUATE WS-EXC-OPCAO
                 WHEN 'S'
      *            Exclui o professor
                   DELETE ARQ-PROFESSORES
                   DISPLAY "Sucesso! Professor excluído!" 
                 
                 WHEN 'N'
      *            Cancela a operação
                   DISPLAY "Operação cancelada!"
                 
                 WHEN OTHER
      *            Opção inválida digitada
                   DISPLAY "Opção inválida!"
               END-EVALUATE
           
           END-READ.

      *    Fecha arquivo e volta para a MAIN
           PERFORM FECHA-ARQ.
           PERFORM MAIN.     
