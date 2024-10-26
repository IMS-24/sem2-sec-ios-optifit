using System.Reflection;

namespace qb8s.net.OptiFit.Api.Extensions;

internal static class GitVersion
{
    private static AssemblyInformationalVersionAttribute? AssemblyInformationalVersionAttribute { get; } =
        Assembly.GetExecutingAssembly().GetCustomAttribute<AssemblyInformationalVersionAttribute>();

    internal static string? InformalVersion => AssemblyInformationalVersionAttribute?.InformationalVersion;
}