using AutoMapper;
using MediatR;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.Workout;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Commands.Workout;

public record CreateWorkoutCommand(Guid UserId, CreateWorkoutDto CreateDto) : IRequest<GetWorkoutDto>;

public class CreateWorkoutCommandHandler(
    ILogger<CreateWorkoutCommandHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<CreateWorkoutCommand, GetWorkoutDto>
{
    public Task<GetWorkoutDto> Handle(CreateWorkoutCommand request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Create Workout Command : {@Dto}", request.CreateDto);
        var entity = mapper.Map<Core.Entities.Workout>(request.CreateDto);
        entity.UserId = request.UserId;
        dbContext.Workouts.Add(entity);
        dbContext.SaveChanges();
        return Task.FromResult(mapper.Map<GetWorkoutDto>(entity));
    }
}