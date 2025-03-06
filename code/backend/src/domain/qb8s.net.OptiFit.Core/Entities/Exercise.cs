using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.Core.Entities;

public class Exercise : BaseI18NEntity
{
    public string Description { get; set; } = null!;

    public ICollection<ExerciseMuscleMapping> ExerciseMuscleMappings { get; set; } =
        new HashSet<ExerciseMuscleMapping>();

    public ICollection<WorkoutExercise> WorkoutExercises { get; set; } = new HashSet<WorkoutExercise>();

    public Guid ExerciseCategoryId { get; set; }
    public ExerciseCategory ExerciseCategory { get; set; } = null!;
}