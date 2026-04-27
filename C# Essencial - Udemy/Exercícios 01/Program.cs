using System.Runtime.Intrinsics.X86;

Console.WriteLine("# EXERCÍCIOS 01 #");

//1 - Crie uma variável chamada idade e atribua a ela o valor 35 e exiba o seu valor.
Console.WriteLine();
int idade = 35;
Console.WriteLine($"Idade: {idade}");

//2- Crie uma variável chamada nome e atribua o valor "Maria" e exiba o seu valor.
Console.WriteLine();
string nome = "Maria";
Console.WriteLine($"Nome: {nome}");

//3- Crie uma variável chamada altura e atribua a ela o valor 3.45.
Console.WriteLine();
double altura = 3.45;
Console.WriteLine($"Altura: {altura}");

//4- Crie uma variável chamada data e atribua a ela a data 04/09/1999 e exiba o seu valor.
Console.WriteLine();
DateTime data = new DateTime(1999, 09, 04);
Console.WriteLine($"Data: {data}");

//5- Crie uma constante chamada ano e atribua a ela o valor 12 e exiba o seu valor;
Console.WriteLine();
const int ano = 12;
Console.WriteLine($"Ano: {ano}");

//6- Declare uma variável nota do tipo double como sendo do tipo Nullable type e atribua valor 7.80 e exiba o seu valor.
Console.WriteLine();
double? nota = 7.8;
if (nota.HasValue)
{
    Console.WriteLine($"Valor: {nota.Value}");
}
else
{
    Console.WriteLine("Nota não possui um valor");
}

//7- Quais as diferenças entre os tipos por valor e os tipos por referência ?
Console.WriteLine();
Console.WriteLine("A diferença entre os tipos por valor e os tipos por referência é que, nos tipos por valor, a variável é armazenada na memória Stack, e guarda diretamente o valor da variável.");
Console.WriteLine("Já no tipo por referência, são armazenados na memória Heap, além de que são armazenados referências para a posição de memória em que o conteúdo se encontra.");

//8- Inclua o tipo de dados correto entre os parênteses nas seguintes declarações de variáveis:
Console.WriteLine();
Console.WriteLine("Declarar tipo de variáveis");
Console.WriteLine("(int) x = 10");
Console.WriteLine("(double) numero = 7.99");
Console.WriteLine("(char) letra = 'C'");
Console.WriteLine("(float) temperatura = 27.4f");
Console.WriteLine("(bool) ativo = false");
Console.WriteLine("(char) nome = 'Manoel'");
Console.WriteLine("(decimal) salario = 950.99m");
Console.WriteLine("(DateTime) hoje = DateTime.Now");

//9- Dada as variáveis declaradas a seguir classifique-as em tipos por valor(V) e tipos por referência (R) :
Console.WriteLine();
Console.WriteLine("Classificar variáveis em Valor ou Referência");
Console.WriteLine("(V) int n = 1;");
Console.WriteLine("(R) string titulo = 'A vida';");
Console.WriteLine("(V) float f = 12.45f;");
Console.WriteLine("(V) double d = 5.45;");
Console.WriteLine("(V) decimal valor = 10.99m;");
Console.WriteLine("(V) char sexo = ‘M’;");
Console.WriteLine("(R) object o = null;");

//10- O que é um nullable type e qual a sua utilidade ?
Console.WriteLine();
Console.WriteLine("Um tipo nullable é um tipo de dados que pode não conter valores, ou seja, valer NULL.");

//11- O que é Camel Case ? Dê um exemplo de sua aplicação.
Console.WriteLine();
Console.WriteLine("Camel Case é o tipo de escrita que é feito com a primeira letra minúscula e todas as outras palavras começando com maiúscula.");
Console.WriteLine("Um exemplo é uma variável com nome 'donoDaConta'.");

//12- O que é Pascal Case ? Dê um exemplo de sua aplicação.
Console.WriteLine("Pascal Case é o tipo de escrita que é feito com a primeira letra de todas as palavras começando com maiúscula.");
Console.WriteLine("Um exemplo é uma classe de nome 'ContaBancaria'.");

//13- Declare duas variáveis x e y como sendo do tipo int e atribua a ela os valores 77 e 66 e seguir imprima o valor da soma de x com y. (Use o operador aritmético + para realizar operação de soma)
Console.WriteLine();
int x=77, y=66;
Console.WriteLine($"Soma de x + y = {x+y}");

//14- Quais os valores padrões dos tipos de dados bool, char, int, double, float, decimal string.
Console.WriteLine();
Console.WriteLine("Valores padrão dos tipos");
Console.WriteLine("Bool: False");
Console.WriteLine("Char: \\0");
Console.WriteLine("Int: 0");
Console.WriteLine("Float: 0");
Console.WriteLine("Decimal: 0");
Console.WriteLine("String: null");

//15- Indique verdadeiro(V) ou falso (F) para as seguintes declarações de considerando a nomenclatura usada:
Console.WriteLine();
Console.WriteLine("Declaração Verdadeira ou Falsa");
Console.WriteLine("(F) double 1valor = 12.45");
Console.WriteLine("(F) string #nome = 'Pedro'");
Console.WriteLine("(V) float _temperatura = 12.45f");
Console.WriteLine("(F) double int = 5");
Console.WriteLine("(F) decimal renda extra = 91.45m");
Console.WriteLine("(F) bool status$conta = false");
Console.WriteLine("(V) string titulo3 = “Tópico 1”");
Console.WriteLine("(V) float salario_mensal = 1999.55f");
Console.WriteLine("(V) int percentualValorDesconto = 5");
Console.WriteLine("(V) const bool MENSALIDADE_EM_DIA = true");
