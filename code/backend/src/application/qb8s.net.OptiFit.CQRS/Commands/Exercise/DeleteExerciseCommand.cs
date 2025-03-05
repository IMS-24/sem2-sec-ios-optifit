using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Commands.Exercise;

public record DeleteExerciseCommand(Guid UserId, Guid Id) : IRequest;

public class DeleteExerciseCommandHandler(
    ILogger<DeleteExerciseCommandHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<DeleteExerciseCommand>
{
    public async Task Handle(DeleteExerciseCommand request, CancellationToken cancellationToken)
    {
        //check for user permissions / (new Guid("275cfdca-c686-4ea1-80b1-f2425b1602c5")
        logger.LogInformation("Delete Exercise Command : {@Id}", request.Id);
        var entity = await dbContext.Exercises.FirstOrDefaultAsync(e => e.Id == request.Id, cancellationToken);
        if (entity == null) throw new Exception("Exercise not found");

        dbContext.Exercises.Remove(entity);
        await dbContext.SaveChangesAsync(cancellationToken);
    }
}