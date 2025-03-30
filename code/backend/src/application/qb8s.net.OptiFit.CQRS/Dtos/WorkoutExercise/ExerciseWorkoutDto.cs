using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.Workout;
using qb8s.net.OptiFit.CQRS.Dtos.WorkoutSet;

namespace qb8s.net.OptiFit.CQRS.Dtos.WorkoutExercise;

public class ExerciseWorkoutDto
{
    public Guid Id { get; set; }
    public int Order { get; set; }
    public GetWorkoutDto Workout { get; set; } = null!;
    public Guid ExerciseId { get; set; }
    public IEnumerable<GetWorkoutSetDto> WorkoutSets { get; set; } = null!;
    public string Notes { get; set; } = null!;
}

public class ExerciseWorkoutDtoProfile : BaseProfile
{
    public ExerciseWorkoutDtoProfile()
    {
        CreateMap<Core.Entities.WorkoutExercise, ExerciseWorkoutDto>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.Notes, opt => opt.MapFrom(src => src.Notes))
            .ForMember(dest => dest.Order, opt => opt.MapFrom(src => src.Order))
            .ForMember(dest => dest.Workout, opt => opt.MapFrom(src => src.Workout))
            .ForMember(dest => dest.ExerciseId, opt => opt.MapFrom(src => src.Exercise.Id))
            .ForMember(dest => dest.WorkoutSets, opt => opt.MapFrom(src => src.WorkoutSets))
            ;
    }
}