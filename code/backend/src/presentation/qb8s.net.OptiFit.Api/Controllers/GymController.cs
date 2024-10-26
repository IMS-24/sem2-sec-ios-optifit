using System.Net;
using Microsoft.AspNetCore.Mvc;
using NSwag.Annotations;
using qb8s.net.OptiFit.Core.Pagination;
using qb8s.net.OptiFit.CQRS.Commands.Gym;
using qb8s.net.OptiFit.CQRS.Dtos.Gym;
using qb8s.net.OptiFit.CQRS.Queries.Gym;

namespace qb8s.net.OptiFit.Api.Controllers;

public class GymController(ILogger<GymController> logger) : ApiBaseController
{
    [HttpPost("search")]
    [SwaggerResponse(HttpStatusCode.OK, typeof(PaginatedResult<GymDto>), Description = "Search Gyms")]
    public async Task<ActionResult<PaginatedResult<GymDto>>> SearchGyms([FromBody] SearchGymsDto search)
    {
        logger.LogInformation("Gyms search request");
        var result = await Mediator.Send(new SearchGymsQuery(search));
        return Ok(result);
    }

    [HttpPost]
    [SwaggerResponse(StatusCodes.Status200OK, typeof(GymDto), Description = "Create Gym")]
    public async Task<ActionResult<GymDto>> CreateGym([FromBody] CreateGymDto createGymDto)
    {
        logger.LogInformation("Create Gym request : {@Dto}", createGymDto);
        var result = await Mediator.Send(new CreateGymCommand(createGymDto));
        return Ok(result);
    }
}