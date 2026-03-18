// Aula 03 - Constantes

namespace Aula03;

public class Program
{
    public static void Main()
    {
        //Para adicionar constantes ao código utilizamos:
        const String name = "Maurício";
        Console.WriteLine(name);

        //Variável var (aceita qualquer tipo na primeira atribuição)
        var age = 18;
        Console.WriteLine(age);

        //Variável dinâmica (pode mudar de tipo durante o programa)
        dynamic teste;

        teste = "teste";
        Console.WriteLine(teste);

        teste = true;
        Console.WriteLine(teste);

    }
}