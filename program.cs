using System;
using System.Threading.Tasks;
// add new line for main --- IGNORE ---

// add new line for feature branch

namespace IacBc
{
    class Program
    {
        static async Task Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
            Console.WriteLine("Welcome to the IAC-BC project!");

            // Example of async operation
            await ProcessDataAsync();

            // Example of user input
            Console.Write("Enter your name: ");
            string? name = Console.ReadLine();

            if (!string.IsNullOrEmpty(name))
            {
                Console.WriteLine($"Hello, {name}! Nice to meet you.");
            }
            else
            {
                Console.WriteLine("Hello, anonymous user!");
            }

            Console.WriteLine("Press any key to exit...");
            Console.ReadKey();
        }

        static async Task ProcessDataAsync()
        {
            Console.WriteLine("Processing data...");

            // Simulate async work
            await Task.Delay(1000);

            Console.WriteLine("Data processing completed!");
        }
    }
}