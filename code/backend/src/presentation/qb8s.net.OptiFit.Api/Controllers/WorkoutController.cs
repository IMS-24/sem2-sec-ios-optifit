using System.Net;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NSwag.Annotations;
using qb8s.net.OptiFit.Api.Services;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Commands.Workout;
using qb8s.net.OptiFit.CQRS.Dtos.Workout;
using qb8s.net.OptiFit.CQRS.Queries.Workout;

namespace qb8s.net.OptiFit.Api.Controllers;

public class WorkoutController(ILogger<WorkoutController> logger, ICurrentUserService currentUserService)
    : ApiBaseController
{
    [HttpPost("search")]
    [Authorize]
    [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<GetWorkoutDto>), Description = "Search Workouts")]
    public async Task<ActionResult<PaginatedResult<GetWorkoutDto>>> SearchWorkouts(
        [FromBody] SearchWorkoutDto search)
    {
        logger.LogInformation("{@Name} request", nameof(SearchWorkouts));
        var result = await Mediator.Send(new SearchWorkoutsQuery(search, currentUserService.GetCurrentUserId()));
        return Ok(result);
    }

    [HttpPost]
    [Authorize]
    [SwaggerResponse(HttpStatusCode.OK, typeof(GetWorkoutDto), Description = "Create Workout")]
    public async Task<ActionResult<GetWorkoutDto>> CreateWorkout(
        [FromBody] CreateWorkoutDto createWorkoutDto)
    {
        logger.LogInformation("{@Name} request : {@Dto}", nameof(CreateWorkout), createWorkoutDto);
        var currentUserId = currentUserService.GetCurrentUserId();
        var result =
            await Mediator.Send(new CreateWorkoutCommand(currentUserId,
                createWorkoutDto));
        var search =
            await Mediator.Send(new SearchWorkoutsQuery(new SearchWorkoutDto { Id = result.Id }, currentUserId));
        return Ok(search.Items.FirstOrDefault());
    }

    [HttpGet("stats")]
    [Authorize]
    [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<GetWorkoutDto>),
        Description = "Get Workout statistics with query parameters: from,to")]
    public async Task<ActionResult<PaginatedResult<GetWorkoutDto>>> GetWorkoutStats(
        [FromQuery] DateTimeOffset from,
        [FromQuery] DateTimeOffset to)
    {
        logger.LogInformation("{@Name} request", nameof(GetWorkoutStats));
        var userId = currentUserService.GetCurrentUserId();
        var search =
            await Mediator.Send(new SearchWorkoutsQuery(new SearchWorkoutDto { From = from, To = to }, userId));
        return Ok(search);
    }
}