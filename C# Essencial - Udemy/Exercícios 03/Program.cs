using System.Runtime.Intrinsics.X86;

Console.WriteLine("# EXERCÍCIOS 03 #");

//1- Escreva um programa para receber 3 números inteiros e a seguir calcular e exibir qual deles é o maior
Console.WriteLine("Verificar maior...");
int n1, n2, n3;
Console.Write("Primeiro Número: ");
n1 = Convert.ToInt32(Console.ReadLine());
Console.Write("Segundo Número: ");
n2 = Convert.ToInt32(Console.ReadLine());
Console.Write("Terceiro Número: ");
n3 = Convert.ToInt32(Console.ReadLine());

int maior = n1;
if (n2 > maior)
{
    maior = n2;
}

if (n3 > maior)
{
    maior = n3;
}

Console.WriteLine($"O maior número digitado foi {maior}\n");

//2 - Escreva um programa para calcular a raiz da equação quadrática :
//- Para calcular as raízes use a fórmula de Báskara : onde
//- Considere a, b e c números inteiros (positivos, negativos e o zero)
//- Solicite a entrada de a , b e c e informe se existe ou não raiz real
Console.WriteLine("Bhaskara...");
int a, b, c;
double delta, x1, x2;
Console.Write("Insira o valor de A: ");
a =  Convert.ToInt32(Console.ReadLine());
Console.Write("Insira o valor de B: ");
b = Convert.ToInt32(Console.ReadLine());
Console.Write("Insira o valor de C: ");
c = Convert.ToInt32(Console.ReadLine());

delta = Math.Pow(b, 2) - (4 * a * c);
x1 = (-b + Math.Sqrt(delta)) / (2 * a);
x2 = (-b - Math.Sqrt(delta)) / (2 * a);
Console.WriteLine($"Delta = {delta}");
if (delta >= 0)
{
    Console.WriteLine($"x'  = {x1}");
    Console.WriteLine($"x'' = {x2}\n");
}
else
{
    Console.WriteLine("Não possui raízes reais\n");
}

//3- Escreva um programa para exibir os 10 primeiros números naturais e calcular a sua soma
int soma = 0;
Console.WriteLine("Soma dos primeiros 10 naturais...");
for (int i = 1; i <= 10; i++) soma += i;

Console.WriteLine($"Resultado = {soma}\n");

//4- Escreva um programa para exibir a tabela de multiplicação de um número natural maior que zero
//recebido via teclado
//- Verifique se o número é maior que zero e emita uma mensagem
//- Considere a tabela de multiplicação de 1 até 10
//- Após exibir a tabela torne a solicitar outro número
//- Para sair do loop defina uma condição de saída
Console.WriteLine("Tabela de multiplicação...");
int v = 0;
while (v != -1)
{
    Console.Write("Digite um número natural (-1 p/ sair): ");
    v =  Convert.ToInt32(Console.ReadLine());
    if (v == -1) break;

    if (v < 0)
    {
        Console.WriteLine("Valor negativo!\n");
    }
    else
    {
        for (int i = 1; i <= 10; i++)
        {
            Console.WriteLine($"{v} x {i} = {v * i}");
        }
        Console.WriteLine();
    }
}

//6- Crie um programa para exbir no console os números pares de 10 a 20, ambos incluídos, exceto 16
Console.WriteLine("Pares de 10 a 20 exceto 16...");
for(int i = 10; i <= 20; i+=2)
{
    if (i != 16) Console.WriteLine(i);
}
Console.WriteLine();

//7- Escreva um programa para exibir o padrão como triângulo de ângulo reto usando asterisco (*)
Console.WriteLine("Triângulo de asteriscos...");
for (int i = 0;  i < 5; i++)
{
    for (int j = 0; j < i; j++)
    {
        Console.Write("*");
    }
    Console.WriteLine();
}
Console.WriteLine();

//8-Escreva um programa para calcular o fatorial de um número inteiro.
//O fatorial de um número é representado por : n! => n * (n – 1) *(n – 2) ....2 * 1
Console.WriteLine("Fatorial...");
Console.Write("Informe um valor: ");
int n = Convert.ToInt32(Console.ReadLine());
int fat = 1;
for (int i = 0; i < n; i++)
{   
    fat *= n - i;
}
Console.WriteLine($"Fatorial de {n} = {fat}");

//9- Escreva um programa para exibir as tabelas de multiplicação do 2 ao 6 usando o loop do-while aninhado