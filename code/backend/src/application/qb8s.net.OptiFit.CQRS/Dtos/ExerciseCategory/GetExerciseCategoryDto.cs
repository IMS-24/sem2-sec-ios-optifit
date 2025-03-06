using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.ExerciseCategory;

public class GetExerciseCategoryDto : BaseI18NDto
{
}

public class ExerciseCategoryDtoProfile : BaseI18NProfile
{
    public ExerciseCategoryDtoProfile()
    {
        CreateMap<Core.Entities.ExerciseCategory, GetExerciseCategoryDto>();
    }
}