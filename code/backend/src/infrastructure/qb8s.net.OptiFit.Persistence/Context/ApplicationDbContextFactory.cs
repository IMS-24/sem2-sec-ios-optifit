using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;

namespace qb8s.net.OptiFit.Persistence.Context;

public class ApplicationDbContextFactory : IDesignTimeDbContextFactory<ApplicationDbContext>
{
  
    public ApplicationDbContext CreateDbContext(string[] args)
    {
        try
        {
            IConfiguration configuration = new ConfigurationManager()
                .SetBasePath(Path.Combine(Directory.GetCurrentDirectory(),
                    "../../presentation/qb8s.net.OptiFit.Api/"))
                .AddJsonFile("appsettings.json", true)
                .AddJsonFile("appsettings.Local.json", true)
                // .AddJsonFile("appsettings.Development.json", true)
                .AddEnvironmentVariables()
                .Build();
            DbContextOptionsBuilder<ApplicationDbContext> optionsBuilder = new();
            var connectionString = configuration.GetConnectionString("DefaultConnection") ??
                                   throw new InvalidOperationException(
                                       "Connection string 'DefaultConnection' not found.");
            optionsBuilder.UseNpgsql(connectionString);
            return new ApplicationDbContext(optionsBuilder.Options);
        }
        catch (Exception e)
        {
            Console.Error.WriteLine("Could not load Configuration");
            Console.Error.WriteLine(e);
            throw;
        }
    }
}