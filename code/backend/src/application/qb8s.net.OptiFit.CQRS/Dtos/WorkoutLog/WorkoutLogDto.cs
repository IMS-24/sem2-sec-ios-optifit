using AutoMapper;
using qb8s.net.OptiFit.Core.Entities;

namespace qb8s.net.OptiFit.CQRS.Dtos.WorkoutLog;

public class WorkoutLogDto
{
    public int Order { get; set; }
    public Guid WorkoutId { get; set; }
    public Guid ExerciseId { get; set; }
    public Set Set { get; set; } = null!;
    public string Notes { get; set; } = null!;
}

public class WorkoutLogDtoProfile : Profile
{
    public WorkoutLogDtoProfile()
    {
        CreateMap<Core.Entities.WorkoutLog, WorkoutLogDto>()
            .ForMember(dest => dest.Notes, opt => opt.MapFrom(src => src.Notes))
            .ForMember(dest => dest.Order, opt => opt.MapFrom(src => src.Order))
            .ForMember(dest => dest.WorkoutId, opt => opt.MapFrom(src => src.WorkoutId))
            .ForMember(dest => dest.ExerciseId, opt => opt.MapFrom(src => src.ExerciseId))
            .ForMember(dest => dest.Set, opt => opt.MapFrom(src => src.Set))
            ;
    }
}