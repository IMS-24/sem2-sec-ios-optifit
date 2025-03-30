namespace qb8s.net.OptiFit.CQRS.Dtos.Muscle;

public class SearchMuscleDto
{
    public string? I18NCode { get; set; } = null!;
    public string? OrderBy { get; set; }
    public string? OrderDirection { get; set; } = "asc";
    public int PageIndex { get; set; } = 0;
    public int PageSize { get; set; } = 10;
}