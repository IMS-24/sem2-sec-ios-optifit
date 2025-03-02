using System.Net;
using Microsoft.AspNetCore.Mvc;
using NSwag.Annotations;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Commands.Exercise;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.CQRS.Dtos.ExerciseCategory;
using qb8s.net.OptiFit.CQRS.Queries.Exercise;

namespace qb8s.net.OptiFit.Api.Controllers;

public class ExerciseController(ILogger<ExerciseController> logger)
    : ApiBaseController
{
    [HttpPost("search")]
    [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<GetExerciseDto>), Description = "Search Exercies")]
    public async Task<ActionResult<PaginatedResult<GetExerciseDto>>> SearchExercises(
        [FromBody] SearchExerciseDto search)
    {
        logger.LogInformation("{@Name} request", nameof(SearchExercises));
        var result = await Mediator.Send(new SearchExercisesQuery(search));
        return Ok(result);
    }

    [HttpPost]
    [SwaggerResponse(StatusCodes.Status200OK, typeof(GetExerciseDto), Description = "Create Exercise")]
    public async Task<ActionResult<GetExerciseDto>> CreateExercise(
        [FromBody] CreateExerciseDto createExerciseDto)
    {
        logger.LogInformation("{@Name} request : {@Dto}", nameof(CreateExercise), createExerciseDto);
        var result = await Mediator.Send(new CreateExerciseCommand(createExerciseDto));
        return Ok(result);
    }

    [HttpGet("categories")]
    [SwaggerResponse(StatusCodes.Status200OK, typeof(GetExerciseCategoryDto), Description = "Get Exercise categories")]
    public async Task<ActionResult<IEnumerable<GetExerciseCategoryDto>>> GetExerciseCategories()
    {
        logger.LogInformation("{@Name} request", nameof(GetExerciseCategories));
        var result = await Mediator.Send(new GetExerciseCategoriesQuery());
        return Ok(result);
    }

    [HttpDelete("{id}")]
    [SwaggerResponse(StatusCodes.Status200OK, typeof(GetExerciseDto), Description = "Delete Exercise")]
    public async Task<ActionResult<GetExerciseDto>> DeleteExercise(Guid id)
    {
        logger.LogInformation("{@Name} request : {@Id}", nameof(DeleteExercise), id);
        await Mediator.Send(new DeleteExerciseCommand(id));
        return Ok();
    }
}