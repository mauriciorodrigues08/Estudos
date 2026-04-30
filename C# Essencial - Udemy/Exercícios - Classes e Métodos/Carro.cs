public class Carro
{
    // Atributos e Propriedades
    public string Modelo;
    public string Montadora;
    public string Marca;
    public int Potencia;
    public int Cor;

    private int ano;
    public int Ano
    {
        get => ano;
        set
        {
            if (value < 2000) ano = 2000;
            else if (value > 2022) ano = 2022;
            else ano = value;
        }
    }

    public static double ValorIpva;

    // Construtores
    public Carro(string modelo, string montadora, string marca, int ano, int potencia, int cor)
    {
        this.Modelo = modelo;
        this.Montadora = montadora;
        this.Marca = marca;
        this.Ano = ano;
        this.Potencia = potencia;
        this.Cor = cor;

        // Exercício 10: Inicializando o campo estático no construtor de instância
        Carro.ValorIpva = 4.0;
    }

    public Carro(string modelo, string montadora)
    {
        Modelo = modelo;
        Montadora = montadora;
        // Comportamento: Os demais campos assumem valores padrão (null para string, 0 para int)
    }

    // Métodos
    public void Acelerar(string marca)
    {
        Console.WriteLine($"Acelerando o meu {marca}...");
    }

    public double VelocidadeMaxima(int potencia)
    {
        return potencia * 1.75;
    }

    // Passagem por Valor
    public int AumentarPotencia(int potencia)
    {
        return potencia += 3;
    }

    // Sobrecarga: Passagem por Referência
    public int AumentarPotencia(ref int potencia)
    {
        return potencia += 5;
    }

    // Uso de parâmetro out
    public int AumentarPotenciaVelocidade(int potencia, out double velocidade)
    {
        int novaPotencia = potencia + 7;
        velocidade = novaPotencia * 1.75;
        return novaPotencia;
    }

    public void ExibirInfo(string modelo, string montadora, string marca, int potencia, int ano = 2000, int cor = 1)
    {
        Console.WriteLine($"Carro: {marca}\nModelo: {modelo}\nMontadora: {montadora}\nAno: {ano}\nPotência: {potencia}CV\nCor: {(Cores)cor}\n");
    }

    public static void ObterValorIPVA()
    {
        ValorIpva = 4.0;
    }
}