using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class MuscleGroupMapping : BaseEntity
{
    public Guid MuscleGroupId { get; set; }
    public MuscleGroup MuscleGroup { get; set; } = null!;

    public Guid MuscleId { get; set; }
    public Muscle Muscle { get; set; } = null!;

    /*public Guid ExerciseId { get; set; }
    public Exercise Exercise { get; set; } = null!;*/
}