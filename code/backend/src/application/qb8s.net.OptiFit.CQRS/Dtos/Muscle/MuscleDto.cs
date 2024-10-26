using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.Muscle;

public class MuscleDto : BaseI18NDto
{
    /*public IList<MuscleGroupFlatDto>? MuscleGroupDtos { get; set; }*/
}

public class MuscleDtoProfile : BaseI18NProfile
{
    public MuscleDtoProfile()
    {
        CreateMap<Core.Entities.Muscle, MuscleDto>()
            /*
            .ForMember(dst => dst.MuscleGroupDtos,
                opt => opt.MapFrom(src => src.MuscleGroupMappings.Select(x => x.MuscleGroup).ToList()));
    */
            ;
    }
}