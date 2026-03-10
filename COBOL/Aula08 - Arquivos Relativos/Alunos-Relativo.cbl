       IDENTIFICATION DIVISION.
           PROGRAM-ID. ALUNOS-RELATIVO.
           AUTHOR. Mauricio Rodrigues.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-ALUNOS ASSIGN TO "alunos.dat"
             ORGANIZATION IS RELATIVE
             ACCESS MODE IS DYNAMIC
             RELATIVE KEY IS WS-CHAVE.
       
       DATA DIVISION.
       FILE SECTION.
       FD  ARQ-ALUNOS.
       01 DETALHAMENTO.
           05 MATRICULA          PIC 9(04).
           05 NOME               PIC X(30).
           05 DATA-NASC          PIC X(10).
           05 CURSO              PIC X(30).
           05 MEDIA              PIC 99V9.

       WORKING-STORAGE SECTION.
       01 WS-OPCAO               PIC 9.
       01 WS-EOF                 PIC X VALUE 'N'.
       01 WS-CHAVE               PIC 9(04).
       01 WS-BUSCA               PIC 9(04).
       01 WS-NOME-AUX            PIC X(30).

       PROCEDURE DIVISION.
       MAIN.
      *    Recebe a opção
           DISPLAY " ".
           DISPLAY "=========================".
           DISPLAY " SISTEMA DE ALUNOS".
           DISPLAY "=========================".
           DISPLAY "1 - Cadastrar Aluno".
           DISPLAY "2 - Buscar Aluno".
           DISPLAY "0 - Sair".
           DISPLAY "Insira sua opção: " WITH NO ADVANCING.
           ACCEPT WS-OPCAO.

      *    Seleciona a ação desejada
           EVALUATE WS-OPCAO
             WHEN 1
               PERFORM CADASTRAR-ALUNO               
             WHEN 2
               PERFORM BUSCAR-ALUNO
             WHEN 0
               DISPLAY " "
               DISPLAY "===== PROGRAMA FINALIZADO ====="
               STOP RUN
             WHEN OTHER
               DISPLAY "Opção Inválida!"
               PERFORM MAIN
           END-EVALUATE.


      * Função para realizar o cadastro de um aluno
       CADASTRAR-ALUNO.
           DISPLAY " "
           DISPLAY "=========================".
           DISPLAY " CADASTRAR ALUNO".
           DISPLAY "=========================".
      *    Recebe a matrícula
           DISPLAY "Informe a Matrícula: " WITH NO ADVANCING.
           ACCEPT MATRICULA.
           MOVE MATRICULA TO WS-CHAVE.
      
      *    Limpando possível lixo na variável NOME
           MOVE SPACES TO NOME
           
      *    Recebe o nome
           DISPLAY "Informe o Mome: " WITH NO ADVANCING.
           ACCEPT NOME.
      
      *    Retirando os espaços extra do nome
           INSPECT NOME REPLACING ALL " " BY LOW-VALUES
           
      *    Recebe a data de nascimento
           DISPLAY "Informe a Data de Nasc. (DD/MM/YYYY): " 
             WITH NO ADVANCING.
           ACCEPT DATA-NASC.
           
      *    Recebe o curso
           DISPLAY "Informe o Curso Atual: " WITH NO ADVANCING.
           ACCEPT CURSO.
           
      *    Recebe a media
           DISPLAY "Informe a Média (em 10.0): " WITH NO ADVANCING.
           ACCEPT MEDIA.

      *    Grava no arquivo
           PERFORM GRAVAR.

      *    Retorna para a main
           PERFORM MAIN.


      * Função para buscar um aluno pela matrícula 
       BUSCAR-ALUNO.
           DISPLAY " ".
           DISPLAY "=========================".
           DISPLAY " BUSCAR ALUNO".
           DISPLAY "=========================".
      *    Recebe a chave de busca
           DISPLAY "Informe a matrícula do aluno: " WITH NO ADVANCING.
           ACCEPT WS-BUSCA.

      *    Abre o arquivo
           OPEN INPUT ARQ-ALUNOS.
           
      *    PROCURAR PELA MATRICULA INFORMADA
           MOVE WS-BUSCA TO WS-CHAVE.

           READ ARQ-ALUNOS
             INVALID KEY
               DISPLAY "Aluno não encontrado!"
             NOT INVALID KEY
               DISPLAY "========================="
               DISPLAY " ALUNO ENCONTRADO"
               DISPLAY "========================="
               PERFORM EXIBIR-DADOS
           END-READ.

      *    Fecha arquivo
           CLOSE ARQ-ALUNOS.

           PERFORM MAIN.


      * Função que grava as informações no arquivo .dat
       GRAVAR.
           OPEN I-O ARQ-ALUNOS.

           WRITE DETALHAMENTO
             INVALID KEY
               DISPLAY "Erro ao gravar dados no arquivo!"
             NOT INVALID KEY
               DISPLAY "Sucesso! Dados gravados no arquivo!".
           
           CLOSE ARQ-ALUNOS.


      * Função para printar os dados no terminal
       EXIBIR-DADOS.
           DISPLAY "Matrícula: " MATRICULA.
           DISPLAY "Nome: " NOME.
           DISPLAY "Data de Nasc.: " DATA-NASC .
           DISPLAY "Curso: " CURSO .
           DISPLAY "Média (em 10.0): " MEDIA.
       