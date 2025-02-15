using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Commands.Exercise;

public record DeleteExerciseCommand(Guid Id) : IRequest;

public class DeleteExerciseCommandHandler(
    ILogger<DeleteExerciseCommandHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<DeleteExerciseCommand>
{
    public async Task Handle(DeleteExerciseCommand request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Delete Exercise Command : {@Id}", request.Id);
        var entity = await dbContext.Exercises.FirstOrDefaultAsync(e => e.Id == request.Id, cancellationToken);
        if (entity == null) throw new Exception("Exercise not found");

        dbContext.Exercises.Remove(entity);
        await dbContext.SaveChangesAsync(cancellationToken);
    }
}