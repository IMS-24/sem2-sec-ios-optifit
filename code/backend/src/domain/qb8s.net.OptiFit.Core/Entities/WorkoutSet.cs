using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class WorkoutSet : BaseEntity
{
    public Guid WorkoutExerciseId { get; set; }
    public WorkoutExercise WorkoutExercise { get; set; } = null!;

    public int Order { get; set; }
    public int Reps { get; set; }
    public decimal Weight { get; set; }
}