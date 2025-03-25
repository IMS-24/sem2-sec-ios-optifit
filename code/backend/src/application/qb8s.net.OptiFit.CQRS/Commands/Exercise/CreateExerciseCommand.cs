using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Commands.Exercise;

public record CreateExerciseCommand(CreateExerciseDto CreateDto) : IRequest<GetExerciseDto>;

public class CreateExerciseCommandHandler(
    ILogger<CreateExerciseCommandHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<CreateExerciseCommand, GetExerciseDto>
{
    public async Task<GetExerciseDto> Handle(CreateExerciseCommand request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Create Exercise Command : {@Dto}", request.CreateDto);
        var entity = mapper.Map<Core.Entities.Exercise>(request.CreateDto);
        dbContext.Exercises.Add(entity);
        await dbContext.SaveChangesAsync(cancellationToken);
        var category = await dbContext.ExerciseCategories.FirstOrDefaultAsync(x => x.Id == entity.ExerciseCategoryId, cancellationToken: cancellationToken);
        entity.ExerciseCategory = category;
        return mapper.Map<GetExerciseDto>(entity);
    }
}