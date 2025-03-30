using qb8s.net.OptiFit.CQRS.Dtos.Base;

namespace qb8s.net.OptiFit.CQRS.Dtos.MuscleGroup;

public class CreateMuscleGroupDto
{
    public Guid? Id { get; set; }

    public required string I18NCode { get; set; }
    // public IList<MuscleDto>? MuscleDtos { get; set; }
}

public class MuscleGroupProfile : BaseI18NProfile
{
    public MuscleGroupProfile()
    {
        CreateMap<Core.Entities.MuscleGroup, CreateMuscleGroupDto>()
            /*.ForMember(dst => dst.MuscleDtos,
                opt => opt.MapFrom(src => src.MuscleGroupMappings.Select(x => x.Muscle).ToList()))
            */
            ;
    }
}