using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Identity.Web;
using qb8s.net.OptiFit.Api.Services;

namespace qb8s.net.OptiFit.Api.Extensions;

public static class AzureB2CExtension
{
    public static IServiceCollection AddAzureB2CAuthentication(this IServiceCollection services,
        IConfiguration configuration, string configurationSection = "AzureAdB2C")
    {
        services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddMicrosoftIdentityWebApi(configuration.GetSection(configurationSection));
        return services;
        //services.AddAuthorization();
        //return services;
    }

    public static IServiceCollection RegisterCurrentUserService(this IServiceCollection services)
    {
        services.AddScoped<ICurrentUserService, CurrentUserService>();
        return services;
    }
}