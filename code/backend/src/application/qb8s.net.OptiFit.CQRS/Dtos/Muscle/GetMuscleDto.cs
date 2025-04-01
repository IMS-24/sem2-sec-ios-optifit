using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.Muscle;

public class GetMuscleDto
{
    public Guid? Id { get; set; }
    public required string I18NCode { get; set; }
}

public class GetMuscleDtoProfile : BaseI18NProfile
{
    public GetMuscleDtoProfile()
    {
        CreateMap<Core.Entities.Muscle, GetMuscleDto>();
    }
}