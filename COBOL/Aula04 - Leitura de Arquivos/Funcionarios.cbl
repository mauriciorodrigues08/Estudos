      * EXEMPLO DE MANIPULACAO DE ARQUIVO COM DADOS DE FUNCIONARIOS

       IDENTIFICATION DIVISION.
           PROGRAM-ID. FUNCIONARIOS.
           AUTHOR. Mauricio Rodrigues.

       ENVIRONMENT DIVISION.
      * Declarando o arquivo 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FUNCIONARIOS ASSIGN TO "FUNCIONARIOS.DATA"
             ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
      * Tratando as variaveis de arquivo
       FILE SECTION.
       FD FUNCIONARIOS.
       01  DETALHAMENTO.
           88 FINAL-REGISTRO VALUE HIGH-VALUES.
           
           05 CODIGO            PIC X(5).
           
           05 NOME.
             10 PRIMEIRO-NOME   PIC X(20).
             10 ULTIMO-NOME     PIC X(20).
           
           05 GENERO            PIC X.

      * Tratando as variaveis locais
       WORKING-STORAGE SECTION.
       01  CONTADORES.
           05 TOTAL-HOMENS      PIC 9(3) VALUE 0  .
           05 TOTAL-MULHERES    PIC 9(3) VALUE 0.
           05 ERROS             PIC 9(3) VALUE 0.

       01 LEITURA-FINALIZADA    PIC X VALUE "N".

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "==================================".
           DISPLAY "     CONTAGEM DE FUNCIONARIOS"
           DISPLAY "==================================".

      * Abrindo o arquivo
           OPEN INPUT FUNCIONARIOS.

      * Realizando a leitura (laço de repetição)
           PERFORM UNTIL LEITURA-FINALIZADA = "S"
             READ FUNCIONARIOS INTO DETALHAMENTO

      *      Verifica se a leitura chegou ao final
             AT END
      *        Caso seja o final, move "S" para a variavel de controle
               MOVE "S" TO LEITURA-FINALIZADA
             
             NOT AT END 
      *        Caso não seja o final, trata a informacao coletada
               INSPECT PRIMEIRO-NOME REPLACING ALL " " BY LOW-VALUES
               INSPECT ULTIMO-NOME REPLACING ALL " " BY LOW-VALUES
               DISPLAY " " CODIGO " - " PRIMEIRO-NOME " " ULTIMO-NOME 
               " - " GENERO

               IF GENERO = "M"
                 ADD 1 TO TOTAL-HOMENS
               ELSE
                 IF GENERO = "F"
                   ADD 1 TO TOTAL-MULHERES
                 ELSE
                   ADD 1 TO ERROS
                 END-IF
               END-IF

           END-PERFORM.

      *    Printando resultado
           DISPLAY "==================================".
           DISPLAY "RESUMO:"
           DISPLAY "TOTAL DE HOMENS  : " TOTAL-HOMENS 
           DISPLAY "TOTAL DE MULHERES: " TOTAL-MULHERES
           DISPLAY "ERROS            : " ERROS
           DISPLAY "==================================".

      *    Fechando o arquivo
           CLOSE FUNCIONARIOS.

           STOP RUN.
