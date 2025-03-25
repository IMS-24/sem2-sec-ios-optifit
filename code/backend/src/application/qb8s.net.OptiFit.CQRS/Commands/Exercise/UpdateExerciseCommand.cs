using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Commands.Exercise;

public record UpdateExerciseCommand(Guid Id, UpdateExerciseDto UpdateExerciseDto) : IRequest<GetExerciseDto>;

public class UpdateExerciseCommandHandler(
    ILogger<CreateExerciseCommandHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<UpdateExerciseCommand, GetExerciseDto>
{
    public async Task<GetExerciseDto> Handle(UpdateExerciseCommand request, CancellationToken cancellationToken)
    {
        var entity = await dbContext.Exercises.Include(exercise => exercise.ExerciseCategory)
            .FirstOrDefaultAsync(e => e.Id == request.Id, cancellationToken);

        mapper.Map(request.UpdateExerciseDto, entity);

        await dbContext.SaveChangesAsync(cancellationToken);

        return mapper.Map<GetExerciseDto>(entity);
    }
}