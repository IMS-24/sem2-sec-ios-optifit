using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.CQRS.Dtos.Workout;
using qb8s.net.OptiFit.CQRS.Dtos.WorkoutExercise;
using qb8s.net.OptiFit.CQRS.Dtos.WorkoutSet;
using qb8s.net.OptiFit.Persistence.Context;

namespace qb8s.net.OptiFit.CQRS.Queries.Exercise;

public record GetExerciseStatisticsQuery(Guid ExerciseId, Guid UserId) : IRequest<GetExerciseStatisticsDto>;

public class GetExerciseStatisticsQueryHandler(
    ILogger<GetExerciseStatisticsQueryHandler> logger,
    IMapper mapper,
    ApplicationDbContext dbContext) : IRequestHandler<GetExerciseStatisticsQuery, GetExerciseStatisticsDto>
{
    public async Task<GetExerciseStatisticsDto> Handle(GetExerciseStatisticsQuery request,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("Get Exercise Stats Query : {@Request}", request);

        // Project directly into the DTO
        //@Formatter:off
        var result = await dbContext
            .Exercises
            .Include(exercise => exercise.ExerciseCategory)
            .Include(workout => workout.WorkoutExercises)
            .ThenInclude(workoutSet => workoutSet.WorkoutSets)
            .Include(exercise => exercise.WorkoutExercises)
            .ThenInclude(workoutExercise => workoutExercise.Workout)
            .ThenInclude(workout => workout.User)
            .Include(exercise => exercise.WorkoutExercises)
            .ThenInclude(workoutExercise => workoutExercise.Workout)
            .ThenInclude(workout => workout.Gym)
            .Where(e => e.Id == request.ExerciseId && e.WorkoutExercises.All(we => we.Workout.UserId == request.UserId))
            .Select(e => new GetExerciseStatisticsDto
            {
                ExerciseDto = mapper.Map<GetExerciseDto>(e),
                ExerciseWorkoutsDto = e.WorkoutExercises
                    .Where(we => we.ExerciseId == request.ExerciseId &&
                                 we.Workout.UserId == request.UserId)
                    .Where(we => we.WorkoutSets.Count != 0 && we.WorkoutSets.Any(wes => wes.Reps > 0 && wes.Weight > 0))
                    .Select(we => new ExerciseWorkoutDto
                    {
                        Id = we.Id,
                        Order = we.Order,
                        Workout = mapper.Map<GetWorkoutDto>(we.Workout),
                        ExerciseId = we.ExerciseId,
                        WorkoutSets = we.WorkoutSets
                            .Select(ws => new GetWorkoutSetDto
                            {
                                Id = ws.Id,
                                Order = ws.Order,
                                Reps = ws.Reps,
                                Weight = ws.Weight,
                                WorkoutExerciseId = ws.WorkoutExerciseId
                            }).ToList(),
                        Notes = we.Notes
                    }).ToList()
            })
            .FirstOrDefaultAsync(cancellationToken);
//@formatter:on
        // if (result == null)
        // Handle the case when no matching exercise is found.
        // For example, you might throw an exception or return an empty DTO.
        //throw new NotFoundException($"Exercise with id {request.ExerciseId} not found for user {request.UserId}.");

        // Calculate aggregate statistics
        // result.TotalWorkouts = result.WorkoutExercises.Count;
        // result.TotalSets = result.WorkoutExercises.Sum(we => we.WorkoutSets.Count);
        // result.TotalReps = result.WorkoutExercises.Sum(we => we.WorkoutSets.Sum(ws => ws.Reps));
        // result.TotalWeight = result.WorkoutExercises.Sum(we => we.WorkoutSets.Sum(ws => ws.Weight));

        return result;
    }
}