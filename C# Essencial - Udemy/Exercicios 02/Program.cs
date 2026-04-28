using Microsoft.VisualBasic;
using System.Threading.Channels;

Console.WriteLine("# EXERCÍCIOS 02 #");

//1- Declare as variáveis nome, idade e nota atribuindo os valores “Paulo”, 17 e 7.5 e exiba a saída no formato :
//Aluno <nome> tem <idade> anos e nota <nota> usando a concatenação e a interpolação de strings
string nome = "Paulo";
int idade = 17;
double nota = 7.5;

Console.WriteLine($"\nAluno {nome} tem {idade} anos e nota {nota}\n");

//2- Para o exercício anterior exiba o nome a idade e a nota em linhas separadas usando as sequências de
//escapes.
Console.WriteLine($"Aluno: {nome}\nIdade: {idade}\nNota: {nota}\n");

//3-Para qual tipo de dados você pode converter um float implicitamente ?
Console.WriteLine("Para qual tipo de dados você pode converter um float implicitamente ?");
Console.WriteLine("( ) int");
Console.WriteLine("(X) double");
Console.WriteLine("( ) long");
Console.WriteLine("( ) decimal\n");

//4- Em qual conversão numérica você precisaria realizar o casting (convesão forçada) ?
Console.WriteLine("Em qual conversão numérica você precisaria realizar o casting (convesão forçada) ?");
Console.WriteLine("( ) int para long");
Console.WriteLine("(X) double para long");
Console.WriteLine("( ) double para float");
Console.WriteLine("( ) decimal para float");
Console.WriteLine("( ) long para int");
Console.WriteLine("( ) double para decimal\n");

//5- Escreva um programa que recebe 3 letras via teclado e as exiba na ordem reversa usando
//a concatenação e também a interpolação de strings
char l1, l2, l3;

Console.WriteLine("Inversão de letras...");
Console.Write("Digite uma letra: ");
l1 = Convert.ToChar(Console.ReadLine());

Console.Write("Digite uma letra: ");
l2 = Convert.ToChar(Console.ReadLine());

Console.Write("Digite uma letra: ");
l3 = Convert.ToChar(Console.ReadLine());

Console.WriteLine($"Resultado: "+ l3 + l2 + l1);

//6- Marque verdadeiro(V) ou falso(F) para os códigos abaixo:
Console.WriteLine("\nMarque verdadeiro(V) ou falso(F) para os códigos abaixo:");
Console.WriteLine("(F) long resultado = 1.32;");
Console.WriteLine("(V) var nome = “Maria”;");
Console.WriteLine("(V) string resultado = 100.ToString();");
Console.WriteLine("(V) A sequência de escape \\n inclui uma nova linha");
Console.WriteLine("(F) float f = 5.45;");
Console.WriteLine("(V) decimal valor = (decimal) 10.99f;");
Console.WriteLine("(F) var status = null;");
Console.WriteLine("(V) object o = 12.45m;");
Console.WriteLine("(V) string titulo = true.ToString();");
Console.WriteLine("(F) A sequencia \\t inclui uma tabulação vertical\n");

//7- Escreva um programa para receber dois valores via teclado do tipo double e a seguir
//realize as operações de soma, subtração, multiplicação, exponenciação, divisão e módulo
//exibindo o resultado:
Console.WriteLine("Operações...");
Console.Write("Digte o primeiro valor: ");
double v1 = Convert.ToDouble(Console.ReadLine());

Console.Write("Digte o segundo valor: ");
double v2 = Convert.ToDouble(Console.ReadLine());

Console.WriteLine("Resultado:");
Console.WriteLine($"{v1} + {v2} = {v1+v2}");
Console.WriteLine($"{v1} - {v2} = {v1-v2}");
Console.WriteLine($"{v1} * {v2} = {v1*v2}");
Console.WriteLine($"{v1} ^ {v2} = {Math.Pow(v1, v2)}");
Console.WriteLine($"{v1} / {v2} = {v1/v2}");
Console.WriteLine($"{v1} % {v2} = {v1%v2}\n");

//8 - Faça um programa para calcular o resultado da fórmula de baskara dados os valores a b e c . 
Console.WriteLine("Bhaskara...");
Console.Write("Digte o valor de A: ");
int a = Convert.ToInt32(Console.ReadLine());

Console.Write("Digte o valor de B: ");
int b = Convert.ToInt32(Console.ReadLine());

Console.Write("Digte o valor de C: ");
int c = Convert.ToInt32(Console.ReadLine());

double delta = Math.Pow(b, 2) - (4 * a * c);

double bask1 = (-b + Math.Sqrt(delta)) / (2*a);
double bask2 = (-b - Math.Sqrt(delta)) / (2*a);

Console.WriteLine($"Delta = {delta}");
Console.WriteLine($"x'  = {bask1}");
Console.WriteLine($"x'' = {bask2}\n");

//9- Escreva um programa que receba um nome e uma senha via teclado. Nome é uma string e
//Senha é um inteiro. Se o nome for igual a ‘admin’ ou ‘maria’ e a senha for igual a ‘123’
//então exiba a mensagem ‘Login feito com sucesso’ caso contrário exiba a mensagem ‘Login
//inválido’:
Console.WriteLine("Login...");
Console.Write("Nome: ");
string usuario = Console.ReadLine();
Console.Write("Senha: ");
int senha = Convert.ToInt32(Console.ReadLine());

if ((usuario == "admin" || usuario == "maria") && senha == 123)
{
    Console.WriteLine("Login feito com sucesso!\n");
}
else
{
    Console.WriteLine("Login inválido!\n");
}

//10- Indique verdadeiro(V) ou falso (F) para as seguintes declarações de variáveis considerando a nomenclatura usada:
Console.WriteLine("10- Indique verdadeiro(V) ou falso (F) para as seguintes declarações de variáveis considerando a nomenclatura usada:");
Console.WriteLine("(V) string? nome; é um exemplo de nullable reference type;");
Console.WriteLine("(F) para x igual a 0 , Console.WriteLine(x++); imprime o valor 1");
Console.WriteLine("(F) A ordem de precedência dos operadores lógicos é : ! , || e && (NOT, OR e AND)");
Console.WriteLine("(F) para y igual a 0 , Console.WriteLine(++y); imprime o valor 1");
Console.WriteLine("(F) (10 % 2 == 0) ? “Par” : “Impar”; Vai retornar “Impar”");
Console.WriteLine("(F) Para x=25 e y=5 , a expressão ( y >= x ) && ( y <= x ); retorna true;");
Console.WriteLine("(F) Os nullable reference types emitem um alerta em tempo de compilação para uso do null");
Console.WriteLine("(F) Para x = 10 , o código Console.WriteLine(x+=x); imprime o valor 10;");
Console.WriteLine("(F) Para x= 5 , a expressão !(9 >= x) && x <= 7 || x == 5); retorna false;");
Console.WriteLine("(V) O operador ?. permite verificar se um objeto é null e evitar o NullReferenceException");
Console.WriteLine("(F) Qualquer tipo de dado pode ser declarado como anulável com a ajuda do operador? \n");

//11- Escreva um programa que recebe via teclado dois números inteiros x e y e imprima no
//console se x é par ou não e se y é par ou não.
Console.WriteLine("Par ou impar...");
Console.Write("Digite um valor: ");
int v = Convert.ToInt32(Console.ReadLine());
Console.WriteLine((v%2==0) ? $"{v} é par\n": $"{v} é ímpar\n");

Console.Write("Digite outro valor: ");
v = Convert.ToInt32(Console.ReadLine());
Console.WriteLine((v%2==0) ? $"{v} é par\n": $"{v} é ímpar\n");


//12- Crie um programa que receba um numero inteiro x via teclado e calcule e imprima no
//console o resultado das seguintes operações : (x^2 -> x ao quadrado) (pi = 3.1415)
//-6 + x * 5
//(13-2) * x
//(x + -2) * (20 / x)
//(12 + x) / (x - 4)
//3 x^2 + x + 10
//pi * x^2
const double pi = 3.1415;
Console.WriteLine("Contas...");
Console.Write("Digite um inteiro x: ");
v = Convert.ToInt32((Console.ReadLine()));
Console.WriteLine("-6 + x * 5 = " + (-6 + v * 5));
Console.WriteLine("(13-2) * x = " + ((13 - 2) * v));
Console.WriteLine("(x + -2) * (20 / x) = " + ((v + -2) * (20 / v)));
Console.WriteLine("(12 + x) / (x - 4) = " + ((12 + v) / (v - 4)));
Console.WriteLine("3 * x^2 + x + 10 = " + (3 * Math.Pow(v,2) + v + 10));
Console.WriteLine("pi * x^2 = " + (pi * Math.Pow(v,2)) + "\n");

//13- Considere o seguinte trecho de código:
Console.WriteLine("Teste de contas (y=5):");
int y = 5 ;
Console.WriteLine("y = (y++) + y + (++y) -> " + ((y++) + y + (++y)));
y = 5;
Console.WriteLine("y = y++ + y + ++y     -> " + (y++ + y + ++y));
Console.WriteLine();

//14- Escreva um programa que solicite a temperatura em graus Celsius e converta para
//Kelvin e Farhenheit usando as fórmulas a seguir:
//- Converter para Kelvin => K = C + 273 ;
//- Converter para Farhenheit => F = (C * 9) / 5 + 32 ;
Console.WriteLine("Conversão de temp...");
Console.Write("Insira a temperatura em ºC: ");
double temp = Convert.ToDouble(Console.ReadLine());
Console.WriteLine("Temperatura em K: " + (temp + 273));
Console.WriteLine("Temperatura em ºF: " + ((temp*9) / 5 + 32));
Console.WriteLine();

//15 - Escolha a opção que representa a exibição do resultado para o código usando os
//operadores de decremento e incremento (pré e pós) :
Console.WriteLine("Escolha a opção que representa a exibição do resultado para o código usando os operadores de decremento e incremento (pré e pós)");
Console.WriteLine("var numero = 5;");
Console.WriteLine("Console.WriteLine(numero++);");
Console.WriteLine("numero = 1;");
Console.WriteLine("Console.WriteLine(++numero);");
Console.WriteLine("numero = 2;");
Console.WriteLine("Console.WriteLine(numero--);");
Console.WriteLine("numero = 3;");
Console.WriteLine("Console.WriteLine(--numero);");
Console.WriteLine("(x) 5 2 2 2");
Console.WriteLine("( ) 6 3 2 2");
Console.WriteLine("( ) 5 2 1 2");
Console.WriteLine("( ) 6 2 1 3");
