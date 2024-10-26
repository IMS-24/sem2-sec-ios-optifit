using Microsoft.AspNetCore.Mvc;
using qb8s.net.OptiFit.CQRS.Commands.Exercise;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.CQRS.Queries.Exercise;

namespace qb8s.net.OptiFit.Api.Controllers;

public class ExerciseController(ILogger<ExerciseController> logger)
    : ApiBaseController
{
    [HttpPost("search")]
    // [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<AllergenDto>), Description = "Search Allergens")]
    public async Task<ActionResult<IEnumerable<ExerciseExtendedDto>>> SearchExercises(
        [FromQuery] SearchExerciseDto search)
    {
        logger.LogInformation("{@Name} request", nameof(SearchExercises));
        var result = await Mediator.Send(new SearchExercisesQuery(search));
        return Ok(result);
    }

    [HttpPost]
    public async Task<ActionResult<ExerciseDto>> CreateExercise(
        [FromBody] CreateExerciseDto createExerciseDto)
    {
        logger.LogInformation("{@Name} request : {@Dto}", nameof(CreateExercise), createExerciseDto);
        var result = await Mediator.Send(new CreateExerciseCommand(createExerciseDto));
        return Ok(result);
    }
}