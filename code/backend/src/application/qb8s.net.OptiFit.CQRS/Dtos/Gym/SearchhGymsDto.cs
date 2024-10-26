using qb8s.net.OptiFit.CQRS.Dtos.Base.Search;

namespace qb8s.net.OptiFit.CQRS.Dtos.Gym;

public class SearchGymsDto : SearchNamedDto
{
    public string? Address { get; set; } = null!;
    public string? City { get; set; } = null!;
    public int? ZipCode { get; set; }
}