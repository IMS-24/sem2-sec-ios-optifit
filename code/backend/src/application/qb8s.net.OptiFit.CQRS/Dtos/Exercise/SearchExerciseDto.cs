namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class SearchExerciseDto
{
    public string? OrderBy { get; set; }
    public string? OrderDirection { get; set; } = "asc";
    public int PageSize { get; set; } = 10;

    public int PageIndex { get; set; } = 0;
    public string? I18NCode { get; set; } = null!;
    public string? Description { get; set; } = null!;
    public Guid? ExerciseCategoryId { get; set; } = null!;
}