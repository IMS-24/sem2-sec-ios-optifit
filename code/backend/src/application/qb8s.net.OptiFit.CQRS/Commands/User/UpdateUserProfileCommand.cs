using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.User;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Commands.User;

public record UpdateUserProfileCommand(UpdateUserProfileDto Profile, Guid Id) : IRequest<UserProfileDto>;

public class UpdateUserProfileCommandHandler(
    ApplicationDbContext dbContext,
    ILogger<UpdateUserProfileCommandHandler> logger,
    IMapper mapper) : IRequestHandler<UpdateUserProfileCommand, UserProfileDto>
{
    public Task<UserProfileDto> Handle(UpdateUserProfileCommand request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Update User Profile Command : {@Dto}", request.Profile);
        var query = dbContext.Users.Include(user => user.UserRole).AsQueryable();
        var existingProfile = query.FirstOrDefault(u => u.Id == request.Id);
        if (existingProfile == null) throw new Exception("User not found");
        existingProfile = mapper.Map(request.Profile, existingProfile);
        existingProfile.UpdatedUtc = DateTimeOffset.UtcNow;
        dbContext.SaveChanges();
        var res = mapper.Map<UserProfileDto>(existingProfile);
        return Task.FromResult(res);
    }
}