using AutoMapper;
using LinqKit;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Dtos.MuscleGroup;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.MuscleGroup;

public record SearchMuscleGroupsQuery(SearchMuscleGroupDto Search) : IRequest<PaginatedResult<GetMuscleGroupDto>>;

public class SearchMuscleGroupsQueryHandler(
    ILogger<SearchMuscleGroupsQueryHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<SearchMuscleGroupsQuery, PaginatedResult<GetMuscleGroupDto>>
{
    public Task<PaginatedResult<GetMuscleGroupDto>> Handle(SearchMuscleGroupsQuery request,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("Search Muscle Query : {@Search}", request);
        //@formatter:off
        var query = dbContext.MuscleGroups
                    .Include(muscle => muscle.MuscleGroupMappings)
                        .ThenInclude(muscleGroupMapping => muscleGroupMapping.Muscle)
                .AsQueryable();
        //@formatter:on
        var predicate = PredicateBuilder.New<Core.Entities.MuscleGroup>(true);
        // if (request.Search.Id.HasValue)
        // {
        //     predicate = predicate.And(x => x.Id == request.Search.Id);
        //     query = query.Where(predicate);
        //     return Task.FromResult(new PaginatedResult<GetMuscleGroupDto>(request.Search.PageSize,
        //         request.Search.PageIndex,
        //         query.AsEnumerable().Select(mapper.Map<GetMuscleGroupDto>)));
        // }

        if (request.Search.I18NCode != null)
            predicate = predicate.And(x => x.I18NCode.Contains(request.Search.I18NCode));
        query = query.Where(predicate);
        query = query.OrderBy(x => x.I18NCode);
        logger.LogInformation("Search Muscle Query : {@Query}", query);
        return Task.FromResult(new PaginatedResult<GetMuscleGroupDto>(request.Search.PageSize,
            request.Search.PageIndex,
            query.AsEnumerable().Select(mapper.Map<GetMuscleGroupDto>)));
    }
}