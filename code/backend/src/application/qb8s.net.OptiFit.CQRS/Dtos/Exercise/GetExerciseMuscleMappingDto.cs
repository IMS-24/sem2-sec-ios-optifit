namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class GetExerciseMuscleMappingDto
{
    public Guid Id { get; set; }
    public Guid ExerciseId { get; set; }
    public Guid MuscleId { get; set; }
    public int? Intensity { get; set; }
}