namespace qb8s.net.OptiFit.CQRS.Dtos.Workout;

public class SearchWorkoutDto
{
    public Guid? Id { get; set; }
    public DateTimeOffset? From { get; set; }
    public DateTimeOffset? To { get; set; }
    public string? OrderBy { get; set; }
    public string? OrderDirection { get; set; } = "asc";
    public int PageSize { get; set; } = 10;

    public int PageIndex { get; set; } = 0;
}