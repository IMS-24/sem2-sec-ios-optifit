using AutoMapper;

namespace qb8s.net.OptiFit.CQRS.Dtos.Workout;

public class CreateWorkoutDto
{
    public string? Description { get; set; } = null!;
    public Guid UserId { get; set; }
    public DateTime StartAtUtc { get; set; }
    public DateTime? EndAtUtc { get; set; }
    public string? Notes { get; set; } = null!;
    public Guid GymId { get; set; }
}

public class CreateWorkoutDtoProfile : Profile
{
    public CreateWorkoutDtoProfile()
    {
        CreateMap<CreateWorkoutDto, Core.Entities.Workout>()
            .ForMember(dest => dest.Id, opt => opt.Ignore())
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.GymId, opt => opt.MapFrom(src => src.GymId))
            .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.UserId))
            .ForMember(dest => dest.StartAtUtc, opt => opt.MapFrom(src => src.StartAtUtc))
            .ForMember(dest => dest.EndAtUtc, opt => opt.MapFrom(src => src.EndAtUtc))
            .ForMember(dest => dest.Notes, opt => opt.MapFrom(src => src.Notes))
            .ForMember(dest => dest.WorkoutLogs, opt => opt.Ignore())
            .ForMember(dest => dest.User, opt => opt.Ignore())
            .ForMember(dest => dest.Gym, opt => opt.Ignore())
            ;
    }
}