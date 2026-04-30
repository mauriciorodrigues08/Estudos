using System;

Console.WriteLine("## EXERCÍCIO PRÁTICO: CLASSES E MÉTODOS ##\n");

// --- Itens a, b, c ---
// Criando instâncias de Carro usando a atribuição manual de atributos (antes do construtor)
Carro chevrolet = new Carro();
chevrolet.Modelo = "Sedan";
chevrolet.Montadora = "Chevrolet";
chevrolet.Marca = "Onix";
chevrolet.Ano = 2016;
chevrolet.Potencia = 110;

Carro ford = new Carro();
ford.Modelo = "SUV";
ford.Montadora = "Ford";
ford.Marca = "EcoSport";
ford.Ano = 2018;
ford.Potencia = 120;

Console.WriteLine("--- Dados do Objeto Chevrolet ---");
Console.WriteLine($"Modelo: {chevrolet.Modelo}, Montadora: {chevrolet.Montadora}, Marca: {chevrolet.Marca}, Ano: {chevrolet.Ano}, Potência: {chevrolet.Potencia} CV");
chevrolet.Acelerar(chevrolet.Marca);

Console.WriteLine("\n--- Dados do Objeto Ford ---");
Console.WriteLine($"Modelo: {ford.Modelo}, Montadora: {ford.Montadora}, Marca: {ford.Marca}, Ano: {ford.Ano}, Potência: {ford.Potencia} CV");
ford.Acelerar(ford.Marca);

// --- Itens e, f ---
Console.WriteLine("\n--- Criando objetos via Construtor ---");
Carro carro1 = new Carro("Sedan", "Chevrolet", "Onix", 2016, 110);
Carro carro2 = new Carro("SUV", "Ford", "EcoSport", 2018, 120);

carro1.Acelerar(carro1.Marca);
carro2.Acelerar(carro2.Marca);

// Definição da Classe Carro
public class Carro
{
    // Atributos (campos/propriedades)
    public string Modelo;
    public string Montadora;
    public string Marca;
    public int Ano;
    public int Potencia;

    // Construtor (Item e)
    public Carro(string modelo, string montadora, string marca, int ano, int potencia)
    {
        this.Modelo = modelo;
        this.Montadora = montadora;
        this.Marca = marca;
        this.Ano = ano;
        this.Potencia = potencia;
    }

    // Sobrecarga de construtor vazio para permitir a criação manual dos primeiros itens
    public Carro() { }

    // Método Acelerar (Itens d e f)
    public void Acelerar(string marca)
    {
        Console.WriteLine($"Acelerando o meu {marca}...");
    }
}