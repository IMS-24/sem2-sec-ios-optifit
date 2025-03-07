using System.Security.Claims;
using qb8s.net.OptiFit.CQRS.Dtos.AdUser;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.Api.Services;

public class CurrentUserService : ICurrentUserService
{
    private readonly ApplicationDbContext _dbContext;
    private readonly IHttpContextAccessor _httpContextAccessor;
    private readonly ILogger<CurrentUserService> _logger;

    public CurrentUserService(IHttpContextAccessor httpContextAccessor, ApplicationDbContext dbContext,
        ILogger<CurrentUserService> logger)
    {
        _httpContextAccessor = httpContextAccessor;
        _dbContext = dbContext;
        _logger = logger;

        if (_httpContextAccessor.HttpContext == null) return;
        logger.LogInformation("Current User Service - Init Current user ");
        if (_httpContextAccessor.HttpContext.User.FindFirstValue(ClaimTypes.NameIdentifier) == null) return;
        AdUser = new AdUser
        {
            Oid = new Guid(_httpContextAccessor.HttpContext?.User.FindFirstValue(ClaimTypes.NameIdentifier)),
            FirstName = _httpContextAccessor.HttpContext?.User.FindFirstValue(ClaimTypes.GivenName),
            LastName = _httpContextAccessor.HttpContext?.User.FindFirstValue(ClaimTypes.Surname)
        };
    }


    public AdUser AdUser { get; set; } = null!;


    public Guid GetCurrentUserId()
    {
        var currentUser = _dbContext.Users.FirstOrDefault(x => x.OId == AdUser.Oid);
        return currentUser?.Id ?? Guid.Empty;
    }
}