using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.Gym;
using qb8s.net.OptiFit.CQRS.Dtos.WorkoutExercise;

namespace qb8s.net.OptiFit.CQRS.Dtos.Workout;

public class GetWorkoutDto : BaseDto
{
    public string Description { get; set; } = null!;
    public DateTimeOffset StartAtUtc { get; set; }
    public DateTimeOffset? EndAtUtc { get; set; }
    public string Notes { get; set; } = null!;
    public Guid GymId { get; set; }
    public GetGymDto Gym { get; set; }
    public IList<WorkoutExerciseDto> WorkoutExercises { get; set; } = new List<WorkoutExerciseDto>();
    public WorkoutSummary WorkoutSummary { get; set; }
}

public class GetWorkoutDtoProfile : BaseProfile
{
    public GetWorkoutDtoProfile()
    {
        CreateMap<Core.Entities.Workout, WorkoutSummary>()
            .ForMember(dest => dest.TotalTime,
                opt => opt.MapFrom(src => src.EndAtUtc.HasValue
                    ? (int)(src.EndAtUtc.Value - src.StartAtUtc).TotalMinutes
                    : 0))
            .ForMember(dest => dest.TotalExercises,
                opt => opt.MapFrom(src => src.WorkoutExercises.Count))
            .ForMember(dest => dest.TotalSets,
                opt => opt.MapFrom(src => src.WorkoutExercises.Sum(we => we.WorkoutSets.Count)))
            .ForMember(dest => dest.TotalReps,
                opt => opt.MapFrom(src => src.WorkoutExercises.Sum(we => we.WorkoutSets.Sum(ws => ws.Reps))))
            // Assuming TotalWeight should be the sum of weight lifted (weight * reps) per set.
            .ForMember(dest => dest.TotalWeight,
                opt => opt.MapFrom(src =>
                    src.WorkoutExercises.Sum(we => we.WorkoutSets.Sum(ws => ws.Weight * ws.Reps))));


        CreateMap<Core.Entities.Workout, GetWorkoutDto>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.StartAtUtc, opt => opt.MapFrom(src => src.StartAtUtc))
            .ForMember(dest => dest.EndAtUtc, opt => opt.MapFrom(src => src.EndAtUtc))
            .ForMember(dest => dest.Notes, opt => opt.MapFrom(src => src.Notes))
            .ForMember(dest => dest.GymId, opt => opt.MapFrom(src => src.GymId))
            .ForMember(dest => dest.Gym, opt => opt.MapFrom(src => src.Gym))
            .ForMember(dest => dest.WorkoutExercises, opt => opt.MapFrom(src => src.WorkoutExercises))
            .ForMember(dest => dest.WorkoutSummary, opt => opt.MapFrom(src => src))
            ;
    }
}