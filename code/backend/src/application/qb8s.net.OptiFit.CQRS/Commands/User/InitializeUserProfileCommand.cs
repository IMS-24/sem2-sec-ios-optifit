using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.User;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Commands.User;

public record InitializeUserProfileCommand(InitializeUserProfileDto Profile) : IRequest<UserProfileDto>;

public class InitializeUserProfileCommandHandler(
    ApplicationDbContext dbContext,
    ILogger<InitializeUserProfileCommandHandler> logger,
    IMapper mapper) : IRequestHandler<InitializeUserProfileCommand, UserProfileDto>
{
    public async Task<UserProfileDto> Handle(InitializeUserProfileCommand request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Update User Profile Command : {@Dto}", request.Profile);
        var existingProfile =
            await dbContext.Users.FirstOrDefaultAsync(user => user.OId == request.Profile.OId, cancellationToken);
        UserProfileDto res;
        var defaultRole =
            (await dbContext.UserRoles.ToListAsync(cancellationToken)).FirstOrDefault(
                x => x.Name.Contains("user", StringComparison.InvariantCultureIgnoreCase)); //TODO: FIX WITH PRIV_LEVEL
        if (existingProfile == null)
        {
            var entity = mapper.Map<Core.Entities.User>(request.Profile);
            entity.UserName = RandomFitnessNameGenerator.GenerateRandomName();
            entity.RegisteredUtc = DateTimeOffset.UtcNow;
            entity.UpdatedUtc = DateTimeOffset.UtcNow;
            entity.UserRoleId = defaultRole.Id;
            request.Profile.DateOfBirthUtc = request.Profile.DateOfBirthUtc.AddMilliseconds(666);
            if (request.Profile.DateOfBirthUtc.AddYears(10) < DateTimeOffset.UtcNow.AddYears(-105))
                entity.DateOfBirthUtc = null;
            dbContext.Users.Add(entity);
            await dbContext.SaveChangesAsync(cancellationToken);
            res = mapper.Map<UserProfileDto>(entity);
            res.UserRole = defaultRole.Name;
        }
        else
        {
            res = mapper.Map<UserProfileDto>(existingProfile);
        }

        return res;
    }

    private static class RandomFitnessNameGenerator
    {
        // Use a single Random instance to avoid repetition.
        private static readonly Random Random = new();

        // Default lists of tokens for fitness adjectives and weight-lifting suffixes.
        private static readonly List<string> DefaultFitnessTokens = new()
        {
            "WOD", "Squat", "Lunge", "Dumbbell", "Burpee", "Treadmill", "Flex", "Curl", "Absurd", "Gym"
        };

        private static readonly List<string> DefaultLiftingTokens = new()
        {
            "zilla", "NRoll", "Loco", "Doofus", "Bandit", "Tornado", "Appeal", "UpAndDie", "Abs", "Gnome"
        };

        /// <summary>
        ///     Generates a random fitness username using default tokens.
        /// </summary>
        /// <returns>A randomly generated username.</returns>
        public static string GenerateRandomName()
        {
            return GenerateRandomName(DefaultFitnessTokens.ToArray(), DefaultLiftingTokens.ToArray());
        }

        /// <summary>
        ///     Generates a random fitness username based on provided tokens.
        /// </summary>
        /// <param name="fitnessTokens">Array of tokens representing fitness adjectives or themes.</param>
        /// <param name="liftingTokens">Array of tokens representing weight lifting or humorous suffixes.</param>
        /// <returns>A randomly generated username.</returns>
        private static string GenerateRandomName(string[]? fitnessTokens, string[]? liftingTokens)
        {
            // If custom tokens are null or empty, fall back to default tokens.
            var tokens1 = fitnessTokens is { Length: > 0 } ? fitnessTokens : DefaultFitnessTokens.ToArray();
            var tokens2 = liftingTokens is { Length: > 0 } ? liftingTokens : DefaultLiftingTokens.ToArray();

            var token1 = tokens1[Random.Next(tokens1.Length)];
            var token2 = tokens2[Random.Next(tokens2.Length)];

            return $"{token1}{token2}";
        }
    }
}