using AutoMapper;
using MediatR;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.Gym;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Commands.Gym;

public record CreateGymCommand(CreateGymDto Gym) : IRequest<GymDto>;

public class CreateGymCommandHandler(
    ApplicationDbContext dbContext,
    ILogger<CreateGymCommandHandler> logger,
    IMapper mapper) : IRequestHandler<CreateGymCommand, GymDto>
{
    public Task<GymDto> Handle(CreateGymCommand request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Create Gym Command : {@Dto}", request.Gym);
        var entity = mapper.Map<Core.Entities.Gym>(request.Gym);
        dbContext.Gyms.Add(entity);
        dbContext.SaveChanges();
        return Task.FromResult(mapper.Map<GymDto>(entity));
    }
}