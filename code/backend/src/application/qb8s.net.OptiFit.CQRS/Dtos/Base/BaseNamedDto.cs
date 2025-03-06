using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.Base;

public class BaseNamedDto : BaseDto
{
    public required string Name { get; set; }
}

public class BaseNamedProfile : BaseProfile
{
    public BaseNamedProfile()
    {
        CreateMap<BaseNamedEntity, BaseNamedDto>()
            .ForMember(dst => dst.Name, opt => opt.MapFrom(src => src.Name));
    }
}