using AutoMapper;
using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.Muscle;

namespace qb8s.net.OptiFit.CQRS.Dtos.MuscleGroup;

public class MuscleGroupExtendedDto : BaseI18NDto
{
    public IList<MuscleDto>? Muscles { get; set; }
}

public class MuscleGroupFlatProfile : Profile
{
    public MuscleGroupFlatProfile()
    {
        CreateMap<Core.Entities.MuscleGroup, MuscleGroupExtendedDto>()
            .ForMember(dst => dst.Muscles,
                opt => opt.MapFrom(src => src.MuscleGroupMappings.Select(x => x.Muscle).ToList()))
            ;
    }
}