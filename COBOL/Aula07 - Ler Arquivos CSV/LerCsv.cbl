       IDENTIFICATION DIVISION.
           PROGRAM-ID. LerCsv.
           AUTHOR. Mauricio Rodrigues.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT REGISTRO-CSV ASSIGN TO "entrada.csv"
               ORGANIZATION IS LINE SEQUENTIAL.
       
       DATA DIVISION.
       FILE SECTION.
       FD  REGISTRO-CSV.
       01 DETALHAMENTO          PIC X(150).

       WORKING-STORAGE SECTION.
       01 WS-FIM-ARQ               PIC X(01) VALUE 'N'.
       01 WS-CONTADOR              PIC 9(05) VALUE ZEROS.
       01 WS-REGISTRO              PIC 9(05) VALUE ZEROS.

       01 WS-DETALHAMENTO.
      *    Array de 3 posições
           05 WS-DADO              PIC X(50) OCCURS 3 TIMES.
       
       PROCEDURE DIVISION.
       MAIN.
           OPEN INPUT REGISTRO-CSV.

           PERFORM LER-CABECALHO.
           DISPLAY " "
           PERFORM PROCESSAR-REGISTROS UNTIL WS-FIM-ARQ = 'S'.
           
           CLOSE REGISTRO-CSV.
           STOP RUN.

       LER-CABECALHO.
           READ REGISTRO-CSV INTO DETALHAMENTO
               NOT AT END
                   PERFORM SEPARAR-CAMPOS
                   DISPLAY "Cabeçalho:"
                   PERFORM EXIBIR
           END-READ.

       SEPARAR-CAMPOS.
      *    Inicializa o campo com espaços vazios
           MOVE SPACES TO WS-DETALHAMENTO

      *    Salva os dados delimitados por , (Semelhante ao split())
           UNSTRING DETALHAMENTO DELIMITED BY ','
               INTO WS-DADO(1) WS-DADO(2) WS-DADO(3)
           END-UNSTRING.

       PROCESSAR-REGISTROS.
           READ REGISTRO-CSV INTO DETALHAMENTO
               AT END
                   MOVE 'S' TO WS-FIM-ARQ
               NOT AT END
                   ADD 1 TO WS-REGISTRO
                   PERFORM SEPARAR-CAMPOS
                   DISPLAY "REGISTRO #" WS-REGISTRO
                   PERFORM EXIBIR
                   DISPLAY " "
           END-READ.

       EXIBIR.
      *    Semelhante ao laço for(int i=1; i<3; i++)
           PERFORM VARYING WS-CONTADOR FROM 1 BY 1 UNTIL WS-CONTADOR > 3
               DISPLAY "Dado " WS-CONTADOR ": " WS-DADO(WS-CONTADOR)
           END-PERFORM.
