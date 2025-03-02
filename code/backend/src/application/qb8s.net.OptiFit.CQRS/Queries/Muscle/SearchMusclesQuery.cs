using AutoMapper;
using LinqKit;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Dtos.Muscle;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.Muscle;

public record SearchMusclesQuery(SearchMuscleDto Search) : IRequest<PaginatedResult<GetMuscleDto>>;

public class SearchMusclesQueryHandler(
    ILogger<SearchMusclesQueryHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<SearchMusclesQuery, PaginatedResult<GetMuscleDto>>
{
    public Task<PaginatedResult<GetMuscleDto>> Handle(SearchMusclesQuery request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Search Muscle Query : {@Search}", request);
        //@formatter:off
        var query = dbContext.Muscles
                .Include(muscle => muscle.MuscleGroupMappings)
                    .ThenInclude(muscleGroupMapping => muscleGroupMapping.MuscleGroup)
            .AsQueryable();
        //@formatter:on
        var predicate = PredicateBuilder.New<Core.Entities.Muscle>(true);
        if (request.Search.Id.HasValue)
        {
            predicate = predicate.And(x => x.Id == request.Search.Id);
            query = query.Where(predicate);
            return Task.FromResult(new PaginatedResult<GetMuscleDto>(request.Search.PageSize,
                request.Search.PageIndex,
                query.AsEnumerable().Select(mapper.Map<GetMuscleDto>)));
        }

        if (request.Search.I18NCode != null)
            predicate = predicate.And(x => x.I18NCode.Contains(request.Search.I18NCode));
        query = query.Where(predicate);
        query = query.OrderBy(x => x.I18NCode);
        logger.LogInformation("Search Muscle Query : {@Query}", query);
        return Task.FromResult(new PaginatedResult<GetMuscleDto>(request.Search.PageSize,
            request.Search.PageIndex,
            query.AsEnumerable().Select(mapper.Map<GetMuscleDto>)));
    }
}