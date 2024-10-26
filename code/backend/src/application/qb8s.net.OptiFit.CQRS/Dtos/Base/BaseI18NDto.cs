using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.Base;

public class BaseI18NDto : BaseDto
{
    public required string I18NCode { get; set; }
}

public class BaseI18NProfile : BaseProfile
{
    public BaseI18NProfile()
    {
        CreateMap<BaseI18NEntity, BaseI18NDto>()
            .ForMember(dst => dst.I18NCode, opt => opt.MapFrom(src => src.I18NCode));
    }
}