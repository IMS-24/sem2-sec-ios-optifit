using qb8s.net.OptiFit.CQRS.Dtos.Base;
using qb8s.net.OptiFit.CQRS.Dtos.MuscleGroup;

namespace qb8s.net.OptiFit.CQRS.Dtos.MuscleGroupMapping;

public class MuscleGroupMappingDto
{
    public Guid Id { get; set; }
    public Guid MuscleGroupId { get; set; }
    public GetMuscleGroupDto MuscleGroup { get; set; } = null!;
    public Guid MuscleId { get; set; }
}

public class MuscleGroupMappingDtoProfile : BaseProfile
{
    public MuscleGroupMappingDtoProfile()
    {
        CreateMap<Core.Entities.MuscleGroupMapping, MuscleGroupMappingDto>()
            .ForMember(dest => dest.MuscleId, opt => opt.MapFrom(src => src.MuscleId))
            .ForMember(dest => dest.MuscleGroupId, opt => opt.MapFrom(src => src.MuscleGroupId))
            .ForMember(dest => dest.MuscleGroup, opt => opt.MapFrom(src => src.MuscleGroup))
            ;
    }
}