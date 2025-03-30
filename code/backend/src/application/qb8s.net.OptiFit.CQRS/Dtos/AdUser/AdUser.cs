namespace qb8s.net.OptiFit.CQRS.Dtos.AdUser;

public class AdUser
{
    public Guid OId { get; set; }
    public string FirstName { get; set; } = null!;
    public string LastName { get; set; } = null!;
    public string Email { get; set; } = null!;
}