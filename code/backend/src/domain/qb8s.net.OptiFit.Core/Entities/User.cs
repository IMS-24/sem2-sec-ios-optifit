using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class User : BaseEntity
{
    public string UserName { get; set; } = null!;
    public string Email { get; set; } = null!;
    public string FirstName { get; set; } = null!;
    public string LastName { get; set; } = null!;
    public Guid OId { get; set; }
    public Guid? UserRoleId { get; set; }
    public UserRole UserRole { get; set; } = null!;

    public DateTimeOffset? DateOfBirthUtc { get; set; }
    public DateTimeOffset? LastLoginUtc { get; set; }
    public DateTimeOffset RegisteredUtc { get; set; }
    public DateTimeOffset UpdatedUtc { get; set; }

    public int TotalInsults { get; set; } = 0;
    public ICollection<UserInsult> UserInsults { get; set; }

    public bool InitialSetupDone { get; set; }

    public ICollection<Workout> Workouts { get; set; } = new HashSet<Workout>();
}