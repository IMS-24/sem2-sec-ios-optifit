using AutoMapper;
using LinqKit;
using MediatR;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Dtos.MuscleGroupMapping;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.MuscleGroupMapping;

public record SearchMuscleGroupMappingsQuery(SearchMuscleGroupMappingDto Search)
    : IRequest<PaginatedResult<MuscleGroupMappingDto>>;

public class SearchMuscleGroupMappingsQueryHandler(
    ILogger<SearchMuscleGroupMappingsQueryHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext)
    : IRequestHandler<SearchMuscleGroupMappingsQuery, PaginatedResult<MuscleGroupMappingDto>>
{
    public Task<PaginatedResult<MuscleGroupMappingDto>> Handle(SearchMuscleGroupMappingsQuery request,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("Search Muscle Query : {@Search}", request);
        //@formatter:off
        var query = dbContext.MuscleGroupMappings
                .AsQueryable();
        //@formatter:on
        var predicate = PredicateBuilder.New<Core.Entities.MuscleGroupMapping>(true);
        if (request.Search.Id.HasValue)
        {
            predicate = predicate.And(x => x.Id == request.Search.Id);
            query = query.Where(predicate);
            return Task.FromResult(new PaginatedResult<MuscleGroupMappingDto>(request.Search.PageSize,
                request.Search.PageIndex,
                query.AsEnumerable().Select(mapper.Map<MuscleGroupMappingDto>)));
        }


        query = query.Where(predicate);
        return Task.FromResult(new PaginatedResult<MuscleGroupMappingDto>(request.Search.PageSize,
            request.Search.PageIndex,
            query.AsEnumerable().Select(mapper.Map<MuscleGroupMappingDto>)));
    }
}