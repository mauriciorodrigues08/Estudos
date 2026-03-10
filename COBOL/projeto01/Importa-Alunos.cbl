      * PROJETO QUE SIMULA A IMPORTAÇÃO DE INFORMAÇÃO DE ALUNOS QUE ESTÁ
      * CONTIDA EM UM ARQUIVO .csv PARA UMA BASE DE DADOS INDEXADA

       IDENTIFICATION DIVISION.
           PROGRAM-ID. Importa-Alunos.
           AUTHOR. Mauricio Rodrigues.
       

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT ARQ-ALUNOS ASSIGN TO "alunos.csv"
             ORGANIZATION IS LINE SEQUENTIAL.
           
           SELECT DB-ALUNOS ASSIGN TO "alunos.idx"
             ORGANIZATION IS INDEXED
             ACCESS MODE IS DYNAMIC
             RECORD KEY IS DB-MATRICULA
             FILE STATUS IS WS-STATUS.
             
       
       DATA DIVISION.
       FILE SECTION.
       FD ARQ-ALUNOS.
       01 REG-ARQ-ALUNOS          PIC X(100).
       
       FD DB-ALUNOS.
       01 REG-DB-ALUNO.
           05 DB-MATRICULA         PIC X(08).
           05 DB-NOME.
             10 DB-PRIMEIRO-NOME   PIC X(15).
             10 DB-ULTIMO-NOME     PIC X(15).
           05 DB-CURSO             PIC X(20).
           05 DB-DATA-ENTRADA.
             10 DB-DIA-ENTRADA     PIC 9(02).
             10 DB-MES-ENTRADA     PIC 9(02).
             10 DB-ANO-ENTRADA     PIC 9(04).

       WORKING-STORAGE SECTION.
       01 WS-STATUS                PIC X(02) VALUE "00".
       01 WS-EOF                   PIC X(01) VALUE 'N'.
       01 WS-SEPARADOR             PIC X(01) VALUE ';'.
       
       01 WS-CONTADOR              PIC 9(02).
       
       01 WS-MATRICULA             PIC X(08).
       01 WS-NOME                  PIC X(30).
       01 WS-CURSO                 PIC X(20).
       01 WS-DATA-ENTRADA          PIC X(10).
       
       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "------------------------------------------".
           DISPLAY " IMPORTANDO ALUNOS PARA ARQUIVO INDEXADO"
           DISPLAY "------------------------------------------".

      *    Abre arquivo csv
           OPEN INPUT ARQ-ALUNOS.

      *    Loop de execução
           PERFORM UNTIL WS-EOF = 'S'
      *      Lê a linha atual do arquivo
             READ ARQ-ALUNOS INTO REG-ARQ-ALUNOS
             
      *      Verifica se ainda existem informações para ser processadas
             AT END
               MOVE 'S' TO WS-EOF

             NOT AT END
               PERFORM PROCESSAR-REGISTRO
               
           END-PERFORM.           

           DISPLAY "------------------------------------------".
           DISPLAY "INFORMAÇÕES IMPORTADAS COM SUCESSO!"
           DISPLAY "------------------------------------------".

      *    Fecha arquivo csv
           CLOSE ARQ-ALUNOS.

           STOP RUN.


       PROCESSAR-REGISTRO.
      *    Retira os espaços em branco
           MOVE FUNCTION TRIM(REG-ARQ-ALUNOS) TO REG-ARQ-ALUNOS.

      *    Separa a linha do csv e salva nas variáveis locais
           UNSTRING REG-ARQ-ALUNOS DELIMITED BY WS-SEPARADOR
             INTO WS-MATRICULA, WS-NOME, WS-CURSO, WS-DATA-ENTRADA.

      *    Envia as informações locais para as variáveis de arquivo
           MOVE WS-MATRICULA TO DB-MATRICULA.
           MOVE WS-NOME TO DB-NOME.
           MOVE WS-CURSO TO DB-CURSO.
           MOVE WS-DATA-ENTRADA TO DB-DATA-ENTRADA.
       
      *    Salva as informações no arquivo idx
           PERFORM ABRE-ARQ-IDX.
           WRITE REG-DB-ALUNO
             INVALID KEY
               DISPLAY "Erro ao gravar informações no Arquivo!"
             
             NOT INVALID KEY
               ADD 1 TO WS-CONTADOR
               DISPLAY "Aluno #" WS-CONTADOR
               DISPLAY "Matrícula: " DB-MATRICULA
               DISPLAY "Nome: " DB-NOME
               DISPLAY "Curso: " DB-CURSO
               DISPLAY "Data de Entrada: " DB-DATA-ENTRADA
               DISPLAY " "

           END-WRITE.
           CLOSE DB-ALUNOS.


       ABRE-ARQ-IDX.
           OPEN I-O DB-ALUNOS.

      *    Caso o arquivo não exista (status 35), cria o arquivo
           IF WS-STATUS = "35"
             OPEN OUTPUT DB-ALUNOS
             CLOSE DB-ALUNOS
             PERFORM ABRE-ARQ-IDX
           END-IF.
       