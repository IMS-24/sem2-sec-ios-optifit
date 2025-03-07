using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.User;

public class UpdateUserProfileDto
{
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public string? Email { get; set; }
    public DateTimeOffset? DateOfBirthUtc { get; set; }
    public bool InitialSetupDone { get; set; }
}

public class UpdateUserProfileDtoProfile : BaseProfile
{
    public UpdateUserProfileDtoProfile()
    {
        CreateMap<UpdateUserProfileDto, Core.Entities.User>()
            .ForMember(dest => dest.FirstName, opt => opt.MapFrom(src => src.FirstName))
            .ForMember(dest => dest.LastName, opt => opt.MapFrom(src => src.LastName))
            .ForMember(dest => dest.Email, opt => opt.MapFrom(src => src.Email))
            .ForMember(dest => dest.DateOfBirthUtc,
                opt => opt.MapFrom(src => src.DateOfBirthUtc))
            .ForMember(dest => dest.InitialSetupDone, opt => opt.MapFrom(src => src.InitialSetupDone))
            ;
    }
}