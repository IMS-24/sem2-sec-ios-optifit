using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class Insult : BaseEntity
{
    public string Message { get; set; }
    public int Level { get; set; }

    public ICollection<UserInsult> UserInsultsCollection { get; set; }
}