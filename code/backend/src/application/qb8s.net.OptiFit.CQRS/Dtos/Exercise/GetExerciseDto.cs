using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class GetExerciseDto : BaseI18NDto
{
    public string? Description { get; set; }
    public string ExerciseCategory { get; set; }
    public Guid ExerciseCategoryId { get; set; }
}

public class GetExerciseDtoProfile : BaseI18NProfile
{
    public GetExerciseDtoProfile()
    {
        CreateMap<Core.Entities.Exercise, GetExerciseDto>()
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.ExerciseCategory, opt => opt.MapFrom(src => src.ExerciseCategory.I18NCode))
            .ForMember(dest => dest.ExerciseCategoryId, opt => opt.MapFrom(src => src.ExerciseCategoryId))
            ;
    }
}