using System.Net;
using Microsoft.AspNetCore.Mvc;
using NSwag.Annotations;
using qb8s.net.OptiFit.CQRS.Commands.User;
using qb8s.net.OptiFit.CQRS.Dtos.User;
using qb8s.net.OptiFit.CQRS.Queries.User;

namespace qb8s.net.OptiFit.Api.Controllers;

public class ProfileController(ILogger<ProfileController> logger)
    : ApiBaseController
{
    [HttpGet]
    [SwaggerResponse(HttpStatusCode.OK, typeof(UserProfileDto),
        Description = "Get User Profile")]
    public async Task<ActionResult<UserProfileDto>> GetUserProfile()
    {
        logger.LogInformation("{@Name} request", nameof(GetUserProfile));
        var result = await Mediator.Send(new GetUserProfileQuery(new Guid("275cfdca-c686-4ea1-80b1-f2425b1602c5")));
        return Ok(result);
    }

    [HttpGet("stats")]
    [SwaggerResponse(HttpStatusCode.OK, typeof(UserStatsDto), Description = "Get User Stats")]
    public async Task<ActionResult> GetUserStats()
    {
        logger.LogInformation("{@Name} request", nameof(GetUserStats));
        var stats = await Mediator.Send(new GetUserStatsQuery(new Guid("275cfdca-c686-4ea1-80b1-f2425b1602c5")));
        return Ok(stats);
    }

    [HttpDelete]
    [SwaggerResponse(HttpStatusCode.OK, typeof(void),
        Description = "Delete User Profile")]
    public async Task<ActionResult> DeleteUserProfile()
    {
        logger.LogInformation("{@Name} request", nameof(DeleteUserProfile));
        //TODO: Implement DeleteUserProfileCommand
        //await Mediator.Send(new DeleteUserProfileCommand(new Guid("275cfdca-c686-4ea1-80b1-f2425b1602c5")));
        return Ok();
    }

    [HttpPut]
    [SwaggerResponse(HttpStatusCode.OK, typeof(UserProfileDto),
        Description = "Update User Profile")]
    public async Task<ActionResult<UserProfileDto>> UpdateUserProfile(
        [FromBody] UpdateUserProfileDto update)
    {
        logger.LogInformation("{@Name} request", nameof(UpdateUserProfile));
        var result =
            await Mediator.Send(new UpdateUserProfileCommand(update, new Guid("275cfdca-c686-4ea1-80b1-f2425b1602c5")));
        return Ok(result);
    }
}