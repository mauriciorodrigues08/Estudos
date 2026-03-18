// Aula 05 - Operadores Aritméticos

namespace Aula05
{
    public class Program
    {
        public static void Main()
        {
            Console.WriteLine("========== Calculadora Simples =========");
            Console.WriteLine("Digite o primeiro número: ");
            int number1 = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("Digite o segundo número: ");
            int number2 = Convert.ToInt32(Console.ReadLine());

            int sum = number1 + number2;
            int subtraction = number1 - number2;
            int multiplication = number1 * number2;
            int division = number1 / number2;
            int module = number1 % number2;

            Console.WriteLine("O valor da soma é: " + sum);
            Console.WriteLine("O valor da subtração é: " + subtraction);
            Console.WriteLine("O valor da multiplicação é: " + multiplication);
            Console.WriteLine("O valor da divisão é: " + division);
            Console.WriteLine("O resto da divisão é: " + module);
            Console.WriteLine("========================================");
        }
    }
}