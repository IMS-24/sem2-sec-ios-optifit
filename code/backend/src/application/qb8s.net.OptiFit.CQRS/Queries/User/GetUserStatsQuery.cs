using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.User;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.User;

public record GetUserStatsQuery(Guid Id) : IRequest<UserStatsDto>;

public class GetUserStatsQueryHandler(
    ApplicationDbContext dbContext,
    ILogger<GetUserStatsQueryHandler> logger,
    IMapper mapper) : IRequestHandler<GetUserStatsQuery, UserStatsDto>
{
    public async Task<UserStatsDto> Handle(GetUserStatsQuery request, CancellationToken cancellationToken)
    {
        logger.LogInformation("Get User Stats Query: {@Id}", request.Id);

        // Load the user with workouts and nested entities.
        var user = await dbContext.Users
            .Include(u => u.Workouts)
            .ThenInclude(w => w.WorkoutExercises)
            .ThenInclude(we => we.WorkoutSets)
            .FirstOrDefaultAsync(u => u.Id == request.Id, cancellationToken);

        if (user == null)
        {
            logger.LogWarning("User not found for id {Id}", request.Id);
            // Depending on your error handling strategy, you might throw an exception here.
            return new UserStatsDto();
        }

        // Total workouts
        var totalWorkouts = user.Workouts.Count;

        // Compute the distinct days on which workouts occurred.
        var workoutDates = user.Workouts
            .Select(w => w.StartAtUtc.Date)
            .Distinct()
            .OrderBy(d => d)
            .ToList();
        var activeDays = workoutDates.Count;

        // Total exercises across all workouts
        var totalExercises = user.Workouts.Sum(w => w.WorkoutExercises?.Count ?? 0);

        // Total sets across all workout exercises
        var totalSets = user.Workouts.Sum(w => w.WorkoutExercises.Sum(we => we.WorkoutSets?.Count ?? 0));

        // Total reps: sum up reps from every set
        var totalReps = user.Workouts.Sum(w => w.WorkoutExercises.Sum(we => we.WorkoutSets.Sum(ws => ws.Reps)));

        // Total weight: calculate (reps * weight) for each set
        var totalWeight = (int)user.Workouts.Sum(w =>
            w.WorkoutExercises.Sum(we =>
                we.WorkoutSets.Sum(ws => ws.Reps * ws.Weight)));

        // Total duration (in seconds) for workouts that have an EndAtUtc value.
        var totalDurationSeconds = user.Workouts
            .Where(w => w.EndAtUtc.HasValue)
            .Sum(w => (w.EndAtUtc!.Value - w.StartAtUtc).TotalSeconds);
        var totalDuration = (int)totalDurationSeconds;

        // Average duration per workout (in seconds)
        var averageDuration = totalWorkouts > 0 ? totalDuration / totalWorkouts : 0;

        // Calculate the longest consecutive workout streak (in days)
        var longestStreak = 0;
        var currentStreak = 0;
        DateTime? previousDate = null;
        foreach (var date in workoutDates)
        {
            if (previousDate == null || (date - previousDate.Value).Days == 1)
                currentStreak++;
            else
                currentStreak = 1;
            longestStreak = Math.Max(longestStreak, currentStreak);
            previousDate = date;
        }

        // Estimate total calories burned.
        // For example, assume 8 calories per minute.
        var totalCalories = (int)(totalDuration / 60.0 * 8);

        return new UserStatsDto
        {
            ActiveDays = activeDays,
            TotalWorkouts = totalWorkouts,
            TotalExercises = totalExercises,
            TotalSets = totalSets,
            TotalReps = totalReps,
            TotalWeight = totalWeight,
            TotalDuration = totalDuration,
            TotalCalories = totalCalories,
            WorkoutStreak = longestStreak,
            AverageDuration = averageDuration
        };
    }
}