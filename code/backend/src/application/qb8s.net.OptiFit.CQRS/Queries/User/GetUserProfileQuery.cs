using AutoMapper;
using LinqKit;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.User;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.User;

public record GetUserProfileQuery(Guid Id) : IRequest<UserProfileDto>;

public class GetUserProfileQueryHandler(
    ApplicationDbContext dbContext,
    ILogger<GetUserProfileQueryHandler> logger,
    IMapper mapper) : IRequestHandler<GetUserProfileQuery, UserProfileDto>
{
    public async Task<UserProfileDto> Handle(GetUserProfileQuery request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Get User Profile Query : {@Id}", request.Id);
        //@formatter:off
        var query = dbContext.Users
                .Include(user => user.UserRole)
                .AsQueryable();
        //@formatter:on
        var predicate = PredicateBuilder.New<Core.Entities.User>(true);
        predicate = predicate.And(x => x.Id == request.Id);
        query = query.Where(predicate);

        var existingUser = await query.FirstOrDefaultAsync(cancellationToken);

        if (existingUser == null) throw new Exception("User not found");
        return mapper.Map<UserProfileDto>(existingUser);
    }
}