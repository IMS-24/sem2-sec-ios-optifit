using System.Net;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NSwag.Annotations;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Dtos.MuscleGroupMapping;
using qb8s.net.OptiFit.CQRS.Queries.MuscleGroupMapping;

namespace qb8s.net.OptiFit.Api.Controllers;

public class MuscleGroupMappingController(ILogger<MuscleGroupMappingController> logger)
    : ApiBaseController
{
    [HttpPost("search")]
    [Authorize]
    [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<MuscleGroupMappingDto>),
        Description = "Search Muscle Group Mappings")]
    public async Task<ActionResult<PaginatedResult<MuscleGroupMappingDto>>> SearchMuscleGroupMappings(
        [FromBody] SearchMuscleGroupMappingDto search)
    {
        logger.LogInformation("{@Name} request", nameof(SearchMuscleGroupMappings));
        var result = await Mediator.Send(new SearchMuscleGroupMappingsQuery(search));
        return Ok(result);
    }
}