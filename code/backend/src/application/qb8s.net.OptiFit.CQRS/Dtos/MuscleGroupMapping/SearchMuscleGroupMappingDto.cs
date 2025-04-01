namespace qb8s.net.OptiFit.CQRS.Dtos.MuscleGroupMapping;

public class SearchMuscleGroupMappingDto
{
    public Guid? Id { get; set; }
    public int PageSize { get; set; } = 10;
    public int PageIndex { get; set; } = 0;
    public string? OrderBy { get; set; }
    public string? OrderDirection { get; set; } = "asc";
}