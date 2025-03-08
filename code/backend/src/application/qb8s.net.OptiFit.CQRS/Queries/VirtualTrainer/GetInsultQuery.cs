using AutoMapper;
using MediatR;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.Core.Entities;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.VirtualTrainer;

public class InsultDto
{
    public string Message { get; set; }
    public int Level { get; set; }
}

public class InsultDtoProfile : Profile
{
    public InsultDtoProfile()
    {
        CreateMap<Insult, InsultDto>()
            .ForMember(dest => dest.Message, opt => opt.MapFrom(src => src.Message))
            .ForMember(dest => dest.Level, opt => opt.MapFrom(src => src.Level))
            ;
    }
}

public record GetInsultQuery(int Level, Guid UserId) : IRequest<InsultDto?>;

public class GetInsultQueryHandler(
    ILogger<GetInsultQueryHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<GetInsultQuery, InsultDto?>
{
    private static readonly Random RandomGenerator = new();

    public async Task<InsultDto?> Handle(GetInsultQuery request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Get Insult Query : {@GetInsult}", request);
        var insults = dbContext.Insults.GroupBy(x => x.Level).ToDictionary(x => x.Key, x => x.ToList());
        var closestLevel = insults.Keys.OrderBy(x => Math.Abs(x - request.Level)).FirstOrDefault();
        if (!insults.TryGetValue(closestLevel, out var possibleInsults)) return null;
        var selectedInsult = possibleInsults.OrderBy(_ => RandomGenerator.Next()).FirstOrDefault();

        var userInsult = new UserInsult
        {
            UserId = request.UserId,
            TimeStampUtc = DateTimeOffset.UtcNow,
            Insult = selectedInsult
        };
        dbContext.UserInsults.Add(userInsult);
        await dbContext.SaveChangesAsync(cancellationToken);

        logger.LogDebug("Selected Insult : {@Insult}", selectedInsult);
        return mapper.Map<InsultDto>(selectedInsult);
    }
}