using qb8s.net.OptiFit.CQRS.Dtos.Base.Search;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class SearchExerciseDto : SearchI18NDto
{
    public string? Description { get; set; } = null!;
    public Guid? ExerciseCategoryId { get; set; } = null!;
}