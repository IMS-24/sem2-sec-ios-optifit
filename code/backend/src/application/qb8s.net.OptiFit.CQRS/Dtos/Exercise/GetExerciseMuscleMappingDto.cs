using qb8s.net.OptiFit.Core.Entities;
using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.Muscle;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class GetExerciseMuscleMappingDto
{
    public Guid Id { get; set; }
    public Guid ExerciseId { get; set; }
    public Guid MuscleId { get; set; }
    public GetMuscleDto MuscleDto { get; set; }
    public int? Intensity { get; set; }
}

public class GetExerciseMuscleMappingDtoProfile : BaseProfile
{
    public GetExerciseMuscleMappingDtoProfile()
    {
        CreateMap<ExerciseMuscleMapping, GetExerciseMuscleMappingDto>()
            .ForMember(dest => dest.ExerciseId, opt => opt.MapFrom(src => src.ExerciseId))
            .ForMember(dest => dest.MuscleId, opt => opt.MapFrom(src => src.MuscleId))
            .ForMember(dest => dest.Intensity, opt => opt.MapFrom(src => src.Intensity))
            .ForMember(dest => dest.MuscleDto, opt => opt.MapFrom(src => src.Muscle));
    }
}