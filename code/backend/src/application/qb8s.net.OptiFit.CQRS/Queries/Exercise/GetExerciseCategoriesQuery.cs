using AutoMapper;
using MediatR;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.ExerciseCategory;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.Exercise;

public record GetExerciseCategoriesQuery : IRequest<IEnumerable<GetExerciseCategoryDto>>;

public class GetExerciseCategoriesQueryHandler(
    ILogger<GetExerciseCategoriesQueryHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<GetExerciseCategoriesQuery, IEnumerable<GetExerciseCategoryDto>>
{
    public Task<IEnumerable<GetExerciseCategoryDto>> Handle(GetExerciseCategoriesQuery request,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("Get Exercise Categories Query : {@Search}", request);
        var query = dbContext.ExerciseCategories.AsQueryable();
        return Task.FromResult(query.AsEnumerable().Select(mapper.Map<GetExerciseCategoryDto>));
    }
}