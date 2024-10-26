using AutoMapper;
using qb8s.net.OptiFit.Core.Entities.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.Base;

public class BaseDto
{
    public Guid? Id { get; set; }
}

public class BaseProfile : Profile
{
    public BaseProfile()
    {
        CreateMap<BaseEntity, BaseDto>()
            .ForMember(dst => dst.Id, opt => opt.MapFrom(src => src.Id));
    }
}