using AutoMapper;
using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.MuscleGroup;

namespace qb8s.net.OptiFit.CQRS.Dtos.Muscle;

public class MuscleExtendedDto : BaseI18NDto
{
    public IList<MuscleGroupDto>? MuscleGroups { get; set; }
}

public class MuscleExtendedDtoProfile : Profile
{
    public MuscleExtendedDtoProfile()
    {
        CreateMap<Core.Entities.Muscle, MuscleExtendedDto>()
            .ForMember(dst => dst.MuscleGroups,
                opt => opt.MapFrom(src => src.MuscleGroupMappings.Select(x => x.MuscleGroup).ToList()))
            ;
    }
}