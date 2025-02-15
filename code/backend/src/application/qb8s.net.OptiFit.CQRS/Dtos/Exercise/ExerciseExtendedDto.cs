using AutoMapper;
using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.Muscle;
using qb8s.net.OptiFit.CQRS.Dtos.MuscleGroup;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class ExerciseExtendedDto : BaseI18NDto
{
    public string Description { get; set; } = null!;
    public IList<MuscleGroupExtendedDto>? MuscleGroups { get; set; } = new List<MuscleGroupExtendedDto>();
    public IList<MuscleExtendedDto> Muscles { get; set; } = new List<MuscleExtendedDto>();
    public string ExerciseType { get; set; }
}

public class ExerciseExtendedDtoProfile : Profile
{
    public ExerciseExtendedDtoProfile()
    {
        CreateMap<Core.Entities.Exercise, ExerciseExtendedDto>()
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.Muscles,
                opt => opt.MapFrom(src => src.ExerciseMuscleMappings.Select(x => x.Muscle)))
            .ForMember(dest => dest.MuscleGroups,
                opt => opt.MapFrom(src => src.ExerciseMuscleGroupMappings.Select(x => x.MuscleGroup)))
            .ForMember(dest => dest.ExerciseType, opt => opt.MapFrom(src => src.ExerciseType.I18NCode))
            ;
    }
}