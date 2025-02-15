using AutoMapper;
using MediatR;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.Exercise;

public record GetExerciseTypesQuery : IRequest<IEnumerable<ExerciseTypeDto>>;

public class GetExerciseTypesQueryHandler(
    ILogger<GetExerciseTypesQueryHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<GetExerciseTypesQuery, IEnumerable<ExerciseTypeDto>>
{
    public Task<IEnumerable<ExerciseTypeDto>> Handle(GetExerciseTypesQuery request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Get Exercise Types Query : {@Search}", request);
        var query = dbContext.ExerciseTypes.AsQueryable();
        return Task.FromResult(query.AsEnumerable().Select(mapper.Map<ExerciseTypeDto>));
    }
}