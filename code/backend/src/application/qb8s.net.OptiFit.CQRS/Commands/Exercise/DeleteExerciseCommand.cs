using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Commands.Exercise;

public record DeleteExerciseCommand(Guid UserId, Guid Id) : IRequest<Guid>;

public class DeleteExerciseCommandHandler(
    ILogger<DeleteExerciseCommandHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<DeleteExerciseCommand, Guid>
{
    public async Task<Guid> Handle(DeleteExerciseCommand request, CancellationToken cancellationToken)
    {
        var user = await dbContext.Users.Include(user => user.UserRole)
            .FirstOrDefaultAsync(user => user.Id == request.UserId, cancellationToken);
        if (user == null) throw new Exception("User not found");
        if (!user.UserRole.Name.Contains("Admin"))
            throw new Exception("User does not have permission to delete exercise");
        logger.LogInformation("Delete Exercise Command : {@Id}", request.Id);
        var entity = await dbContext.Exercises.FirstOrDefaultAsync(e => e.Id == request.Id, cancellationToken);
        if (entity == null) throw new Exception("Exercise not found");

        dbContext.Exercises.Remove(entity);
        await dbContext.SaveChangesAsync(cancellationToken);
        return entity.Id;
    }
}