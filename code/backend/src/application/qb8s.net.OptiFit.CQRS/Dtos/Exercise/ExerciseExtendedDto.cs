using AutoMapper;
using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class ExerciseExtendedDto : BaseI18NDto
{
    public string Description { get; set; } = null!;
    public string ExerciseCategory { get; set; }
}

public class ExerciseExtendedDtoProfile : Profile
{
    public ExerciseExtendedDtoProfile()
    {
        CreateMap<Core.Entities.Exercise, ExerciseExtendedDto>()
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.ExerciseCategory, opt => opt.MapFrom(src => src.ExerciseCategory.I18NCode))
            ;
    }
}