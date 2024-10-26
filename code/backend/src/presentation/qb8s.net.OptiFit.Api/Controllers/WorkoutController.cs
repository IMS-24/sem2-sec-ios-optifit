using Microsoft.AspNetCore.Mvc;
using qb8s.net.OptiFit.CQRS.Commands.Workout;
using qb8s.net.OptiFit.CQRS.Dtos.Workout;

namespace qb8s.net.OptiFit.Api.Controllers;

public class WorkoutController(ILogger<WorkoutController> logger) : ApiBaseController
{
    /*[HttpPost("search")]
    // [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<AllergenDto>), Description = "Search Allergens")]
    public async Task<ActionResult<IEnumerable<WorkoutExtendedDto>>> SearchWorkouts(
        [FromQuery] SearchWorkoutDto search)
    {
        logger.LogInformation("{@Name} request", nameof(SearchWorkouts));
        var result = await Mediator.Send(new SearchWorkoutsQuery(search));
        return Ok(result);
    }*/

    [HttpPost]
    public async Task<ActionResult<WorkoutDto>> CreateWorkout(
        [FromBody] CreateWorkoutDto createWorkoutDto)
    {
        logger.LogInformation("{@Name} request : {@Dto}", nameof(CreateWorkout), createWorkoutDto);
        var result = await Mediator.Send(new CreateWorkoutCommand(createWorkoutDto));
        return Ok(result);
    }
}