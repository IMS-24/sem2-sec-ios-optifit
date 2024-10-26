using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class WorkoutPlanExerciseMapping : BaseEntity
{
    public Guid WorkoutPlanId { get; set; }
    public WorkoutPlan WorkoutPlan { get; set; } = null!;
    public Guid ExerciseId { get; set; }
    public Exercise Exercise { get; set; } = null!;
    public ICollection<Set> Sets { get; set; } = new List<Set>();
    public int RestTime { get; set; }
    public string Notes { get; set; } = null!;
    public int Day { get; set; }
}