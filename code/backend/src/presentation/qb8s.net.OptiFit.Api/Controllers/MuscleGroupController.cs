using System.Net;
using Microsoft.AspNetCore.Mvc;
using NSwag.Annotations;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Dtos.MuscleGroup;
using qb8s.net.OptiFit.CQRS.Queries.MuscleGroup;

namespace qb8s.net.OptiFit.Api.Controllers;

public class MuscleGroupController(ILogger<MuscleGroupController> logger)
    : ApiBaseController
{
    [HttpPost("search")]
    [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<GetMuscleGroupDto>),
        Description = "Search Muscle Groups")]
    public async Task<ActionResult<PaginatedResult<GetMuscleGroupDto>>> SearchMuscleGroups(
        [FromBody] SearchMuscleGroupDto search)
    {
        logger.LogInformation("Muscles search request");
        var result = await Mediator.Send(new SearchMuscleGroupsQuery(search));
        return Ok(result);
    }
}