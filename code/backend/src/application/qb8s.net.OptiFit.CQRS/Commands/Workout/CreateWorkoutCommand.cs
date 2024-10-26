using AutoMapper;
using MediatR;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.Workout;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Commands.Workout;

public record CreateWorkoutCommand(CreateWorkoutDto CreateDto) : IRequest<WorkoutDto>;

public class CreateWorkoutCommandHandler(
    ILogger<CreateWorkoutCommandHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<CreateWorkoutCommand, WorkoutDto>
{
    public Task<WorkoutDto> Handle(CreateWorkoutCommand request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Create Workout Command : {@Dto}", request.CreateDto);
        var entity = mapper.Map<Core.Entities.Workout>(request.CreateDto);
        dbContext.Workouts.Add(entity);
        dbContext.SaveChanges();
        return Task.FromResult(mapper.Map<WorkoutDto>(entity));
    }
}