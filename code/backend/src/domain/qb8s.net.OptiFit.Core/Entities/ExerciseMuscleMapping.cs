using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class ExerciseMuscleMapping : BaseEntity
{
    public Guid ExerciseId { get; set; }
    public Exercise Exercise { get; set; } = null!;
    public Guid MuscleId { get; set; }
    public Muscle Muscle { get; set; } = null!;
    public int? Intensity { get; set; }
}