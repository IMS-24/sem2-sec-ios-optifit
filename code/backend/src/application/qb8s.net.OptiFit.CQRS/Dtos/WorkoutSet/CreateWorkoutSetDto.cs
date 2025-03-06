namespace qb8s.net.OptiFit.CQRS.Dtos.WorkoutSet;

public class CreateWorkoutSetDto
{
    public int Order { get; set; }
    public int Reps { get; set; }
    public decimal Weight { get; set; }

    // If you store sets in a separate table:
    public Guid WorkoutExerciseId { get; set; }
}