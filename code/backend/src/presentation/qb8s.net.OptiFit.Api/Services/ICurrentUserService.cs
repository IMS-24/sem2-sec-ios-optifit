using qb8s.net.OptiFit.CQRS.Dtos.AdUser;

namespace qb8s.net.OptiFit.Api.Services;

public interface ICurrentUserService
{
    public AdUser AdUser { get; set; }
    public Guid GetCurrentUserId();
}