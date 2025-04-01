namespace qb8s.net.OptiFit.CQRS.Dtos.Gym;

public class SearchGymsDto
{
    public string? Name { get; set; } = null!;
    public string? Address { get; set; } = null!;
    public string? City { get; set; } = null!;
    public int? ZipCode { get; set; }
    public string? OrderBy { get; set; }
    public string? OrderDirection { get; set; } = "asc";
    public int PageSize { get; set; } = 10;

    public int PageIndex { get; set; } = 0;
}