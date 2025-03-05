using AutoMapper;
using LinqKit;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Dtos.Workout;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.Workout;

public record SearchWorkoutsQuery(SearchWorkoutDto Search) : IRequest<PaginatedResult<GetWorkoutDto>>;

public class SearchWorkoutsQueryHandler(
    ILogger<SearchWorkoutsQueryHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<SearchWorkoutsQuery, PaginatedResult<GetWorkoutDto>>
{
    public Task<PaginatedResult<GetWorkoutDto>> Handle(SearchWorkoutsQuery request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Search Workout Query : {@Search}", request);
        //@formatter:off
        var query = dbContext.Workouts
                    .Include(workout => workout.WorkoutExercises)
                        .ThenInclude(workoutExercise => workoutExercise.Exercise)
                    .Include(workout => workout.WorkoutExercises)
                        .ThenInclude(workoutSet => workoutSet.WorkoutSets)
                    .Include(workout=>workout.Gym)
                    .Include(workout=>workout.User)
                .AsQueryable();
        //@formatter:on
        var predicate = PredicateBuilder.New<Core.Entities.Workout>(true);
        if (request.Search.Id.HasValue)
        {
            predicate = predicate.And(x => x.Id == request.Search.Id);
            query = query.Where(predicate);
            return Task.FromResult(new PaginatedResult<GetWorkoutDto>(request.Search.PageSize,
                request.Search.PageIndex,
                query.AsEnumerable().Select(mapper.Map<GetWorkoutDto>)));
        }

        if (request.Search.From.HasValue) predicate = predicate.And(x => x.StartAtUtc >= request.Search.From);

        if (request.Search.To.HasValue) predicate = predicate.And(x => x.StartAtUtc <= request.Search.To);

        query = query.Where(predicate);
        query = query.OrderBy(x => x.StartAtUtc);
        return Task.FromResult(new PaginatedResult<GetWorkoutDto>(request.Search.PageSize,
            request.Search.PageIndex,
            query.AsEnumerable().Select(mapper.Map<GetWorkoutDto>)));
    }
}