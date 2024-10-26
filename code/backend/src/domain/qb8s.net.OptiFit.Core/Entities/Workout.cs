using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class Workout : BaseEntity
{
    public string Description { get; set; } = null!;
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public DateTime StartAtUtc { get; set; }
    public DateTime? EndAtUtc { get; set; }
    public string Notes { get; set; } = null!;
    public Guid GymId { get; set; }
    public Gym Gym { get; set; } = null!;
    public ICollection<WorkoutLog> WorkoutLogs { get; set; } = new HashSet<WorkoutLog>();
}