namespace qb8s.net.OptiFit.CQRS.Dtos.MuscleGroup;

public class SearchMuscleGroupDto
{
    public string? I18NCode { get; set; } = null!;
    public string? OrderBy { get; set; }
    public string? OrderDirection { get; set; } = "asc";
    public int PageSize { get; set; } = 10;
    public int PageIndex { get; set; } = 0;
}