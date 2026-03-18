// Aula 02 - Variáveis

namespace Aula02;

public class Program
{
    public static void Main()
    {
        // Tipos em C#
        String name = "Maurício";
        int age = 21;
        double heigt = 1.88;
        char gender = 'M';
        bool isRunning = true;

        //Testando os tipos
        Console.WriteLine("Programa está rodando? " + isRunning);
        Console.WriteLine("Nome: " + name + "\nIdade: " + age + "\nAltura: " + heigt + "\nGênero: " + gender);
    }
}