using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class Exercise : BaseI18NEntity
{
    public string Description { get; set; } = null!;

    public ICollection<ExerciseMuscleMapping> ExerciseMuscleMappings { get; set; } =
        new HashSet<ExerciseMuscleMapping>();

    public ICollection<WorkoutLog> WorkoutLogs { get; set; } = new HashSet<WorkoutLog>();

    public ICollection<WorkoutPlanExerciseMapping> WorkoutPlanExerciseMappings { get; set; } =
        new HashSet<WorkoutPlanExerciseMapping>();

    public ICollection<GymExerciseMapping> GymExerciseMappings { get; set; } = new HashSet<GymExerciseMapping>();

    public Guid ExerciseCategoryId { get; set; }
    public ExerciseCategory ExerciseCategory { get; set; } = null!;
}