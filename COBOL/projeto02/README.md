# Gestão de Alunos - CRUD em COBOL

Sistema de gerenciamento de alunos desenvolvido em **COBOL**. Este projeto realiza operações completas de CRUD (Create, Read, Update, Delete) utilizando arquivos indexados (`.idx`), simulando rotinas comuns de sistemas corporativos e transacionais.

## Propósito do Projeto
Projeto prático desenvolvido para consolidar os estudos sobre a estrutura e sintaxe da linguagem COBOL, bem como a manipulação de dados persistentes. A construção deste sistema permitiu explorar na prática conceitos de lógica, controle de fluxo e I/O de arquivos.

## Funcionalidades
- **Cadastrar Aluno:** Validação e inserção de novos registros contendo Matrícula, Nome, Curso e Data de Entrada.
- **Editar Aluno:** Busca otimizada através da chave indexada (Matrícula) para atualização dos dados cadastrais.
- **Listar Alunos:** Leitura sequencial de todos os registros armazenados no arquivo `.idx`.
- **Excluir Aluno:** Deleção de registros específicos com etapa de confirmação de segurança.

## Tecnologias e Estruturas Aplicadas
- **Linguagem:** COBOL
- **Armazenamento:** Arquivos Indexados (`ORGANIZATION IS INDEXED`, `ACCESS MODE IS DYNAMIC`)
- **Estruturas de Controle:** Uso de `PERFORM UNTIL` para laços de repetição e `EVALUATE` para menus de seleção.
- **Tratamento de Exceções e I/O:** - Verificação de `FILE STATUS` (ex: tratamento do status `35` para criação automática do arquivo caso não exista).
  - Utilização de `INVALID KEY` e `NOT INVALID KEY` para garantir a integridade nas buscas e gravações.

## Como Executar Localmente
Para rodar este projeto, é necessário ter um compilador COBOL instalado no seu ambiente, como o **GnuCOBOL**.

```bash
  # Clone este repositório
  git clone [https://github.com/seu-usuario/seu-repositorio.git](https://github.com/seu-usuario/seu-repositorio.git)

  # Acesse o diretório do projeto
  cd seu-repositorio

  # Compile o código fonte (ajuste o nome do arquivo conforme salvo no repositório)
  cobc -x gestao-alunos.cbl

  # Execute o programa gerado
  ./gestao-alunos