using AutoMapper;

namespace qb8s.net.OptiFit.CQRS.Dtos.User;

public class InitializeUserProfileDto
{
    public string FirstName { get; set; } = null!;
    public string LastName { get; set; } = null!;
    public Guid OId { get; set; }
    public string Email { get; set; } = null!;
    public DateTimeOffset DateOfBirthUtc { get; set; }
}

public class InitializeUserProfileDtoProfile : Profile
{
    public InitializeUserProfileDtoProfile()
    {
        CreateMap<InitializeUserProfileDto, Core.Entities.User>()
            .ForMember(dest => dest.FirstName, opt => opt.MapFrom(src => src.FirstName))
            .ForMember(dest => dest.LastName, opt => opt.MapFrom(src => src.LastName))
            .ForMember(dest => dest.Email, opt => opt.MapFrom(src => src.Email))
            .ForMember(dest => dest.OId, opt => opt.MapFrom(src => src.OId))
            .ForMember(dest => dest.DateOfBirthUtc, opt => opt.MapFrom(src => src.DateOfBirthUtc));
    }
}