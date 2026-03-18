// Aula 18 - Arquivos

namespace Aula18;
using System.IO;

public class Program
{
    public static void Main()
    {

        //1. Criar um arquivo
        string path = @"C:\Users\mauri\OneDrive\Documentos\GitHub\Estudos\C# e .NET\Aula18\";
        string fileName = "Text.txt";
        string filePath = path + fileName;
        string content = "Hello World!";

        File.WriteAllText(filePath, content);
        Console.WriteLine("Arquivo criado com sucesso!");
        string lixo = Console.ReadLine();
        

        //2. Inserir um parágrafo em um arquivo
        string additionalContent = " | Curso de C# e .NET";
        File.AppendAllText(filePath, additionalContent);

        Console.WriteLine("Arquivo Atualizado com sucesso!");
        lixo = Console.ReadLine();

        //3. Ler um arquivo
        string fileContent = File.ReadAllText(filePath);
        Console.WriteLine("Conteúdo do Arquivo:");
        Console.WriteLine(fileContent);
    }
}