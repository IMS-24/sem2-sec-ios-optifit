using AutoMapper;
using qb8s.net.OptiFit.CQRS.Dtos.WorkoutLog;

namespace qb8s.net.OptiFit.CQRS.Dtos.Workout;

public class WorkoutDto
{
    public Guid UserId { get; set; }
    public DateTime StartAtUtc { get; set; }
    public DateTime? EndAtUtc { get; set; }
    public string Notes { get; set; } = null!;
    public Guid GymId { get; set; }
    public IList<WorkoutLogDto> WorkoutLogs { get; set; }
}

public class WorkoutDtoProfile : Profile
{
    public WorkoutDtoProfile()
    {
        CreateMap<Core.Entities.Workout, WorkoutDto>()
            .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.UserId))
            .ForMember(dest => dest.StartAtUtc, opt => opt.MapFrom(src => src.StartAtUtc))
            .ForMember(dest => dest.EndAtUtc, opt => opt.MapFrom(src => src.EndAtUtc))
            .ForMember(dest => dest.Notes, opt => opt.MapFrom(src => src.Notes))
            .ForMember(dest => dest.GymId, opt => opt.MapFrom(src => src.GymId))
            .ForMember(dest => dest.WorkoutLogs, opt => opt.MapFrom(src => src.WorkoutLogs))
            ;
    }
}