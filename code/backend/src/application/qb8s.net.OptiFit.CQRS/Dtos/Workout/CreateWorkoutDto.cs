using AutoMapper;
using qb8s.net.OptiFit.CQRS.Dtos.Exercise;

namespace qb8s.net.OptiFit.CQRS.Dtos.Workout;

public class CreateWorkoutDto
{
    public Guid? Id { get; set; }
    public string? Description { get; set; } = null!;
    public DateTimeOffset StartAtUtc { get; set; }
    public DateTimeOffset? EndAtUtc { get; set; }
    public string? Notes { get; set; } = null!;
    public Guid GymId { get; set; }
    public IList<CreateWorkoutExerciseDto> WorkoutExercises { get; set; } = new List<CreateWorkoutExerciseDto>();
}

public class CreateWorkoutDtoProfile : Profile
{
    public CreateWorkoutDtoProfile()
    {
        CreateMap<CreateWorkoutDto, Core.Entities.Workout>()
            .ForMember(dest => dest.Id, opt => opt.Ignore())
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.GymId, opt => opt.MapFrom(src => src.GymId))
            .ForMember(dest => dest.StartAtUtc, opt => opt.MapFrom(src => src.StartAtUtc))
            .ForMember(dest => dest.EndAtUtc, opt => opt.MapFrom(src => src.EndAtUtc))
            .ForMember(dest => dest.Notes, opt => opt.MapFrom(src => src.Notes))
            .ForMember(dest => dest.WorkoutExercises, opt => opt.MapFrom(src => src.WorkoutExercises))
            .ForMember(dest => dest.User, opt => opt.Ignore())
            .ForMember(dest => dest.Gym, opt => opt.Ignore())
            ;
    }
}

public class CreateWorkoutExerciseDto
{
    public Guid Id { get; set; }
    public int Order { get; set; }
    public GetExerciseDto Exercise { get; set; }
    public string? Notes { get; set; } = null!;
    public IList<CreateWorkoutSetDto> WorkoutSets { get; set; } = new List<CreateWorkoutSetDto>();
}

public class CreateWorkoutExerciseProfile : Profile
{
    public CreateWorkoutExerciseProfile()
    {
        CreateMap<CreateWorkoutExerciseDto, Core.Entities.WorkoutExercise>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.Notes, opt => opt.MapFrom(src => src.Notes))
            .ForMember(dest => dest.Order, opt => opt.MapFrom(src => src.Order))
            .ForMember(dest => dest.ExerciseId, opt => opt.MapFrom(src => src.Exercise.Id))
            .ForMember(dest => dest.WorkoutSets, opt => opt.MapFrom(src => src.WorkoutSets))
            .ForMember(dest => dest.Exercise, opt => opt.Ignore())
            ;
    }
}

public class CreateWorkoutSetDto
{
    public Guid Id { get; set; }
    public int Order { get; set; }
    public int Reps { get; set; }
    public decimal Weight { get; set; }
}

public class CreateWorkoutSetDtoProfile : Profile
{
    public CreateWorkoutSetDtoProfile()
    {
        CreateMap<CreateWorkoutSetDto, Core.Entities.WorkoutSet>()
            .ForMember(dest => dest.Order, opt => opt.MapFrom(src => src.Order))
            .ForMember(dest => dest.Reps, opt => opt.MapFrom(src => src.Reps))
            .ForMember(dest => dest.Weight, opt => opt.MapFrom(src => src.Weight))
            ;
    }
}