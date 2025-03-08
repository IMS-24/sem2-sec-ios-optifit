namespace qb8s.net.OptiFit.CQRS.Dtos.AdUser;

public class AdUser
{
    public Guid Oid { get; set; }
    public string FirstName { get; set; } = null!;
    public string LastName { get; set; } = null!;
}