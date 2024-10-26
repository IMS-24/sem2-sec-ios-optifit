using AutoMapper;
using MediatR;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Commands.Exercise;

public record CreateExerciseCommand(CreateExerciseDto CreateDto) : IRequest<ExerciseDto>;

public class CreateExerciseCommandHandler(
    ILogger<CreateExerciseCommandHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<CreateExerciseCommand, ExerciseDto>
{
    public async Task<ExerciseDto> Handle(CreateExerciseCommand request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Create Exercise Command : {@Dto}", request.CreateDto);
        var entity = mapper.Map<Core.Entities.Exercise>(request.CreateDto);
        dbContext.Exercises.Add(entity);
        await dbContext.SaveChangesAsync(cancellationToken);
        return mapper.Map<ExerciseDto>(entity);
    }
}