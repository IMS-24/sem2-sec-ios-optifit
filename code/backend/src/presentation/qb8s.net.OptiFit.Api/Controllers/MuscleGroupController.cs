using Microsoft.AspNetCore.Mvc;
using qb8s.net.OptiFit.CQRS.Dtos.MuscleGroup;
using qb8s.net.OptiFit.CQRS.Queries.MuscleGroup;

namespace qb8s.net.OptiFit.Api.Controllers;

public class MuscleGroupController(ILogger<MuscleGroupController> logger)
    : ApiBaseController
{
    [HttpPost("search")]
    // [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<AllergenDto>), Description = "Search Allergens")]
    public async Task<ActionResult<IEnumerable<MuscleGroupDto>>> SearchMuscleGroups(
        [FromQuery] SearchMuscleGroupDto search)
    {
        logger.LogInformation("Muscles search request");
        var result = await Mediator.Send(new SearchMuscleGroupsQuery(search));
        return Ok(result);
    }
}