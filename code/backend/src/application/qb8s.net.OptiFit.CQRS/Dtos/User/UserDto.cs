using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.User;

public class UserProfileDto
{
    public Guid Id { get; set; }
    public string UserName { get; set; } = null!;
    public string Email { get; set; } = null!;
    public string FirstName { get; set; } = null!;
    public string LastName { get; set; } = null!;
    public string UserRole { get; set; } = null!;
    public DateTimeOffset? DateOfBirthUtc { get; set; }
    public DateTimeOffset? LastLoginUtc { get; set; }
    public DateTimeOffset RegisteredUtc { get; set; }
    public DateTimeOffset UpdatedUtc { get; set; }

    public bool InitialSetupDone { get; set; }
}

public class UserProfileDtoProfile : BaseProfile
{
    public UserProfileDtoProfile()
    {
        CreateMap<Core.Entities.User, UserProfileDto>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.UserName, opt => opt.MapFrom(src => src.UserName))
            .ForMember(dest => dest.Email, opt => opt.MapFrom(src => src.Email))
            .ForMember(dest => dest.FirstName, opt => opt.MapFrom(src => src.FirstName))
            .ForMember(dest => dest.LastName, opt => opt.MapFrom(src => src.LastName))
            .ForMember(dest => dest.UserRole, opt => opt.MapFrom(src => src.UserRole.Name))
            .ForMember(dest => dest.DateOfBirthUtc, opt => opt.MapFrom(src => src.DateOfBirthUtc))
            .ForMember(dest => dest.LastLoginUtc, opt => opt.MapFrom(src => src.LastLoginUtc))
            .ForMember(dest => dest.RegisteredUtc, opt => opt.MapFrom(src => src.RegisteredUtc))
            .ForMember(dest => dest.UpdatedUtc, opt => opt.MapFrom(src => src.UpdatedUtc))
            .ForMember(dest => dest.InitialSetupDone, opt => opt.MapFrom(src => src.InitialSetupDone))
            ;
    }
}