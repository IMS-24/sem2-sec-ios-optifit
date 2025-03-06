using System.Net;
using Microsoft.AspNetCore.Mvc;
using NSwag.Annotations;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Dtos.Muscle;
using qb8s.net.OptiFit.CQRS.Queries.Muscle;

namespace qb8s.net.OptiFit.Api.Controllers;

public class MuscleController(ILogger<MuscleController> logger)
    : ApiBaseController
{
    [HttpPost("search")]
    [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<GetMuscleDto>), Description = "Search Muscles")]
    public async Task<ActionResult<PaginatedResult<GetMuscleDto>>> SearchMuscles([FromBody] SearchMuscleDto search)
    {
        logger.LogInformation("Muscles search request");
        var result = await Mediator.Send(new SearchMusclesQuery(search));
        return Ok(result);
    }
}