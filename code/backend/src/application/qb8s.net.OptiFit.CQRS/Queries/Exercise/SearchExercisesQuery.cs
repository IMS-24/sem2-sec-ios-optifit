using AutoMapper;
using LinqKit;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.Exercise;

public record SearchExercisesQuery(SearchExerciseDto Search) : IRequest<IEnumerable<ExerciseExtendedDto>>;

public class SearchExercisesQueryHandler(
    ILogger<SearchExercisesQueryHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<SearchExercisesQuery, IEnumerable<ExerciseExtendedDto>>
{
    public Task<IEnumerable<ExerciseExtendedDto>> Handle(SearchExercisesQuery request,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("Search Exercises Query : {@Search}", request);
        //@formatter:off
        var query = dbContext.Exercises
                .Include(exercise => exercise.ExerciseType)
                .Include(exercise=>exercise.ExerciseMuscleGroupMappings)
                    .ThenInclude(exerciseMuscleMapping=>exerciseMuscleMapping.MuscleGroup)
                        .ThenInclude(muscleGroup=>muscleGroup.MuscleGroupMappings)
                            .ThenInclude(muscleGroupMapping=>muscleGroupMapping.Muscle)
            .AsQueryable();
        //@formatter:on
        var predicate = PredicateBuilder.New<Core.Entities.Exercise>(true);
        if (request.Search.Id.HasValue)
        {
            predicate = predicate.And(x => x.Id == request.Search.Id);
            query = query.Where(predicate);
            return Task.FromResult(query.Select(x => mapper.Map<ExerciseExtendedDto>(x)).AsEnumerable());
        }

        if (request.Search.I18NCode != null)
            predicate = predicate.And(x => x.I18NCode.Contains(request.Search.I18NCode));
        query = query.Where(predicate);
        query = query.OrderBy(x => x.I18NCode);
        return Task.FromResult(query.Select(x => mapper.Map<ExerciseExtendedDto>(x)).AsEnumerable());
    }
}