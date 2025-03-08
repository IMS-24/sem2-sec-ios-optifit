using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class UserInsult : BaseEntity
{
    public Guid UserId { get; set; }
    public User? User { get; set; }
    public DateTimeOffset TimeStampUtc { get; set; }
    public Guid InsultId { get; set; }
    public Insult? Insult { get; set; }
}