using AutoMapper;
using LinqKit;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.Exercise;

public record SearchExercisesQuery(SearchExerciseDto Search) : IRequest<PaginatedResult<GetExerciseDto>>;

public class SearchExercisesQueryHandler(
    ILogger<SearchExercisesQueryHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<SearchExercisesQuery, PaginatedResult<GetExerciseDto>>
{
    public Task<PaginatedResult<GetExerciseDto>> Handle(SearchExercisesQuery request,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("Search Exercises Query : {@Search}", request);
        //@formatter:off
        var query = dbContext.Exercises
                .Include(exercise => exercise.ExerciseCategory)
                .Include(exercise => exercise.ExerciseMuscleMappings)
                    .ThenInclude(mapping => mapping.Muscle)
                        .ThenInclude(muscle=>muscle.MuscleGroupMappings)
                            .ThenInclude(muscleGroupMapping=>muscleGroupMapping.MuscleGroup)
            .AsQueryable();
        //@formatter:on
        var predicate = PredicateBuilder.New<Core.Entities.Exercise>(true);
        // if (request.Search.Id.HasValue)
        // {
        //     predicate = predicate.And(x => x.Id == request.Search.Id);
        //     query = query.Where(predicate);
        //     // return Task.FromResult(new PaginatedResult<GetExerciseDto>(request.Search.PageSize,
        //     //     request.Search.PageIndex,
        //     //     query.AsEnumerable().Select(mapper.Map<GetExerciseDto>)));
        // }


        if (request.Search.I18NCode != null)
            predicate = predicate.And(x => x.I18NCode.Contains(request.Search.I18NCode));

        if (request.Search.ExerciseCategoryId.HasValue)
            predicate = predicate.And(x => x.ExerciseCategoryId == request.Search.ExerciseCategoryId);
        query = query.Where(predicate);
        query = query.OrderBy(exercise => exercise.ExerciseCategory.I18NCode)
            .ThenBy(exercise => exercise.I18NCode);
        return Task.FromResult(new PaginatedResult<GetExerciseDto>(request.Search.PageSize,
            request.Search.PageIndex,
            query.AsEnumerable().Select(mapper.Map<GetExerciseDto>)));
    }
}