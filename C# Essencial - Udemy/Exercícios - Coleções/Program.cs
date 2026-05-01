using System;
using System.Collections;

public class Pessoa
{
    public string Nome { get; set; }
    public int Idade { get; set; }

    public void Exibir() => Console.WriteLine($"Nome: {Nome}, Idade: {Idade}");
}

class Program
{
    static void Main()
    {
        // Questão 01.

        // Inicialização do array
        string[] frutas = { "Maça", "Banana", "Laranja", "Uva", "Manga", "Pêra", "Abacate", "Mamão", "Pêssego", "Amora" };

        // a- Exibir nomes e quantidade usando for e foreach
        Console.WriteLine($"Quantidade de frutas: {frutas.Length}");
        Console.WriteLine("\n--- Usando For ---");
        for (int i = 0; i < frutas.Length; i++)
        {
            Console.Write($"{frutas[i]} ");
        }

        Console.WriteLine("\n\n--- Usando Foreach ---");
        foreach (var fruta in frutas)
        {
            Console.Write($"{fruta} ");
        }

        // b- Segunda e penúltima fruta
        Console.WriteLine($"\n\nSegunda fruta: {frutas[1]}");
        Console.WriteLine($"Penúltima fruta: {frutas[frutas.Length - 2]}");

        // c- Alterar nomes
        frutas[2] = "Kiwi"; // Terceira fruta
        frutas[frutas.Length - 1] = "Caqui"; // Última fruta
        Console.WriteLine("\nFrutas após alterações: " + string.Join(", ", frutas));

        // d- Ordenação ascendente
        Array.Sort(frutas);
        Console.WriteLine("\nOrdenação ascendente: " + string.Join(", ", frutas));

        // e- Ordem inversa
        Array.Reverse(frutas);
        Console.WriteLine("\nOrdem inversa: " + string.Join(", ", frutas));


        //Questão 02.
        Console.Write("Informe o número de valores do array: ");
        if (int.TryParse(Console.ReadLine(), out int tamanho))
        {
            int[] numeros = new int[tamanho];
            // Popular o array para teste (opcional, mas necessário para pesquisa)
            for (int i = 0; i < tamanho; i++) numeros[i] = i * 10;

            string input;
            do
            {
                Console.Write("\nDigite um valor para procurar (ou 'fim' para sair): ");
                input = Console.ReadLine();

                if (input.ToLower() != "fim")
                {
                    if (int.TryParse(input, out int busca))
                    {
                        bool existe = Array.Exists(numeros, x => x == busca);
                        Console.WriteLine(existe ? $"O número {busca} EXISTE no array." : "O número NÃO existe.");
                    }
                }
            } while (input.ToLower() != "fim");
        }

        //Questão 03.
        float[,] notas = new float[2, 5]; // 2 grupos, 5 alunos cada[cite: 11]

        for (int g = 0; g < 2; g++)
        {
            float soma = 0;
            Console.WriteLine($"\n--- Grupo {g + 1} ---");
            for (int a = 0; a < 5; a++)
            {
                Console.Write($"Nota do aluno {a + 1}: ");
                notas[g, a] = float.Parse(Console.ReadLine());
                soma += notas[g, a];
            }
            Console.WriteLine($"Média do Grupo {g + 1}: {soma / 5}");
        }

        //Questão 04.
        ArrayList pessoas = new ArrayList();

        // Dados iniciais[cite: 11]
        pessoas.Add(new Pessoa { Nome = "Ana", Idade = 22 });
        pessoas.Add(new Pessoa { Nome = "Diná", Idade = 21 });
        pessoas.Add(new Pessoa { Nome = "Maria", Idade = 19 });

        ExibirLista(pessoas, "Lista Inicial");

        // d- Incluir Jaime e Tânia[cite: 11]
        pessoas.Add(new Pessoa { Nome = "Jaime", Idade = 20 });
        pessoas.Add(new Pessoa { Nome = "Tânia", Idade = 18 });
        ExibirLista(pessoas, "Após Adição");

        // e- Remover último[cite: 11]
        pessoas.RemoveAt(pessoas.Count - 1);
        ExibirLista(pessoas, "Após Remover Último");
    }
    static void ExibirLista(ArrayList lista, string titulo)
    {
        Console.WriteLine($"\n--- {titulo} ---");
        foreach (Pessoa p in lista) p.Exibir();
    }
}
