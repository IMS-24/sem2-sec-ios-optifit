using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class WorkoutPlan : BaseNamedEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;

    public string Description { get; set; } = null!;
    public DateOnly StartAt { get; set; }
    public DateOnly EndAt { get; set; }
    public string Notes { get; set; } = null!;
    public bool IsActive { get; set; }

    public ICollection<WorkoutPlanExerciseMapping> WorkoutPlanExerciseMappings { get; set; } =
        new HashSet<WorkoutPlanExerciseMapping>();
}