using System.Net;
using Microsoft.AspNetCore.Mvc;
using NSwag.Annotations;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Commands.Exercise;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.CQRS.Queries.Exercise;

namespace qb8s.net.OptiFit.Api.Controllers;

public class ExerciseController(ILogger<ExerciseController> logger)
    : ApiBaseController
{
    [HttpPost("search")]
    [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<ExerciseExtendedDto>), Description = "Search Exercies")]
    public async Task<ActionResult<PaginatedResult<ExerciseExtendedDto>>> SearchExercises(
        [FromBody] SearchExerciseDto search)
    {
        logger.LogInformation("{@Name} request", nameof(SearchExercises));
        var result = await Mediator.Send(new SearchExercisesQuery(search));
        return Ok(result);
    }

    [HttpPost]
    [SwaggerResponse(StatusCodes.Status200OK, typeof(ExerciseDto), Description = "Create Exercise")]
    public async Task<ActionResult<ExerciseDto>> CreateExercise(
        [FromBody] CreateExerciseDto createExerciseDto)
    {
        logger.LogInformation("{@Name} request : {@Dto}", nameof(CreateExercise), createExerciseDto);
        var result = await Mediator.Send(new CreateExerciseCommand(createExerciseDto));
        return Ok(result);
    }
}