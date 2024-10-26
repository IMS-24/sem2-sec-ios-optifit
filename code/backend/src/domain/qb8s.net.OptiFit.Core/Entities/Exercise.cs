using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class Exercise : BaseI18NEntity
{
    public string Description { get; set; } = null!;

    public ICollection<ExerciseMuscleGroupMapping> ExerciseMuscleGroupMappings { get; set; } =
        new HashSet<ExerciseMuscleGroupMapping>();

    public ICollection<ExerciseMuscleMapping> ExerciseMuscleMappings { get; set; } =
        new HashSet<ExerciseMuscleMapping>();

    public ICollection<WorkoutLog> WorkoutLogs { get; set; } = new HashSet<WorkoutLog>();

    public ICollection<WorkoutPlanExerciseMapping> WorkoutPlanExerciseMappings { get; set; } =
        new HashSet<WorkoutPlanExerciseMapping>();

    public ICollection<GymExerciseMapping> GymExerciseMappings { get; set; } = new HashSet<GymExerciseMapping>();

    public Guid ExerciseTypeId { get; set; }
    public ExerciseType ExerciseType { get; set; } = null!;
}