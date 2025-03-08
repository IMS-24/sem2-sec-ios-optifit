using System.Net;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NSwag.Annotations;
using qb8s.net.OptiFit.Api.Services;
using qb8s.net.OptiFit.CQRS.Commands.User;
using qb8s.net.OptiFit.CQRS.Dtos.User;
using qb8s.net.OptiFit.CQRS.Queries.User;

namespace qb8s.net.OptiFit.Api.Controllers;

public class ProfileController(ILogger<ProfileController> logger, ICurrentUserService currentUserService)
    : ApiBaseController
{
    [HttpGet]
    [Authorize]
    [SwaggerResponse(HttpStatusCode.OK, typeof(UserProfileDto),
        Description = "Get User Profile")]
    public async Task<ActionResult<UserProfileDto>> GetUserProfile()
    {
        logger.LogInformation("{@Name} request", nameof(GetUserProfile));
        var userId = currentUserService.GetCurrentUserId();
        var result = await Mediator.Send(new GetUserProfileQuery(userId));
        return Ok(result);
    }

    [HttpGet("stats")]
    [Authorize]
    [SwaggerResponse(HttpStatusCode.OK, typeof(UserStatsDto), Description = "Get User Stats")]
    public async Task<ActionResult> GetUserStats()
    {
        logger.LogInformation("{@Name} request", nameof(GetUserStats));
        var stats = await Mediator.Send(new GetUserStatsQuery(currentUserService.GetCurrentUserId()));
        return Ok(stats);
    }

    [HttpDelete]
    [Authorize]
    [SwaggerResponse(HttpStatusCode.OK, typeof(void),
        Description = "Delete User Profile")]
    public async Task<ActionResult> DeleteUserProfile()
    {
        logger.LogInformation("{@Name} request", nameof(DeleteUserProfile));
        //TODO: Implement DeleteUserProfileCommand
        //await Mediator.Send(new DeleteUserProfileCommand(currentUserService.GetCurrentUserId()));
        return Ok();
    }

    [HttpPut]
    [Authorize]
    [SwaggerResponse(HttpStatusCode.OK, typeof(UserProfileDto),
        Description = "Update User Profile")]
    public async Task<ActionResult<UserProfileDto>> UpdateUserProfile(
        [FromBody] UpdateUserProfileDto update)
    {
        var userId = currentUserService.GetCurrentUserId();
        logger.LogInformation("{@Name} request", nameof(UpdateUserProfile));
        var result =
            await Mediator.Send(new UpdateUserProfileCommand(update, userId));
        return Ok(result);
    }

    [HttpPost("initialize")]
    [Authorize]
    [SwaggerResponse(HttpStatusCode.OK, typeof(UserProfileDto), Description = "Initialize User Profile")]
    public async Task<ActionResult<UserProfileDto>> InitializeUserProfile(
        [FromBody] InitializeUserProfileDto initializeUserProfile)
    {
        logger.LogInformation("{@Name} request", nameof(InitializeUserProfile));
        var result = await Mediator.Send(new InitializeUserProfileCommand(initializeUserProfile));
        return Ok(result);
    }
}