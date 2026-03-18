//Aula 06 - if..else

namespace Aula06;

public class Program
{
    public static void Main()
    {
        Console.WriteLine("============= Verifica Par ou Ímpar =========");
        Console.WriteLine("Digite um número: ");
        int number = Convert.ToInt32(Console.ReadLine());

        int result = number % 2;

        if (result == 0)
        {
            Console.WriteLine("O número digitado é par!");
        }
        else
        {
            Console.WriteLine("O número é ímpar!");
        }
    }
}