// CarroEnum.cs
public enum Cores
{
    Branco = 1,
    Vermelho,
    Preto,
    Cinza,
    Prata,
    Azul
}

// Struct Cliente
public struct Cliente
{
    public string Nome;
    public string Email;
    private int idade;

    public int Idade
    {
        get => idade;
        set => idade = value < 18 ? 18 : value; // Validação: mínimo 18 anos
    }

    public Cliente(string nome, string email, int idade)
    {
        Nome = nome;
        Email = email;
        this.idade = 0; // Inicialização obrigatória em struct
        Idade = idade;
    }

    public static void ExibirInfo(string nome, string email, int idade = 18)
    {
        Console.WriteLine($"Cliente: {nome}\nEmail: {email}\nIdade: {idade}\n");
    }
}