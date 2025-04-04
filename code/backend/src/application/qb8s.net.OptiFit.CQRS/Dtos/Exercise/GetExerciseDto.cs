using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.ExerciseCategory;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class GetExerciseDto
{
    public Guid? Id { get; set; }
    public required string I18NCode { get; set; }
    public string? Description { get; set; }
    public GetExerciseCategoryDto ExerciseCategory { get; set; }

    public Guid ExerciseCategoryId { get; set; }
    public IList<GetExerciseMuscleMappingDto> MuscleMapping { get; set; } = new List<GetExerciseMuscleMappingDto>();
}

public class GetExerciseDtoProfile : BaseI18NProfile
{
    public GetExerciseDtoProfile()
    {
        CreateMap<Core.Entities.Exercise, GetExerciseDto>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.ExerciseCategory, opt => opt.MapFrom(src => src.ExerciseCategory))
            .ForMember(dest => dest.ExerciseCategoryId, opt => opt.MapFrom(src => src.ExerciseCategoryId))
            .ForMember(dest => dest.MuscleMapping, opt => opt.MapFrom(src => src.ExerciseMuscleMappings))
            ;
    }
}