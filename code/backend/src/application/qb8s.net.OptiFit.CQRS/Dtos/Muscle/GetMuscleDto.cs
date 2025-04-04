using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.MuscleGroupMapping;

namespace qb8s.net.OptiFit.CQRS.Dtos.Muscle;

public class GetMuscleDto
{
    public Guid? Id { get; set; }
    public required string I18NCode { get; set; }
    public IList<MuscleGroupMappingDto> GroupMapping { get; set; } = new List<MuscleGroupMappingDto>();
}

public class GetMuscleDtoProfile : BaseI18NProfile
{
    public GetMuscleDtoProfile()
    {
        CreateMap<Core.Entities.Muscle, GetMuscleDto>()
            .ForMember(dest => dest.GroupMapping, opt => opt.MapFrom(src => src.MuscleGroupMappings));
    }
}