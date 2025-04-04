using System.Reflection;
using Microsoft.Extensions.DependencyInjection;
using qb8s.net.OptiFit.CQRS.Interfaces;
using qb8s.net.OptiFit.CQRS.Services;

namespace qb8s.net.OptiFit.CQRS.Extensions;

public static class ServiceExtensions
{
    public static IServiceCollection AddCqrsServices(this IServiceCollection services)
    {
        services.AddAutoMapper(Assembly.GetExecutingAssembly());
        services.AddMediatR(cfg => { cfg.RegisterServicesFromAssembly(Assembly.GetExecutingAssembly()); });
        return services;
    }

    public static IServiceCollection AddApplicationServices(this IServiceCollection services)
    {
        services.AddTransient<IImageService, ImageService>();
        return services;
    }
}