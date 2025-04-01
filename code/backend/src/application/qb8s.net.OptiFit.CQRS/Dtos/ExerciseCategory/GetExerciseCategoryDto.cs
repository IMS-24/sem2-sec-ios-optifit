using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.ExerciseCategory;

public class GetExerciseCategoryDto
{
    public Guid Id { get; set; }
    public required string I18NCode { get; set; }
}

public class ExerciseCategoryDtoProfile : BaseI18NProfile
{
    public ExerciseCategoryDtoProfile()
    {
        CreateMap<Core.Entities.ExerciseCategory, GetExerciseCategoryDto>();
    }
}