// Aula 15 - foreach

namespace Aula15;

public class Program
{
    public static void Main()
    {
        //Recomendado para repetições em listas

        List<int> numberList = new List<int>() {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

        int i = 1;
        foreach (int n in numberList)
        {
            Console.WriteLine("Número " + i + ": " + n);
            i++;
        }
    }
}