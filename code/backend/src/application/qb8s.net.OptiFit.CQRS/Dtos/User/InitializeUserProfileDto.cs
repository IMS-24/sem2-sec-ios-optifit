using AutoMapper;

namespace qb8s.net.OptiFit.CQRS.Dtos.User;

public class InitializeUserProfileDto
{
    public DateTimeOffset DateOfBirthUtc { get; set; }
}

public class InitializeUserProfileDtoProfile : Profile
{
    public InitializeUserProfileDtoProfile()
    {
        CreateMap<InitializeUserProfileDto, Core.Entities.User>()
            .ForMember(dest => dest.DateOfBirthUtc, opt => opt.MapFrom(src => src.DateOfBirthUtc));
    }
}