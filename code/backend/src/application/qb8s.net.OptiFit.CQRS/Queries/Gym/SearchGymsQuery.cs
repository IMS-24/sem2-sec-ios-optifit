using AutoMapper;
using LinqKit;
using MediatR;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Dtos.Gym;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.Gym;

public record SearchGymsQuery(SearchGymsDto Search) : IRequest<PaginatedResult<GymDto>>;

public class SearchGymsQueryHandler(
    ILogger<SearchGymsQueryHandler> logger,
    ApplicationDbContext dbContext,
    IMapper mapper) : IRequestHandler<SearchGymsQuery, PaginatedResult<GymDto>>
{
    public Task<PaginatedResult<GymDto>> Handle(SearchGymsQuery request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Search Gyms Query : {@Search}", request.Search);
        var query = dbContext.Gyms.AsQueryable();

        var predicate = PredicateBuilder.New<Core.Entities.Gym>(true);

        if (!string.IsNullOrEmpty(request.Search.Name))
            predicate = predicate.And(x => x.Name.Contains(request.Search.Name));

        if (!string.IsNullOrEmpty(request.Search.Address))
            predicate = predicate.And(x => x.Address.Contains(request.Search.Address));

        if (!string.IsNullOrEmpty(request.Search.City))
            predicate = predicate.And(x => x.City.Contains(request.Search.City));

        if (request.Search.ZipCode.HasValue)
            predicate = predicate.And(x => x.ZipCode == request.Search.ZipCode);

        return Task.FromResult(new PaginatedResult<GymDto>(request.Search.PageSize, request.Search.PageIndex,
            query.Where(predicate).AsEnumerable().Select(mapper.Map<GymDto>)));
    }
}