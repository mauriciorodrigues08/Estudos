// Aula 04 - Entrada e Saída de Dados
namespace Aula04;

public class Program
{
    public static void Main()
    {
        //Solicita nome do Usuário
        Console.WriteLine("Informe seu nome:");
        String name = Console.ReadLine();

        //Solicita idade do Usuário
        Console.WriteLine("Informe sua idade:");
        int age = Convert.ToInt32(Console.ReadLine());

        //Printa mensagem de resultado
        Console.WriteLine("\nNome do Usuário: " + name + "\nIdade do Usuário: " + age);

    }
}
