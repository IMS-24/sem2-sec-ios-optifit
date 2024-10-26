using AutoMapper;
using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.Muscle;
using qb8s.net.OptiFit.CQRS.Dtos.MuscleGroup;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class ExerciseExtendedDto : BaseI18NDto
{
    public string Description { get; set; } = null!;
    public IList<MuscleGroupExtendedDto>? MuscleGroupDtos { get; set; } = new List<MuscleGroupExtendedDto>();
    public IList<MuscleExtendedDto> MuscleDtos { get; set; } = new List<MuscleExtendedDto>();
}

public class ExerciseExtendedDtoProfile : Profile
{
    public ExerciseExtendedDtoProfile()
    {
        CreateMap<Core.Entities.Exercise, ExerciseExtendedDto>()
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.MuscleDtos,
                opt => opt.MapFrom(src => src.ExerciseMuscleMappings.Select(x => x.Muscle)))
            .ForMember(dest => dest.MuscleGroupDtos,
                opt => opt.MapFrom(src => src.ExerciseMuscleGroupMappings.Select(x => x.MuscleGroup)));
    }
}