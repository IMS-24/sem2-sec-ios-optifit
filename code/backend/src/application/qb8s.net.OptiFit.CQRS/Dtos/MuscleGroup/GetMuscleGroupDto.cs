using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.MuscleGroup;

public class GetMuscleGroupDto : BaseI18NDto
{
}

public class GetMuscleGroupDtoProfile : BaseI18NProfile
{
    public GetMuscleGroupDtoProfile()
    {
        CreateMap<Core.Entities.MuscleGroup, GetMuscleGroupDto>()
            ;
    }
}