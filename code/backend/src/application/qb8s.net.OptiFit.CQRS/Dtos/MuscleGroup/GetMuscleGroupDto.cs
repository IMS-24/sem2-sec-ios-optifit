using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.MuscleGroup;

public class GetMuscleGroupDto
{
    public Guid? Id { get; set; }
    public required string I18NCode { get; set; }
}

public class GetMuscleGroupDtoProfile : BaseI18NProfile
{
    public GetMuscleGroupDtoProfile()
    {
        CreateMap<Core.Entities.MuscleGroup, GetMuscleGroupDto>()
            ;
    }
}