using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class WorkoutExercise : BaseEntity
{
    public int Order { get; set; }
    public Guid WorkoutId { get; set; }
    public Workout Workout { get; set; } = null!;
    public Guid ExerciseId { get; set; }
    public Exercise Exercise { get; set; } = null!;
    public ICollection<WorkoutSet> WorkoutSets { get; set; } = null!;
    public string Notes { get; set; } = null!;
}