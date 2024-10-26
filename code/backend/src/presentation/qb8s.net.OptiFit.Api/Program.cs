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

builder.Services.AddSwagger(configuration);

var app = builder.Build();
var logger = app.Services.GetRequiredService<ILogger<Program>>();

// Configure the HTTP request pipeline.
app.UseOpenApi();
if (app.Environment.IsDevelopment()) app.UseSwagger(configuration);

app.UseCors(options =>
{
    //TODO: FIXME: This is a security risk, should be configured to only allow specific origins
    // options.WithOrigins(configuration.GetSection("AllowedHosts").Get<string[]>() ?? ["*"]);
    options.AllowAnyOrigin();
    options.AllowAnyMethod();
    options.AllowAnyHeader();
});
//app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();
logger.LogInformation(
    "\n .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------. \n| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |\n| |     ____     | || |   ______     | || |  _________   | || |     _____    | || |  _________   | || |     _____    | || |  _________   | |\n| |   .'    `.   | || |  |_   __ \\   | || | |  _   _  |  | || |    |_   _|   | || | |_   ___  |  | || |    |_   _|   | || | |  _   _  |  | |\n| |  /  .--.  \\  | || |    | |__) |  | || | |_/ | | \\_|  | || |      | |     | || |   | |_  \\_|  | || |      | |     | || | |_/ | | \\_|  | |\n| |  | |    | |  | || |    |  ___/   | || |     | |      | || |      | |     | || |   |  _|      | || |      | |     | || |     | |      | |\n| |  \\  `--'  /  | || |   _| |_      | || |    _| |_     | || |     _| |_    | || |  _| |_       | || |     _| |_    | || |    _| |_     | |\n| |   `.____.'   | || |  |_____|     | || |   |_____|    | || |    |_____|   | || | |_____|      | || |    |_____|   | || |   |_____|    | |\n| |              | || |              | || |              | || |              | || |              | || |              | || |              | |\n| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |\n '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------' \n\n                       Version {InformalVersion}\n                       ",
    GitVersion.InformalVersion);
app.Run();