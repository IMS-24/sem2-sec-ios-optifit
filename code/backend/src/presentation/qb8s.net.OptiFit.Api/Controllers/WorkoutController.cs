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
    [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<GetWorkoutDto>), Description = "Search Workouts")]
    public async Task<ActionResult<PaginatedResult<GetWorkoutDto>>> SearchWorkouts(
        [FromBody] SearchWorkoutDto search)
    {
        logger.LogInformation("{@Name} request", nameof(SearchWorkouts));
        var result = await Mediator.Send(new SearchWorkoutsQuery(search));
        return Ok(result);
    }

    [HttpPost]
    [SwaggerResponse(HttpStatusCode.OK, typeof(GetWorkoutDto), Description = "Create Workout")]
    public async Task<ActionResult<GetWorkoutDto>> CreateWorkout(
        [FromBody] CreateWorkoutDto createWorkoutDto)
    {
        logger.LogInformation("{@Name} request : {@Dto}", nameof(CreateWorkout), createWorkoutDto);
        var result =
            await Mediator.Send(new CreateWorkoutCommand(new Guid("275cfdca-c686-4ea1-80b1-f2425b1602c5"),
                createWorkoutDto));
        var search = await Mediator.Send(new SearchWorkoutsQuery(new SearchWorkoutDto { Id = result.Id }));
        return Ok(search.Items.FirstOrDefault());
    }

    [HttpGet("stats")]
    [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<GetWorkoutDto>),
        Description = "Get Workout statistics with query parameters: from,to")]
    public async Task<ActionResult<PaginatedResult<GetWorkoutDto>>> GetWorkoutStats(
        [FromQuery] DateTimeOffset from,
        [FromQuery] DateTimeOffset to)
    {
        logger.LogInformation("{@Name} request", nameof(GetWorkoutStats));
        var search = await Mediator.Send(new SearchWorkoutsQuery(new SearchWorkoutDto { From = from, To = to }));
        return Ok(search);
    }
}