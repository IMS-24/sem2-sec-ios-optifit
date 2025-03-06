using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;
using qb8s.net.OptiFit.CQRS.Dtos.WorkoutSet;

namespace qb8s.net.OptiFit.CQRS.Dtos.WorkoutExercise;

public class WorkoutExerciseDto : BaseDto
{
    public int Order { get; set; }
    public Guid WorkoutId { get; set; }
    public GetExerciseDto Exercise { get; set; } = null!;
    public IEnumerable<GetWorkoutSetDto> WorkoutSets { get; set; } = null!;
    public string Notes { get; set; } = null!;
}

public class WorkoutExerciseDtoProfile : BaseProfile
{
    public WorkoutExerciseDtoProfile()
    {
        CreateMap<Core.Entities.WorkoutExercise, WorkoutExerciseDto>()
            .ForMember(dest => dest.Notes, opt => opt.MapFrom(src => src.Notes))
            .ForMember(dest => dest.Order, opt => opt.MapFrom(src => src.Order))
            .ForMember(dest => dest.WorkoutId, opt => opt.MapFrom(src => src.WorkoutId))
            .ForMember(dest => dest.Exercise, opt => opt.MapFrom(src => src.Exercise))
            .ForMember(dest => dest.WorkoutSets, opt => opt.MapFrom(src => src.WorkoutSets))
            ;
    }
}