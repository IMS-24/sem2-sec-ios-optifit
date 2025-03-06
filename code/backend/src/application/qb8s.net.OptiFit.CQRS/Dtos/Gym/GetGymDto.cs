using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.Gym;

public class GetGymDto : BaseNamedDto
{
    public string? Address { get; set; }
    public string? City { get; set; }
    public int? ZipCode { get; set; }
}

public class GymDtoProfile : BaseNamedProfile
{
    public GymDtoProfile()
    {
        CreateMap<Core.Entities.Gym, GetGymDto>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.Address, opt => opt.MapFrom(src => src.Address))
            .ForMember(dest => dest.City, opt => opt.MapFrom(src => src.City))
            .ForMember(dest => dest.ZipCode, opt => opt.MapFrom(src => src.ZipCode))
            ;
    }
}