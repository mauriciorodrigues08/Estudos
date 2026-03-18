// Aula 09 -  Operadores Lógicos

namespace Aula09;

public class Program
{
    public static void Main()
    {

        Console.WriteLine("=======Operadores Lógicos========");

        bool isLogged = true;
        bool hasAdminAcces = false;

        Console.WriteLine("\nInformações do Usuário:");
        Console.WriteLine("Usuário logado: " + isLogged);
        Console.WriteLine("Acesso ao painel de administrador: " + hasAdminAcces);

        Console.WriteLine("\nPermissões:");

        //Operador (||) - OR
        if (isLogged || hasAdminAcces)
        {
            Console.WriteLine("Acesso ao sistema concedido");
        }
        else
        {
            Console.WriteLine("Acesso ao sistema negado");
        }


        //Operador (&&) - AND
        if (isLogged && hasAdminAcces)
        {
            Console.WriteLine("Acesso ao painel de administrador concedido");
        }
        else
        {
            Console.WriteLine("Acesso ao painel de administrador negado");
        }

        //Operador (!) - NOT
        if (!isLogged)
        {
            Console.WriteLine("Usuário não está logado");
        }
        else
        {
            Console.WriteLine("Usuário está logado");
        }


    }
}