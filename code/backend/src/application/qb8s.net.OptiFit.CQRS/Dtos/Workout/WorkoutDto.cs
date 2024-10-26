using AutoMapper;
using qb8s.net.OptiFit.CQRS.Dtos.WorkoutLog;

namespace qb8s.net.OptiFit.CQRS.Dtos.Workout;

public class WorkoutDto
{
    public Guid Id { get; set; }
    public string Description { get; set; } = null!;
    public Guid UserId { get; set; }
    public string UserName { get; set; } = null!;
    public DateTime StartAtUtc { get; set; }
    public DateTime? EndAtUtc { get; set; }
    public string Notes { get; set; } = null!;
    public Guid GymId { get; set; }
    public string Gym { get; set; } = null!;
    public IList<WorkoutLogDto> WorkoutLogs { get; set; } = new List<WorkoutLogDto>();
}

public class WorkoutDtoProfile : Profile
{
    public WorkoutDtoProfile()
    {
        CreateMap<Core.Entities.Workout, WorkoutDto>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.UserId))
            .ForMember(dest => dest.UserName, opt => opt.MapFrom(src => src.User.UserName))
            .ForMember(dest => dest.StartAtUtc, opt => opt.MapFrom(src => src.StartAtUtc))
            .ForMember(dest => dest.EndAtUtc, opt => opt.MapFrom(src => src.EndAtUtc))
            .ForMember(dest => dest.Notes, opt => opt.MapFrom(src => src.Notes))
            .ForMember(dest => dest.GymId, opt => opt.MapFrom(src => src.GymId))
            .ForMember(dest => dest.Gym, opt => opt.MapFrom(src => src.Gym.Name))
            .ForMember(dest => dest.WorkoutLogs, opt => opt.MapFrom(src => src.WorkoutLogs))
            ;
    }
}