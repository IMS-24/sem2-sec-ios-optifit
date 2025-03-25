using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.ExerciseCategory;

namespace qb8s.net.OptiFit.CQRS.Dtos.Exercise;

public class GetExerciseDto : BaseI18NDto
{
    public string? Description { get; set; }
    public GetExerciseCategoryDto ExerciseCategory { get; set; }

    public Guid ExerciseCategoryId { get; set; }
    // public IList<Guid> MuscleIds { get; set; } = new List<Guid>();
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
            ;
    }
}