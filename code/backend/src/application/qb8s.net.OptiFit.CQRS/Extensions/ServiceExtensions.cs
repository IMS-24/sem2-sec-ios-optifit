using System.Reflection;
using Microsoft.Extensions.DependencyInjection;

namespace qb8s.net.OptiFit.CQRS.Extensions;

public static class ServiceExtensions
{
    public static IServiceCollection AddCqrsServices(this IServiceCollection services)
    {
        services.AddAutoMapper(Assembly.GetExecutingAssembly());
        services.AddMediatR(cfg => { cfg.RegisterServicesFromAssembly(Assembly.GetExecutingAssembly()); });
        return services;
    }
}