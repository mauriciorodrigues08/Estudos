      * PROGRAMA PARA GRAVAÇÃO DE DADOS DE ALUNOS EM UM ARQUIVO

       IDENTIFICATION DIVISION.
           PROGRAM-ID. ALUNOS.
           AUTHOR. Mauricio Rodrigues.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT REG-ALUNOS ASSIGN TO "ALUNOS.DATA" 
             ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD REG-ALUNOS.
       01  DETALHES-ALUNO.
           05 NOME-ALUNO         PIC X(30).
           05 NOTAS.
             10 NOTA1            PIC 9(2)V9(2).
             10 NOTA2            PIC 9(2)V9(2).
           05 MEDIA              PIC 9(2)V9(2).
           05 RESULTADO          PIC X(10).

       WORKING-STORAGE SECTION.
       01 WS-NOME-ALUNO          PIC X(30).
       01 WS-NOTAS.
           10 WS-NOTA1           PIC 9(2)V9(2).
           10 WS-NOTA2           PIC 9(2)V9(2).
       01 WS-MEDIA               PIC 9(2)V9(2).
       01 WS-RESULTADO           PIC X(10).
       01 QTD-ALUNOS             PIC 9(2).
       01 CONTADOR               PIC 9(2) VALUE 1.

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "===================================".
           DISPLAY "  REGISTRO DE RESULTADO DE ALUNOS".
           DISPLAY "===================================".

           OPEN OUTPUT REG-ALUNOS.
           PERFORM RODA-PROGRAMA.
           CLOSE REG-ALUNOS.

           DISPLAY "=================================================".
           DISPLAY "REGISTRO FINALIZADO. ARQUIVO 'ALUNOS.DATA' SALVO.".
           DISPLAY "=================================================".
           
           STOP RUN.


       RODA-PROGRAMA.
      *    Recebe a quantidade de alunos que serão registrados
           DISPLAY "Informe a quantidade de alunos a ser cadastrados: " 
             WITH NO ADVANCING.
           ACCEPT QTD-ALUNOS.

      *    Realiza o loop
           PERFORM UNTIL CONTADOR >   QTD-ALUNOS

      *      Recebe as informacoes dos alunos
             PERFORM RECEBE-INFORMACOES
      
      *      Verifica o resultado
             PERFORM VERIFICA-RESULTADO
      
      *      Salva informacoes no arquivo
             PERFORM SALVA-INFORMACOES

      *      Incrementa o contador de alunos
             ADD 1 TO CONTADOR

           END-PERFORM.


       RECEBE-INFORMACOES.
           DISPLAY " ".
           DISPLAY "Cadastrando Aluno " CONTADOR.

           DISPLAY "Informe o nome do Aluno: " WITH NO ADVANCING.
           ACCEPT WS-NOME-ALUNO.  

           DISPLAY "Informe a primeira nota: " WITH NO ADVANCING.
           ACCEPT WS-NOTA1.

           DISPLAY "Informe a segunda nota: " WITH NO ADVANCING.
           ACCEPT WS-NOTA2.


       VERIFICA-RESULTADO.
           COMPUTE WS-MEDIA = (WS-NOTA1 + WS-NOTA2) / 2.
           
           IF WS-MEDIA >= 6.00
             MOVE "APROVADO" TO WS-RESULTADO
           ELSE
             MOVE "REPROVADO" TO WS-RESULTADO
           END-IF.
      

       SALVA-INFORMACOES.
           MOVE WS-NOME-ALUNO TO NOME-ALUNO.
           MOVE WS-NOTAS TO NOTAS.
           MOVE WS-MEDIA TO MEDIA.
           MOVE WS-RESULTADO TO RESULTADO.

           WRITE DETALHES-ALUNO.
