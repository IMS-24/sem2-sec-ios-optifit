using qb8s.net.OptiFit.Api.Configurations;

namespace qb8s.net.OptiFit.Api.Extensions;

public static class ConfigurationExtensions
{
    public static SwaggerConfiguration GetSwaggerConfiguration(this IConfiguration configuration)
    {
        return configuration.GetSection("Swagger").Get<SwaggerConfiguration>() ??
               throw new InvalidOperationException("'Swagger' not found in Appsettings");
    }
}