000001 IDENTIFICATION DIVISION.
000002     PROGRAM-ID. Entrada.
000003     author. Mauricio Rodrigues.
000004
000005 ENVIRONMENT DIVISION.
000006 
000007 DATA DIVISION.
000008
000009 WORKING-STORAGE SECTION.
000010*Variavel para nome do usuario (entrada de dados manual) 
000011 01 NOME  PIC A(020).
000012 
000013*Variavel para data atual (entrada de dados automatica)
000014 01 DATA-ATUAL.
000015     05 ANO-ATUAL  PIC 9(004).
000016     05 MES-ATUAL  PIC 9(002).
000017     05 DIA-ATUAL  PIC 9(002).
000018
000019 PROCEDURE DIVISION.
000020 MAIN.
000021*    Recebe nome do usuario digitado pelo terminal
000022     DISPLAY "Digite seu Nome: ".
000023     ACCEPT NOME.
000024     
000025*    Recebe a data atual do sistema
000026     ACCEPT DATA-ATUAL FROM DATE YYYYMMDD
000027
000028*    Printando a mensagem de boas vindas
000029     DISPLAY "Bem-Vindo, " NOME. 
000030
000031     DISPLAY "A data atual é: " DATA-ATUAL 
             ", que também pode ser escrita como: " DIA-ATUAL "/" 
             MES-ATUAL "/" ANO-ATUAL.
000032
000033     STOP RUN.
000034 END PROGRAM Entrada.
