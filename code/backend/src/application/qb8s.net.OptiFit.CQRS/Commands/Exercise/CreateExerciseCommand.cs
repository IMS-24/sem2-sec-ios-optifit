using AutoMapper;
using LinqKit;
using MediatR;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.Core.Entities;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.CQRS.Queries.Exercise;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Commands.Exercise;

public record CreateExerciseCommand(CreateExerciseDto CreateDto) : IRequest<GetExerciseDto>;

public class CreateExerciseCommandHandler(
    ILogger<CreateExerciseCommandHandler> logger,
    IMapper mapper,
    IMediator mediator,
    ApplicationDbContext dbContext) : IRequestHandler<CreateExerciseCommand, GetExerciseDto>
{
    public async Task<GetExerciseDto> Handle(CreateExerciseCommand request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Create Exercise Command : {@Dto}", request.CreateDto);
        var entity = mapper.Map<Core.Entities.Exercise>(request.CreateDto);
        if (request.CreateDto.CreateExerciseMuscleMappingDtos.Any())
            request.CreateDto.CreateExerciseMuscleMappingDtos.ForEach(mapping =>
            {
                var muscleGroupMapping = new ExerciseMuscleMapping
                {
                    ExerciseId = entity.Id,
                    MuscleId = mapping.MuscleId,
                    Intensity = mapping.Intensity
                };
                entity.ExerciseMuscleMappings.Add(muscleGroupMapping);
            });
        dbContext.Exercises.Add(entity);
        await dbContext.SaveChangesAsync(cancellationToken);

        var stored = await mediator.Send(new GetExerciseQuery(entity.Id), cancellationToken);
        return mapper.Map<GetExerciseDto>(stored);
    }
}