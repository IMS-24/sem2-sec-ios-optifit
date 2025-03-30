using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.Exercise;

public record GetExerciseQuery(Guid Id) : IRequest<GetExerciseDto>;

public class GetExerciseQueryHandler(
    IMapper mapper,
    ILogger<GetExerciseQuery> logger,
    ApplicationDbContext dbContext) : IRequestHandler<GetExerciseQuery, GetExerciseDto>
{
    public async Task<GetExerciseDto> Handle(GetExerciseQuery request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Get Exercise Query : {@Search}", request);
        var entity = await dbContext.Exercises.SingleOrDefaultAsync(x => x.Id == request.Id, cancellationToken);
        logger.LogInformation("Get Exercise Query Result : {@Entity}", entity);
        return mapper.Map<GetExerciseDto>(entity);
    }
}