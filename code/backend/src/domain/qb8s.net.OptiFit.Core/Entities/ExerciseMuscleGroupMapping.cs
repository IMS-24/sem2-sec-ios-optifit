using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class ExerciseMuscleGroupMapping : BaseEntity
{
    public Guid ExerciseId { get; set; }
    public Exercise Exercise { get; set; } = null!;
    public Guid MuscleGroupId { get; set; }
    public MuscleGroup MuscleGroup { get; set; } = null!;
}