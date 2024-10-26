using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace qb8s.net.OptiFit.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ApiBaseController : ControllerBase
{
    private ISender? _mediator;
    protected ISender Mediator => _mediator ??= HttpContext.RequestServices.GetService<ISender>()!;
}