using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.Muscle;

public class GetMuscleDto : BaseI18NDto
{
}

public class GetMuscleDtoProfile : BaseI18NProfile
{
    public GetMuscleDtoProfile()
    {
        CreateMap<Core.Entities.Muscle, GetMuscleDto>()
            ;
    }
}