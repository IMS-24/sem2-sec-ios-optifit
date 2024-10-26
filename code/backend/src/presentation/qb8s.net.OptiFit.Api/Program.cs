using qb8s.net.OptiFit.Api.Extensions;
using qb8s.net.OptiFit.CQRS.Extensions;
using qb8s.net.OptiFit.Persistence.Extensions;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

var configurationBuilder = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json", true)
    .AddJsonFile("appsettings.Local.json", true);
IConfiguration configuration = configurationBuilder
    .Build();


builder.Host.UseSerilog((ctx, cfg) =>
{
    cfg.WriteTo.Console();
    cfg.MinimumLevel.Information();
});

//Custom Services
builder.Services
    .AddInfrastructureService(configuration)
    .AddCqrsServices();


// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();
var logger = app.Services.GetRequiredService<ILogger<Program>>();
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();
logger.LogInformation(
    "\n                       \n                          ___        _   _  ____ _           __\n                         / _ \\ _ __ | |_(_)/ ___| |__   ___ / _|\n                        | | | | \'_ \\| __| | |   | \'_ \\ / _ \\ |_\n                        | |_| | |_) | |_| | |___| | | |  __/  _|\n                         \\___/| .__/ \\__|_|\\____|_| |_|\\___|_|\n                              |_|\n                       Version {InformalVersion}\n                       ",
    GitVersion.InformalVersion);
app.Run();