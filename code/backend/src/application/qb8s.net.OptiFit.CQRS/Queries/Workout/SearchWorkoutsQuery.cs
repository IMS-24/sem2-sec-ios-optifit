using AutoMapper;
using LinqKit;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Dtos.Workout;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.Workout;

public record SearchWorkoutsQuery(SearchWorkoutDto Search) : IRequest<PaginatedResult<WorkoutDto>>;

public class SearchWorkoutsQueryHandler(
    ILogger<SearchWorkoutsQueryHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<SearchWorkoutsQuery, PaginatedResult<WorkoutDto>>
{
    public Task<PaginatedResult<WorkoutDto>> Handle(SearchWorkoutsQuery request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Search Workout Query : {@Search}", request);
        //@formatter:off
        var query = dbContext.Workouts
                    .Include(workout => workout.WorkoutLogs)
                        .ThenInclude(workoutLog => workoutLog.Exercise)
                    .Include(workout => workout.WorkoutLogs)
                        .ThenInclude(workoutLog => workoutLog.Set)
                    .Include(workout=>workout.Gym)
                    .Include(workout=>workout.User)
                .AsQueryable();
        //@formatter:on
        var predicate = PredicateBuilder.New<Core.Entities.Workout>(true);
        if (request.Search.Id.HasValue)
        {
            predicate = predicate.And(x => x.Id == request.Search.Id);
            query = query.Where(predicate);
            return Task.FromResult(new PaginatedResult<WorkoutDto>(request.Search.PageSize,
                request.Search.PageIndex,
                query.AsEnumerable().Select(mapper.Map<WorkoutDto>)));
        }

        query = query.Where(predicate);
        query = query.OrderBy(x => x.StartAtUtc);
        return Task.FromResult(new PaginatedResult<WorkoutDto>(request.Search.PageSize,
            request.Search.PageIndex,
            query.AsEnumerable().Select(mapper.Map<WorkoutDto>)));
    }
}