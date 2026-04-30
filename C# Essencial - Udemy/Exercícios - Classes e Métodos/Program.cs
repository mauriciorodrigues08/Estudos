class Program
{
    static void Main(string[] args)
    {
        // --- Testes Carro ---
        Carro chevrolet = new Carro("Sedan", "Chevrolet", "Onix", 2016, 110, (int)Cores.Branco);
        Carro ford = new Carro("SUV", "Ford", "EcoSport", 2018, 120, (int)Cores.Preto);

        chevrolet.ExibirInfo(chevrolet.Modelo, chevrolet.Montadora, chevrolet.Marca, chevrolet.Potencia, chevrolet.Ano);
        chevrolet.Acelerar(chevrolet.Marca);

        // Teste Potência (Valor vs Referência)
        int pot = 100;
        Console.WriteLine($"\nOriginal: {pot}");
        Console.WriteLine($"Por valor: {chevrolet.AumentarPotencia(pot)} | Após: {pot}");
        Console.WriteLine($"Por ref: {chevrolet.AumentarPotencia(ref pot)} | Após: {pot}\n");

        // Teste Parâmetro Out
        double novaVel;
        int novaPot = chevrolet.AumentarPotenciaVelocidade(pot, out novaVel);
        Console.WriteLine($"\nTeste do parâmetro out");
        Console.WriteLine($"Nova Potência: {novaPot}\nNova Vel: {novaVel}\n");

        // --- Testes Struct Cliente ---
        Cliente novoCliente = new Cliente("Maria", "maria@email.com", 15); // Deve validar para 18
        Cliente.ExibirInfo(nome: novoCliente.Nome, email: novoCliente.Email, idade: novoCliente.Idade);
    }
}