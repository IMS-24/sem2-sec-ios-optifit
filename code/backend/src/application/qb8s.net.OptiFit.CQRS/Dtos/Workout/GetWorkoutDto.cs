using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.WorkoutExercise;

namespace qb8s.net.OptiFit.CQRS.Dtos.Workout;

public class GetWorkoutDto : BaseDto
{
    public string Description { get; set; } = null!;
    public DateTimeOffset StartAtUtc { get; set; }
    public DateTimeOffset? EndAtUtc { get; set; }
    public string Notes { get; set; } = null!;
    public Guid GymId { get; set; }
    public IList<WorkoutExerciseDto> WorkoutExercises { get; set; } = new List<WorkoutExerciseDto>();
}

public class GetWorkoutDtoProfile : BaseProfile
{
    public GetWorkoutDtoProfile()
    {
        CreateMap<Core.Entities.Workout, GetWorkoutDto>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.StartAtUtc, opt => opt.MapFrom(src => src.StartAtUtc))
            .ForMember(dest => dest.EndAtUtc, opt => opt.MapFrom(src => src.EndAtUtc))
            .ForMember(dest => dest.Notes, opt => opt.MapFrom(src => src.Notes))
            .ForMember(dest => dest.GymId, opt => opt.MapFrom(src => src.GymId))
            .ForMember(dest => dest.WorkoutExercises, opt => opt.MapFrom(src => src.WorkoutExercises))
            ;
    }
}