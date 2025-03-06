using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.MuscleGroupMapping;

public class MuscleGroupMappingDto : BaseDto
{
    public Guid MuscleGroupId { get; set; }
    public Guid MuscleId { get; set; }
}

public class MuscleGroupMappingDtoProfile : BaseProfile
{
    public MuscleGroupMappingDtoProfile()
    {
        CreateMap<Core.Entities.MuscleGroupMapping, MuscleGroupMappingDto>()
            .ForMember(dest => dest.MuscleId, opt => opt.MapFrom(src => src.MuscleId))
            .ForMember(dest => dest.MuscleGroupId, opt => opt.MapFrom(src => src.MuscleGroupId))
            ;
    }
}