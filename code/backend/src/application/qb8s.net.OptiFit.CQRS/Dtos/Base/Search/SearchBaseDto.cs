using qb8s.net.OptiFit.Core.Pagination;

namespace qb8s.net.OptiFit.CQRS.Dtos.Base.Search;

public class SearchBaseDto : PaginationDto
{
    public Guid? Id { get; set; }
    public string? OrderBy { get; set; }
    public string? OrderDirection { get; set; } = "asc";
}