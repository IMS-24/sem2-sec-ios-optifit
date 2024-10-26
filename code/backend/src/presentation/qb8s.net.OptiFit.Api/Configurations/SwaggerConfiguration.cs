namespace qb8s.net.OptiFit.Api.Configurations;

public class SwaggerConfiguration
{
    public Guid ClientId { get; set; }
    public string ApplicationName { get; set; } = null!;
    public string[] Scopes { get; set; } = null!;
}