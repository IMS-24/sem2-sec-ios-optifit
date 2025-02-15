using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.User;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.User;

public record GetUserStatsQuery(Guid Id) : IRequest<UserStatsDto>;

public class GetUserStatsQueryHandler(
    ApplicationDbContext dbContext,
    ILogger<GetUserStatsQueryHandler> logger,
    IMapper mapper) : IRequestHandler<GetUserStatsQuery, UserStatsDto>
{
    public async Task<UserStatsDto> Handle(GetUserStatsQuery request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Get User Stats Query : {@Id}", request.Id);
        //@formatter:off
        var query = dbContext.Users
            .Include(user => user.UserRole)
            .AsQueryable();
        //@formatter:on

        //TODO: Implement GetUserStatsQueryHandler
        return new UserStatsDto
        {
            ActiveDays = new Random().Next(5, 500),
            TotalWorkouts = new Random().Next(50, 2000),
            TotalExercises = new Random().Next(120, 1200),
            TotalSets = new Random().Next(500, 70000),
            TotalReps = new Random().Next(900, 180000),
            TotalWeight = new Random().Next(70000, 75000000),
            TotalDuration = new Random().Next(10000, 999999),
            TotalCalories = new Random().Next(50, 900),
            WorkoutStreak = new Random().Next(7, 800),
            AverageDuration = new Random().Next(15, 700)
        };
    }
}