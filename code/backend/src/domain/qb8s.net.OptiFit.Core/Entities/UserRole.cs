using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class UserRole : BaseNamedEntity
{
    public ICollection<User> Users { get; set; } = new HashSet<User>();
}