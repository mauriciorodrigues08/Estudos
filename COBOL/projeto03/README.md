# Sistema de Gestão de Estoque e Vendas em COBOL
Este projeto é um sistema transacional desenvolvido em **COBOL** para fins de estudo pessoal. Ele simula o controle de estoque de uma loja, permitindo o gerenciamento de produtos através de arquivos indexados e o processamento de vendas integrando arquivos sequenciais (CSV).

## Funcionalidades
* **Importação Automática:** Lê um arquivo `produtos.csv` e popula a base de dados indexada (`.idx`) no início da execução.
* **CRUD Completo de Produtos:**
    * Cadastro de novos produtos com validação de código.
    * Alteração de descrição, preço e estoque.
    * Listagem formatada com supressão de zeros e máscaras de moeda.
    * Exclusão lógica (impede a exclusão de produtos com saldo em estoque).
* **Módulo de Vendas:** * Realiza vendas individuais com baixa automática no estoque.
    * Geração de log de transações em formato CSV (`vendas-do-dia.csv`).
* **Processamento Batch:** * Lê o log de vendas do dia e gera um relatório consolidado de faturamento e total de vendas realizadas.

## Tecnologias e Conceitos Aplicados
* **Linguagem:** COBOL.
* **Arquivos Indexados (IDX):** Uso de `RECORD KEY` e `ACCESS MODE IS DYNAMIC` para buscas rápidas e manipulação de registros.
* **Arquivos Sequenciais:** Manipulação de arquivos `.csv` usando `LINE SEQUENTIAL`.
* **Modularização:** Divisão do sistema em subprogramas (`CALL ... USING`) para melhor manutenção e organização.
* **Tratamento de Erros:** Implementação de verificações de `FILE STATUS` (ex: erro 35 para arquivos inexistentes).
* **Manipulação de Strings:** Uso de `STRING`, `UNSTRING` e `FUNCTION TRIM`.

## Como Executar Localmente
Para rodar este projeto, é necessário ter um compilador COBOL instalado no seu ambiente, como o **GnuCOBOL**.
Após instalado o compilador, realize os passos abaixo:

```bash
  # Clone este repositório
  git clone https://github.com/mauriciorodrigues08/Estudos/tree/main/COBOL/projeto03

  # Acesse o diretório do projeto
  cd seu-repositorio

  # Utilize o comando do arquivo Makefile para compilar e executar o programa
  make run
