       IDENTIFICATION DIVISION.
           PROGRAM-ID. MostraResultados.
           AUTHOR. Mauricio Rodrigues.
       

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT REG-ALUNOS ASSIGN TO "ALUNOS.DATA"
             ORGANIZATION IS LINE SEQUENTIAL.
       

       DATA DIVISION.
       FILE SECTION.
       FD REG-ALUNOS.
       01 DETALHAMENTO.
           05 NOME-ALUNO         PIC X(30).
           05 NOTAS.
             10 NOTA1            PIC 9(2)V9(2).
             10 NOTA2            PIC 9(2)V9(2).
           05 MEDIA              PIC 9(2)V9(2).
           05 RESULTADO          PIC X(10).

       WORKING-STORAGE SECTION.
       01 LEITURA-FINALIZADA     PIC X.

       01 CONTADORES.
           05 TOTAL-APROVADOS    PIC 9(2) VALUE 0.
           05 TOTAL-REPROVADOS   PIC 9(2) VALUE 0.
           05 MAIORES-8          PIC 9(2) VALUE 0.

       
       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "========================".
           DISPLAY "   RESULTADO - ALUNOS".
           DISPLAY "========================".

           OPEN INPUT REG-ALUNOS.
           PERFORM PROCESSAMENTO.
           CLOSE REG-ALUNOS.
           
           PERFORM PRINT-RESULTADO.

           STOP RUN.

       
       PROCESSAMENTO.
           PERFORM UNTIL LEITURA-FINALIZADA = "S"
             READ REG-ALUNOS INTO DETALHAMENTO

             AT END
               MOVE "S" TO LEITURA-FINALIZADA
             NOT AT END
               PERFORM PRINT-DADOS
               PERFORM VERIFICA-DADOS
           END-PERFORM.           

       PRINT-DADOS.
           INSPECT NOME-ALUNO REPLACING ALL " " BY LOW-VALUES.
           DISPLAY "- DADOS DE " NOME-ALUNO " -".
           DISPLAY "Nota 1   : " NOTA1.
           DISPLAY "Nota 2   : " NOTA2.
           DISPLAY "Media    : " MEDIA.
           DISPLAY "Resultado: " RESULTADO.
           DISPLAY " ".

       VERIFICA-DADOS.
           IF RESULTADO = "APROVADO"
             ADD 1 TO TOTAL-APROVADOS
             IF MEDIA >= 8
               ADD 1 TO MAIORES-8
             END-IF
           ELSE
             ADD 1 TO TOTAL-REPROVADOS
           END-IF.

      
       PRINT-RESULTADO.
           DISPLAY "==================================".
           DISPLAY " RESUMO:".
           DISPLAY "   Aprovados             : " TOTAL-APROVADOS.
           DISPLAY "   Reprovados            : " TOTAL-REPROVADOS.
           DISPLAY "   Premiados (Media >= 8): " MAIORES-8.
           DISPLAY "==================================".
