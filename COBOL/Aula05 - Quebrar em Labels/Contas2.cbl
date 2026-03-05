      * EXEMPLO DE MANIPULACAO DE ARQUIVO COM DADOS DE UMA CONTA

       IDENTIFICATION DIVISION.
           PROGRAM-ID. CONTAS.
           AUTHOR. Mauricio Rodrigues.


       ENVIRONMENT DIVISION.
      * Declarando arquivo CONTAS
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CONTAS ASSIGN TO "CONTAS.DATA"
             ORGANIZATION IS LINE SEQUENTIAL. 


       DATA DIVISION.
      * Declarando variaveis de arquivo
       FILE SECTION.
       FD CONTAS.
       01 DETALHAMENTO.
           88 FINAL-REGISTRO VALUE HIGH-VALUES.

           05 NOME-CLIENTE.
             15 PRIMEIRO-NOME     PIC X(15).
             15 ULTIMO-NOME       PIC X(15).

           05 DATA-NASCIMENTO.
             10 DIA-NASC          PIC 9(2).
             10 MES-NASC          PIC 9(2).
             10 ANO-NASC          PIC 9(4).

           05 GENERO              PIC X.

           05 CARTAO.
             10 NUMERO-CARTAO.
               15 PRIMEIRO-BLOCO  PIC 9(4).
               15 SEGUNDO-BLOCO   PIC 9(4).
               15 TERCEIRO-BLOCO  PIC 9(4).
               15 QUARTO-BLOCO    PIC 9(4).
             10 CVV               PIC 9(3).
             10 VENCIMENTO.
               15 MES-VENC        PIC 9(2).
               15 ANO-VENC        PIC 9(4).

       WORKING-STORAGE SECTION.
      * Declarando variaveis locais
       01 CONTADORES.
           05 TOTAL-CLIENTES      PIC 9(2) VALUE 0.
           05 TOTAL-ADULTOS       PIC 9(2) VALUE 0.
           05 TOTAL-VENCIDOS      PIC 9(2) VALUE 0.
           05 TOTAL-HOMENS        PIC 9(2) VALUE 0.
           05 TOTAL-MULHERES      PIC 9(2) VALUE 0.
           05 ERROS-GENERO        PIC 9(2) VALUE 0.

       01 LEITURA-FINALIZADA      PIC X VALUE "N".

       01 DATA-ATUAL.
           05 ANO-ATUAL           PIC 9(4).
           05 MES-ATUAL           PIC 9(2).
           05 DIA-ATUAL           PIC 9(2).

       01 IDADE                   PIC 9(3).


       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "=======================================".
           DISPLAY "        PROCESSAMENTO DE CONTAS"
           DISPLAY "=======================================".

      *    Pega a data atual
           ACCEPT DATA-ATUAL FROM DATE YYYYMMDD.
      
      *    Abre o arquivo
           OPEN INPUT CONTAS.

      *    Realiza a leitura
           PERFORM PROCESSAMENTO.
           
      *    Fecha o arquivo
           CLOSE CONTAS.

      *    Printa os resultados
           PERFORM PRINT-RESULTADO.

           STOP RUN.


       PROCESSAMENTO.
           PERFORM UNTIL LEITURA-FINALIZADA = "S"
             READ CONTAS INTO DETALHAMENTO

      *      Verifica se chegou ao final do arquivo
             AT END
               MOVE "S" TO LEITURA-FINALIZADA
             NOT AT END
               INSPECT PRIMEIRO-NOME REPLACING ALL " " BY LOW-VALUES
               INSPECT ULTIMO-NOME REPLACING ALL " " BY LOW-VALUES
      
      *        Printa o dado coletado
               PERFORM PRINT-DADO
      
      *        Verifica se eh maior de idade
               PERFORM VERIFICA-MAIOR

      *        Verifica se o cartao esta vencido
               PERFORM VERIFICA-VENCIMENTO

      *        Verifica o genero
               PERFORM VERIFICA-GENERO

      *        Incrementa o total de cliente
               ADD 1 TO TOTAL-CLIENTES

           END-PERFORM.


       PRINT-DADO.
           DISPLAY "- Dados de " PRIMEIRO-NOME " " ULTIMO-NOME " -".

           DISPLAY "Data Nascimento : " DIA-NASC "/" MES-NASC "/"
             ANO-NASC.

           DISPLAY "Genero          : " GENERO.
           
           DISPLAY "Numero do Cartao: " PRIMEIRO-BLOCO " " 
             SEGUNDO-BLOCO " " TERCEIRO-BLOCO " " QUARTO-BLOCO.
           
           DISPLAY "Data de Vencim. : " MES-VENC "/" ANO-VENC.
           
           DISPLAY "CVV             : " CVV.
           
           DISPLAY " ".


       VERIFICA-MAIOR.
           COMPUTE IDADE = ANO-ATUAL - ANO-NASC.

           IF IDADE > 18 OR ( IDADE = 18 AND MES-ATUAL > MES-NASC )
              ADD 1 TO TOTAL-ADULTOS
           END-IF.


       VERIFICA-VENCIMENTO.
           IF ANO-ATUAL > ANO-VENC 
             ADD 1 TO TOTAL-VENCIDOS
           ELSE
             IF (ANO-ATUAL = ANO-VENC) AND (MES-ATUAL > MES-VENC)
               ADD 1 TO TOTAL-VENCIDOS
             END-IF
           END-IF.


       VERIFICA-GENERO.
           IF GENERO = "M"
             ADD 1 TO TOTAL-HOMENS
           ELSE
             IF GENERO = "F"
               ADD 1 TO TOTAL-MULHERES
             ELSE
               ADD 1 TO ERROS-GENERO
             END-IF
           END-IF.
      

       PRINT-RESULTADO.
           DISPLAY "=======================================".
           DISPLAY "RESUMO:".
           DISPLAY "  Total de Clientes        : " TOTAL-CLIENTES.
           DISPLAY "  Total de Adultos         : " TOTAL-ADULTOS.
           DISPLAY "  Total de Homens          : " TOTAL-HOMENS.
           DISPLAY "  Total de Mulheres        : " TOTAL-MULHERES.
           DISPLAY "  Total de Cartoes Vencidos: " TOTAL-VENCIDOS.
           DISPLAY "=======================================".
