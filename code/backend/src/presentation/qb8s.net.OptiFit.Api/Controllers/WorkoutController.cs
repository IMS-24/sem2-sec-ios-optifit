using System.Net;
using Microsoft.AspNetCore.Mvc;
using NSwag.Annotations;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Commands.Workout;
using qb8s.net.OptiFit.CQRS.Dtos.Workout;
using qb8s.net.OptiFit.CQRS.Queries.Workout;

namespace qb8s.net.OptiFit.Api.Controllers;

public class WorkoutController(ILogger<WorkoutController> logger) : ApiBaseController
{
    [HttpPost("search")]
    [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<WorkoutDto>), Description = "Search Workouts")]
    public async Task<ActionResult<PaginatedResult<WorkoutDto>>> SearchWorkouts(
        [FromBody] SearchWorkoutDto search)
    {
        logger.LogInformation("{@Name} request", nameof(SearchWorkouts));
        var result = await Mediator.Send(new SearchWorkoutsQuery(search));
        return Ok(result);
    }

    [HttpPost]
    [SwaggerResponse(HttpStatusCode.OK, typeof(WorkoutDto), Description = "Create Workout")]
    public async Task<ActionResult<WorkoutDto>> CreateWorkout(
        [FromBody] CreateWorkoutDto createWorkoutDto)
    {
        logger.LogInformation("{@Name} request : {@Dto}", nameof(CreateWorkout), createWorkoutDto);
        var result = await Mediator.Send(new CreateWorkoutCommand(createWorkoutDto));
        return Ok(result);
    }
}