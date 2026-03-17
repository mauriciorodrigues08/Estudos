# Importador de Dados (CSV para IDX) - COBOL
Sistema de importação de dados desenvolvido em **COBOL**. Este projeto simula uma rotina de processamento *batch*, lendo informações de um arquivo texto delimitado (`.csv`) e migrando-os para uma base de dados estruturada em formato de arquivo indexado (`.idx`).

## Propósito do Projeto
Este projeto foi construído para aprofundar os conhecimentos em manipulação de arquivos sequenciais e indexados em COBOL. Ele simula rotinas corporativas de ETL (Extract, Transform, Load) e integração de sistemas legados, cenários extremamente comuns em instituições financeiras e grandes corporações.

## Funcionalidades
- **Leitura Sequencial:** Processamento linha a linha de um arquivo `.csv` de entrada (`ORGANIZATION IS LINE SEQUENTIAL`).
- **Tratamento de Strings:** Uso da função `TRIM` para higienização dos dados e do comando `UNSTRING` para separação dos campos baseados no delimitador ponto e vírgula (`;`).
- **Carga de Dados:** Inserção dos registros no arquivo indexado de destino (`.idx`), gerando a chave primária de busca (Matrícula).
- **Log de Processamento:** Exibição em tela dos registros importados com sucesso e contagem total do lote processado.

## Tecnologias e Estruturas Aplicadas
- **Linguagem:** COBOL
- **Armazenamento de Origem:** Arquivo Texto Delimitado (`.csv`)
- **Armazenamento de Destino:** Arquivo Indexado (`.idx`)
- **Manipulação de Dados:** `UNSTRING`, `FUNCTION TRIM`
- **Controle de Fluxo:** `PERFORM UNTIL` iterando sobre o controle de *End Of File* (`AT END`).

## Como Executar Localmente
Para rodar este projeto, é necessário ter um compilador COBOL instalado no seu ambiente, como o **GnuCOBOL**. Certifique-se também de criar um arquivo chamado `alunos.csv` no mesmo diretório antes de rodar, com dados separados por ponto e vírgula (ex: `12345678;Joao Silva;Ciencia da Computacao;2025-01-01`).

Se quiser, pode utilizar o próprio arquivo CSV do repositório ou alterá-lo, adicionando mais linhas de informação.

Recomendo a exclusão do arquivo `alunos.idx` ao clonar o repositório, para que fique explícito a criação do arquivo quando ele ainda não existe no repositório.

```bash
  # Clone este repositório
  git clone https://github.com/mauriciorodrigues08/Estudos/tree/main/COBOL/projeto01

  # Acesse o diretório do projeto
  cd seu-repositorio

  # Compile o código fonte
  cobc -x -free importa-alunos.cbl

  # Execute o programa gerado
  ./importa-alunos