using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class Gym : BaseNamedEntity
{
    public string Address { get; set; } = null!;
    public string City { get; set; } = null!;
    public int? ZipCode { get; set; }
    public DateTime? DeletedAtUtc { get; set; }
    public ICollection<Workout> Workouts { get; set; } = new HashSet<Workout>();
}