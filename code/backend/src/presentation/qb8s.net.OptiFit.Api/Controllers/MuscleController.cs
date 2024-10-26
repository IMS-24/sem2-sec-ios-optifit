using Microsoft.AspNetCore.Mvc;
using qb8s.net.OptiFit.CQRS.Dtos.Muscle;
using qb8s.net.OptiFit.CQRS.Queries.Muscle;

namespace qb8s.net.OptiFit.Api.Controllers;

public class MuscleController(ILogger<MuscleController> logger)
    : ApiBaseController
{
    [HttpPost("search")]
    // [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<AllergenDto>), Description = "Search Allergens")]
    public async Task<ActionResult<IEnumerable<MuscleDto>>> SearchMuscles([FromQuery] SearchMuscleDto search)
    {
        logger.LogInformation("Muscles search request");
        var result = await Mediator.Send(new SearchMusclesQuery(search));
        return Ok(result);
    }
}