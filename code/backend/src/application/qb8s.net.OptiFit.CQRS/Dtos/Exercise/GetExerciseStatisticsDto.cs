using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.WorkoutExercise;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class GetExerciseStatisticsDto
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public GetExerciseDto ExerciseDto { get; set; }
    public IList<ExerciseWorkoutDto> ExerciseWorkoutsDto { get; set; }
}

public class GetExerciseStatisticsDtoProfile : BaseProfile
{
    public GetExerciseStatisticsDtoProfile()
    {
        CreateMap<Core.Entities.Exercise, GetExerciseStatisticsDto>()
            //  .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.ExerciseDto, opt => opt.MapFrom(src => src))
            .ForMember(dest => dest.ExerciseWorkoutsDto, opt => opt.MapFrom(src => src.WorkoutExercises));
    }
}