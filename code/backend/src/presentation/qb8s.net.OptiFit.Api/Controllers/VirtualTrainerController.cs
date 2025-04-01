using System.Net;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NSwag.Annotations;
using qb8s.net.OptiFit.Api.Services;
using qb8s.net.OptiFit.CQRS.Queries.VirtualTrainer;

namespace qb8s.net.OptiFit.Api.Controllers;

public class GetMotivationDto
{
    public string Message { get; set; }
    public int TotalInsultCount { get; set; }
}

public class VirtualTrainerController(ILogger<VirtualTrainerController> logger, ICurrentUserService currentUserService)
    : ApiBaseController
{
    private static readonly Random RandomGenerator = new();

    private static readonly Dictionary<int, List<string>> InsultCategories = new()
    {
        {
            0, // 🔹 Level 0-5: Light teasing
            [
                "Oh look, another day of you doing absolutely nothing. Your couch must be so proud.",
                "If procrastination was a workout, you'd be shredded by now.",
                "You sweat more opening snack wrappers than you do at the gym.",
                "Lifting a protein shake to your mouth doesn’t count as a bicep curl.",
                "You treat workouts like an ex—avoiding them at all costs."
            ]
        },

        {
            5, // 🔥 Level 5-10: Moderate roasting
            [
                "Another missed workout? At this point, even your shadow is ashamed to be associated with you.",
                "Your weight chart looks like the stock market: all ups, no downs.",
                "At this rate, you'll have abs in the afterlife.",
                "Your gym membership is just a donation at this point.",
                "Motivation? Never met her. You and laziness, though, are BFFs."
            ]
        },

        {
            10, // ☠️ Level 10-15: Hardcore shaming
            [
                "Your ancestors hunted and fought to survive, and here you are, skipping leg day.",
                "Evolution must be so disappointed in you.",
                "Your future six-pack called. It said, 'Yeah, right.'",
                "I’d say I believe in you, but that would be a lie.",
                "At this rate, even a snail will lap you on your fitness journey."
            ]
        },

        {
            15, // 💀 Level 15-20: Savage beyond recovery
            [
                "The only thing you’re shredding is your self-esteem.",
                "Your reflection is probably scared of what it’s becoming.",
                "If effort was measured in calories, you’d still be in a deficit.",
                "You have the work ethic of a broken treadmill.",
                "Even AI-generated insults are more productive than your workouts."
            ]
        }
    };

    [HttpGet("motivation/{level:int}")]
    [SwaggerResponse(HttpStatusCode.OK, typeof(GetMotivationDto), Description = "Get Motivational Quote")]
    [Authorize]
    public async Task<ActionResult<GetMotivationDto>> GetMotivationalQuote(int level = 1)
    {
        logger.LogInformation("User '{UserId}' requested motivational quote at level '{Level}'",
            currentUserService.GetCurrentUserId(), level);
        /*var closestLevel = InsultCategories.Keys.OrderBy(x => Math.Abs(x - level)).FirstOrDefault();
        logger.LogDebug("Closest level found: '{ClosestLevel}'", closestLevel);
        if (!InsultCategories.TryGetValue(closestLevel, out var insults))
            return BadRequest(new { error = "Invalid level range. Try: 0, 5, 10, 15, etc." });
        var selectedInsult = insults.OrderBy(_ => RandomGenerator.Next()).FirstOrDefault();
        logger.LogDebug("Selected insult: '{Insult}'", selectedInsult);
        var dto = new UserInsultCountDto
        {
            UserId = currentUserService.GetCurrentUserId(),
            Message = selectedInsult!,
            TotalInsultCount = level
        };*/
        var dto = await Mediator.Send(new GetInsultQuery(level, currentUserService.GetCurrentUserId()));
        logger.LogInformation("Generated DTO: {@Dto}", dto);
        return Ok(dto);
    }
}